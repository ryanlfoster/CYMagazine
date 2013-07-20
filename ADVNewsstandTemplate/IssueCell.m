//
//  IssueCell.m
//  ADVNewsstandTemplate
//
//  Created by Tope on 07/03/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "IssueCell.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface IssueCell ()

@property (nonatomic, strong) NSString* callToActionText;

@end

@implementation IssueCell

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
    [self.bgImageView setImage:[UIImage imageNamed:[theme cellBackgroundImage]]];
    [self.dividerImageView setImage:[UIImage imageNamed:[theme cellDividerImage]]];
    [self.actionImageView setImage:[UIImage imageNamed:[theme buttonImage]]];
    
    self.coverContainerView.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor;
    self.coverContainerView.layer.borderWidth = 3.0;
    
    UIColor* color = [theme themeColor];
    [self.downloadProgress setProgressTintColor:color];
    [self.issueTitleLabel setTextColor:color];
    
    [self.downloadProgress setAlpha:0.0];
    
    self.callToActionText = @"DOWNLOAD";

}

-(void)updateCellInformationWithStatus
{
    NKIssueContentStatus status = self.issueInfo.nkIssue.status;
    if(status == NKIssueContentStatusAvailable) {
        
        [self.actionLabel setText:@"READ"];
        [self.actionLabel setAlpha:1.0];
        [self.actionImageView setAlpha:1.0];
        
        [self.downloadProgress setAlpha:0.0];
        
    } else {
        
        if(status==NKIssueContentStatusDownloading) {
            [self.downloadProgress setAlpha:1.0];
            [self.actionLabel setAlpha:0.0];
            [self.actionImageView setAlpha:0.0];
            
        } else {
            [self.downloadProgress setProgress:0.0];
            [self.downloadProgress setAlpha:0.0];
            
            [self.actionLabel setText:self.callToActionText];
            [self.actionLabel setAlpha:1.0];
            [self.actionImageView setAlpha:1.0];
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
        
        if([issueInfo userHasSubscribedToIssue]){
            self.callToActionText = @"DOWNLOAD";
        }
        else{
            NSString* price = [numberFormatter stringFromNumber:issueInfo.product.price];
            self.callToActionText = [NSString stringWithFormat:@"%@ - BUY NOW", price];
        }
        
    }else{
        
        self.callToActionText = @"DOWNLOAD";       
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
    
    [self displayProductInfo];
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
