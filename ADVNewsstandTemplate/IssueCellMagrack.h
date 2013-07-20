//
//  IssueCellMagrack.h
//  ADVNewsstand
//
//  Created by Tope Abayomi on 04/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueInfo.h"
#import "IssueCellProtocol.h"

@interface IssueCellMagrack : UICollectionViewCell <IssueInfoDelegate, IssueCellProtocol>

@property (nonatomic, weak) IBOutlet UIImageView* bgImageView;

@property (nonatomic, weak) IBOutlet UIImageView* coverImageView;

@property (nonatomic, weak) IBOutlet UILabel* issueTitleLabel;

@property (nonatomic, weak) IBOutlet UILabel* actionLabel;

@property (nonatomic, weak) IBOutlet UIProgressView* downloadProgress;

@property (nonatomic, strong) IssueInfo* issueInfo;

-(void)updateProgress:(CGFloat)progress;


@end
