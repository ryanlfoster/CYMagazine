//
//  ViewController.m
//  ADVNewsstandTemplate
//
//  Created by Tope on 07/03/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "IssuesGridViewController.h"
#import "IssueCell.h"
#import "IssueCellHeader.h"
#import "Repository.h"
#import "ReaderDocument.h"
#import "SSZipArchive.h"
#import "IssueCellProtocol.h"
#import "ADVTheme.h"
#import "MagazinePageViewController.h"


@interface IssuesGridViewController ()

@property (nonatomic, strong) SKProduct* subscriptionProduct;

@end

@implementation IssuesGridViewController

- (void)viewDidLoad
{
    self.publisher = [[AppDelegate instance] publisher];
    self.repository = [[AppDelegate instance] repository];
    self.storeManager = [[AppDelegate instance] storeManager];
    
    id<ADVTheme> theme = [AppDelegate instance].theme;
    
    UINib *cellNib = [UINib nibWithNibName:[theme cellNibName] bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"IssueCell"];
    
    UINib *headerNib = [UINib nibWithNibName:@"IssueCellHeader" bundle:nil];
    [self.collectionView registerNib:headerNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"IssueCellHeader"];
    
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self.collectionView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    [self loadIssues];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadIssues) name:@"com.advnewsstand.returnFromBackground" object:nil];
    
    UIBarButtonItem* trashButton =[[UIBarButtonItem alloc] initWithTitle:@"Delete all downloads" style:UIBarButtonItemStyleBordered target:self action:@selector(trashContent)];
    [trashButton setStyle:UIBarButtonItemStyleBordered];
    
    [self.navigationItem setLeftBarButtonItem:trashButton];
    
    UIBarButtonItem* restoreButton =[[UIBarButtonItem alloc] initWithTitle:@"Restore Purchases" style:UIBarButtonItemStyleBordered target:self action:@selector(restorePurchases)];
    [restoreButton setStyle:UIBarButtonItemStyleBordered];
    [self.navigationItem setRightBarButtonItem:restoreButton];
    
    self.title = @"Issues";
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.publisher numberOfIssues];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = (IssueCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"IssueCell" forIndexPath:indexPath];
    
    
    IssueInfo *issueInfo = [self.publisher issueAtIndex:indexPath.row];
    
    id<IssueCellProtocol> cellProtocol = (id<IssueCellProtocol>)cell;
    cellProtocol.issueInfo = issueInfo;
    
    [issueInfo loadCoverImageFromPublisher:self.publisher];
    
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    BOOL userIsSusbcribedToTheMagazine = [self.storeManager isSubscribedToContent:[self.repository inAppPurchaseSubscriptionId]];
    
    if (kind == UICollectionElementKindSectionHeader && !userIsSusbcribedToTheMagazine) {
        
        IssueCellHeader* headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"IssueCellHeader" forIndexPath:indexPath];
        
        headerView.subscribeInfoLabel.text = [self.repository getSubscriptionText];
        headerView.delegate = self;
        
        return headerView;
    }
    
    return nil;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    
    IssueInfo* info = [self.publisher issueAtIndex:index];
    Repository* repo = [AppDelegate instance].repository;
    
    BOOL userIsSuscribedToMagazine = [self.storeManager isSubscribedToContent:[repo inAppPurchaseSubscriptionId]];
    
    BOOL userIsSubscribedToCurrentIssue = (info.isFreeContent) | [self.storeManager isSubscribedToContent:info.inAppPurchaseId];
    
    if (info.isFreeContent){
        if(userIsSuscribedToMagazine){
            [self showIssue:info];
        }
        else{
            [self subscribeToMagazine];
        }
    }
    else{
        
        if(userIsSubscribedToCurrentIssue){
            [self showIssue:info];
        }
        else{
            [info subscribeToIssue];
        }
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ADVTheme> theme = [AppDelegate instance].theme;
    return [theme cellSize];
}


- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    id<ADVTheme> theme = [AppDelegate instance].theme;
    return [theme cellEdgeInsets];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    id<ADVTheme> theme = [AppDelegate instance].theme;
    return [theme cellLineSpacing];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    id<ADVTheme> theme = [AppDelegate instance].theme;
    return [theme cellItemSpacing];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
 
    BOOL userIsSusbcribedToTheMagazine = [self.storeManager isSubscribedToContent:[self.repository inAppPurchaseSubscriptionId]];
    if(userIsSusbcribedToTheMagazine) {
        return CGSizeZero;
    }
    else{
        return CGSizeMake(self.collectionView.bounds.size.width, 162);
    }
}


-(void)showIssue:(IssueInfo*)issueInfo{
    
    NKIssue *nkIssue = issueInfo.nkIssue;
    
    if(nkIssue.status==NKIssueContentStatusAvailable) {
        
        [self readIssue:issueInfo];
        
    } else if(nkIssue.status==NKIssueContentStatusNone) {
        
        [self downloadIssue:issueInfo];
    }
}

-(void)updateProgressOfConnection:(NSURLConnection *)connection withTotalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    // get asset
    NKAssetDownload *dnl = connection.newsstandAssetDownload;

    int index = [[dnl.userInfo objectForKey:@"index"] intValue];
    IssueCell* tile = (IssueCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    CGFloat progress = 1.f*totalBytesWritten/expectedTotalBytes;
    [tile updateProgress:progress];
}

-(void)connection:(NSURLConnection *)connection didWriteData:(long long)bytesWritten totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    [self updateProgressOfConnection:connection withTotalBytesWritten:totalBytesWritten expectedTotalBytes:expectedTotalBytes];
}

-(void)connectionDidResumeDownloading:(NSURLConnection *)connection totalBytesWritten:(long long)totalBytesWritten expectedTotalBytes:(long long)expectedTotalBytes {
    NSLog(@"Resume downloading %f",1.f*totalBytesWritten/expectedTotalBytes);
    [self updateProgressOfConnection:connection withTotalBytesWritten:totalBytesWritten expectedTotalBytes:expectedTotalBytes];
}

