//
//  StoreManager.m
//  Baker
//
//  Created by Tope on 22/06/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, \
NSUserDomainMask, YES) objectAtIndex:0]

//#define kFreeSubscription @"advnewsstand.subscription.paid"
//#define kFreeSubscriptionReceiptId @"advnewsstand.subscription.receipt"

#import "StoreManager.h"
#import "AppDelegate.h"


@implementation StoreManager


-(BOOL)isSubscribedToContent:(NSString*)inAppPurchaseId;
{
    if(inAppPurchaseId){
        id receipt = [[NSUserDefaults standardUserDefaults] objectForKey:inAppPurchaseId];
        return (receipt != nil);
    }
    return NO;
}


-(void)fetchProductInfoWithIds:(NSSet*)productIds
{
    
    if(self.purchasing == YES) {
        return;
    }
    self.purchasing=YES;
    
    SKProductsRequest *productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIds];
    
    productsRequest.delegate=self;
    [productsRequest start];
}

-(void)requestDidFinish:(SKRequest *)request {
    self.purchasing = NO;
    NSLog(@"Request: %@",request);
}

-(void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.purchasing = NO;
    NSLog(@"Request %@ failed with error %@",request,error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
    [alert show];
    
    [self.delegate didFetchProductInfos:nil withSuccess:NO];
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    
    [self.delegate didFetchProductInfos:response.products withSuccess:YES];
}

-(void)subscribeToProduct:(SKProduct *)product{
    
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    
    for(SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStateFailed:
                [self errorWithTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                break;
            case SKPaymentTransactionStatePurchased:
            case SKPaymentTransactionStateRestored:
                [self finishedTransaction:transaction];
                break;
            default:
                break;
        }
    }
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    NSLog(@"Restored all completed transactions");
}

-(void)finishedTransaction:(SKPaymentTransaction *)transaction {
    NSLog(@"Finished transaction");
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
   
    // save receipt
    [[NSUserDefaults standardUserDefaults] setObject:transaction.transactionIdentifier forKey:transaction.payment.productIdentifier];
    // check receipt
    [self checkReceipt:transaction.transactionReceipt];
    
    [self.delegate subscriptionCompletedWith:YES forInAppPurchaseId:transaction.payment.productIdentifier];
}

-(void)errorWithTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Subscription failure"
                                                    message:[transaction.error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"Close"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self.delegate subscriptionCompletedWith:NO forInAppPurchaseId:transaction.payment.productIdentifier];
}

-(void)checkReceipt:(NSData *)receipt {
    // save receipt
    NSString *receiptStorageFile = [DocumentsDirectory stringByAppendingPathComponent:@"receipts.plist"];
    NSMutableArray *receiptStorage = [[NSMutableArray alloc] initWithContentsOfFile:receiptStorageFile];
    if(!receiptStorage) {
        receiptStorage = [[NSMutableArray alloc] init];
    }
    [receiptStorage addObject:receipt];
    [receiptStorage writeToFile:receiptStorageFile atomically:YES];
}

/*
- (void)requestProUpgradeProductData
{
    NSSet *productIdentifiers = [NSSet setWithObject:@"com.runmonster.runmonsterfree.upgradetopro" ];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    
    // we will release the request object in the delegate callback
}

#pragma mark -
#pragma mark SKProductsRequestDelegate methods

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *products = response.products;
    proUpgradeProduct = [products count] == 1 ? [[products firstObject] retain] : nil;
    if (proUpgradeProduct)
    {
        NSLog(@"Product title: %@" , proUpgradeProduct.localizedTitle);
        NSLog(@"Product description: %@" , proUpgradeProduct.localizedDescription);
        NSLog(@"Product price: %@" , proUpgradeProduct.price);
        NSLog(@"Product id: %@" , proUpgradeProduct.productIdentifier);
    }
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    // finally release the reqest we alloc/init’ed in requestProUpgradeProductData
    [productsRequest release];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsFetchedNotification object:self userInfo:nil];
}
*/
@end
