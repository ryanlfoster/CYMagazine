//
//  ViewController.h
//  ADVNewsstandTemplate
//
//  Created by Tope on 07/03/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ReaderViewController.h"
#import "IssueCellHeader.h"

@interface IssuesGridViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NewsstandDownloaderDelegate, PublisherDelegate, StoreManagerDelegate, ReaderViewControllerDelegate, IssueCellHeaderDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) Publisher* publisher;

@property (nonatomic, strong) Repository* repository;

@property (nonatomic, strong) StoreManager* storeManager;

-(void)didLoadIssuesWithSuccess:(BOOL)success;

-(void)didFetchProductInfos:(NSArray *)products withSuccess:(BOOL)success;

-(void)subscribeButtonTapped;

-(void)subscriptionCompletedWith:(BOOL)success forInAppPurchaseId:(NSString *)inAppPurchaseId;
@end