-(void)connectionDidFinishDownloading:(NSURLConnection *)connection destinationURL:(NSURL *)destinationURL forIssue:(NKIssue *)issue
{
    
    NSRange range = [destinationURL.path rangeOfString:@".zip"];
    
    if(range.location == NSNotFound){ //Means PDF issue
    
        NSString* contentPDFPath = [self loadPDFFilenameFromIssue:issue];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSError* error;
        [fileManager moveItemAtPath:destinationURL.path toPath:contentPDFPath error:&error];
        
        if(error){
            NSLog(@"Error: %@", error);
        }
    }
    else{
    
        [SSZipArchive unzipFileAtPath:destinationURL.path toDestination:issue.contentURL.path];
    }
    
    // update the Newsstand icon
    UIImage *img = [self.publisher coverImageForIssue:issue];
    if(img) {
        [[UIApplication sharedApplication] setNewsstandIconImage:img];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    }
    
    NSLog(@"connection:(NSURLConnection *)connectionDidFinishDownloading");
    
    [self.collectionView reloadData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Download error" message:@"An error occurred while downloading the issue" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
    NSLog(@"Error %@", error);
}


-(void)loadIssues {
    
    self.collectionView.alpha = 0.0;
    
    self.publisher.delegate = self;
    
    [self.publisher getIssuesList];
}

-(void)didLoadIssuesWithSuccess:(BOOL)success{
    
    if(success){
        [self fetchInfoForAllInAppPurchases];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Cannot get issues from publisher server."
                                                       delegate:nil
                                              cancelButtonTitle:@"Close"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    self.publisher.delegate = nil;
}


-(void)reloadGridWithIssues {

    self.collectionView.alpha = 1.0;
    [self.collectionView reloadData];
}


-(void)readIssue:(IssueInfo *)issueInfo {
    
    NKIssue* nkIssue = issueInfo.nkIssue;
    [[NKLibrary sharedLibrary] setCurrentlyReadingIssue:nkIssue];
    
    if([issueInfo.type isEqualToString:@"pdf"]){
       
        NSString* issuePath = [self loadPDFFilenameFromIssue:issueInfo.nkIssue];
        ReaderDocument *document = [ReaderDocument withDocumentFilePath:issuePath password:@""];
         
         if (document != nil)
         {
             ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
         
             readerViewController.delegate = self; // Set the ReaderViewController delegate to self
         
             [self.navigationController presentViewController:readerViewController animated:YES completion:nil];
         }
    }
    else{
        
        NSString* issuePath = nkIssue.contentURL.path;
        NSDictionary* bookData = [self.repository loadHTMLMagazineDataWithPath:issuePath];
        
        if(bookData){
            
            NSArray* contents = bookData[@"contents"];
            if(contents.count > 0){
                
                MagazinePageViewController* pageViewController = [[MagazinePageViewController alloc] init];
                
                pageViewController.htmlFiles = bookData[@"contents"];
                pageViewController.issueInfo = issueInfo;
                
                [self.navigationController presentViewController:pageViewController animated:YES completion:nil];
                
            }
            else{
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Pages" message:@"The magazine issue has no pages" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
        }
    }
}

-(void)returnToIssueListInitiated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)downloadIssue:(IssueInfo*)issueInfo{
    
    NewsstandDownloader* downloader = [[AppDelegate instance] newsstandDownloader];
    downloader.delegate = self;
  
    int index = [self.publisher indexOfIssue:issueInfo];
    [downloader downloadIssue:issueInfo forIndexTag:index];
}

-(void)subscribeButtonTapped{
    [self subscribeToMagazine];
}

-(void)subscribeToMagazine
{
    self.storeManager.delegate = self;
    [self.storeManager subscribeToProduct:self.subscriptionProduct];
}

-(void)fetchInfoForAllInAppPurchases{
    
    NSArray* inAppPurchases = [self.repository allInAppPurchases];
    
    self.storeManager.delegate = self;
    [self.storeManager fetchProductInfoWithIds:[NSSet setWithArray:inAppPurchases]];
}

-(void)didFetchProductInfos:(NSArray *)products withSuccess:(BOOL)success{
    
    self.storeManager.delegate = nil;
    if(success){
        
        NSArray* issues = self.publisher.issues;
        for (SKProduct* product in products) {
            
            if([product.productIdentifier isEqualToString:[self.repository inAppPurchaseSubscriptionId]]){
                
                self.subscriptionProduct = product;
                continue;
            }
            
            for (IssueInfo* issue in issues) {
                if ([product.productIdentifier isEqualToString:issue.inAppPurchaseId]) {
                    issue.product = product;
                }
            }
        }
    }
    
    [self reloadGridWithIssues];
}


-(void)subscriptionCompletedWith:(BOOL)success forInAppPurchaseId:(NSString *)inAppPurchaseId{
   
    self.storeManager.delegate = nil;
    
    if(success){
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You have successfully subscribed to the magazine. Please select an issue to start reading" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


-(void)restorePurchases{
    
    self.storeManager.delegate = self;
    [self.storeManager restorePurchases];
}

-(void)didRestoreAllPurchases{
    self.storeManager.delegate = nil;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"All your purchases have been restored" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [self reloadGridWithIssues];
}

-(void)trashContent {
    NKLibrary *nkLib = [NKLibrary sharedLibrary];
    NSLog(@"%@",nkLib.issues);
    [nkLib.issues enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [nkLib removeIssue:(NKIssue *)obj];
    }];
    [self.publisher addIssuesInNewsstand];
    [self.collectionView reloadData];
}


-(NSString*)loadPDFFilenameFromIssue:(NKIssue*)issue{
    
    NSString* lastPathComponentWithExtension = [NSString stringWithFormat:@"/%@.pdf", issue.contentURL.lastPathComponent];
    
    NSString* contentPDFPath = [issue.contentURL.path stringByAppendingString:lastPathComponentWithExtension];
    
    return contentPDFPath;
}
@end
