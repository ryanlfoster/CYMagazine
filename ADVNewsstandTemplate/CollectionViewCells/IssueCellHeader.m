//
//  IssueCellHeader.m
//  ADVNewsstand
//
//  Created by Tope Abayomi on 17/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "IssueCellHeader.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@implementation IssueCellHeader

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
    
    self.subscribeInfoLabel.textColor = [theme themeColor];
    self.subscribeInfoLabel.font = [UIFont fontWithName:@"Avenir-Book" size:18.0f];
    
    self.subscribeButton.titleLabel.textColor = [theme themeColor];
    
    [self.subscribeButton setTitleColor:[theme themeColor] forState:UIControlStateNormal];
    self.subscribeButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:18.0f];
    
    [self.subscribeButton addTarget:self action:@selector(subscribeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.shadowColor = [UIColor colorWithWhite:0.2f alpha:0.3f].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.bgView.layer.shadowOpacity = 1.0f;

}

-(IBAction)subscribeButtonTapped:(id)sender{
    [self.delegate subscribeButtonTapped];
}


@end
