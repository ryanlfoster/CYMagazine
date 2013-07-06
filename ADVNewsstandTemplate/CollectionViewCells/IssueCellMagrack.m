//
//  IssueCellMagrack.m
//  ADVNewsstand
//
//  Created by Tope Abayomi on 04/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "IssueCellMagrack.h"
#import "ADVTheme.h"
#import "AppDelegate.h"

#define kDownloadCTA @"TAP TO DOWNLOAD"
#define kBuyNowCTA @"BUY NOW"
#define kReadCTA @"READ"

@interface IssueCellMagrack ()

@property (nonatomic, strong) NSString* callToActionText;

@end

@implementation IssueCellMagrack

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    
    id<ADVTheme> theme = [AppDelegate instance].theme;
    
    UIColor* color = [theme themeColor];
    [self.downloadProgress setProgressTintColor:color];
   
    [self.issueTitleLabel setTextColor:color];
    [self.issueTitleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:20.0f]];
    
    [self.actionLabel setTextColor:[UIColor grayColor]];
    [self.actionLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:16.0f]];
    
    [self.downloadProgress setAlpha:0.0];
    
    self.callToActionText = kDownloadCTA;
    
}

-(void)updateCellInformationWithStatus
{
    NKIssueContentStatus status = self.issueInfo.nkIssue.status;
    if(status == NKIssueContentStatusAvailable) {
        
        [self.actionLabel setText:kReadCTA];
        [self.actionLabel setAlpha:1.0];
        
        [self.downloadProgress setAlpha:0.0];
        
    } else {
        
        if(status==NKIssueContentStatusDownloading) {
            [self.downloadProgress setAlpha:1.0];
            [self.actionLabel setAlpha:0.0];
            
        } else {
            [self.downloadProgress setProgress:0.0];
            [self.downloadProgress setAlpha:0.0];
            
            [self.actionLabel setText:self.callToActionText];
            [self.actionLabel setAlpha:1.0];
        }
        
    }
}

-(void)displayProductInfo{
    
    IssueInfo* issueInfo = self.issueInfo;
    
    if(issueInfo.isPaidContent && issueInfo.product){
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:issueInfo.product.priceLocale];
        
        NSString* price = [numberFormatter stringFromNumber:issueInfo.product.price];
        self.callToActionText = [NSString stringWithFormat:@"%@ - %@", price, kBuyNowCTA];
        
    }else{
        
        self.callToActionText = kDownloadCTA;
    }
    
    self.issueTitleLabel.text = issueInfo.title;
    self.actionLabel.text = self.callToActionText;
    self.actionLabel.alpha = 1.0;
    
    [self updateCellInformationWithStatus];
}


-(void)displayCoverImage:(UIImage *)image{
    [self.coverImageView setImage:image];
}

-(void)subscriptionCompleted{
    
    self.callToActionText = kDownloadCTA;
    self.actionLabel.text = self.callToActionText;
    
}

-(void)updateProgress:(CGFloat)progress{
    
    self.downloadProgress.alpha = 1.0;
    self.downloadProgress.progress = progress;
    
    [self updateCellInformationWithStatus];
}


-(void)setIssueInfo:(IssueInfo *)issueInfo{
    
    _issueInfo = issueInfo;
    
    _issueInfo.delegate = self;
    
    [self displayProductInfo];
    
}


@end
