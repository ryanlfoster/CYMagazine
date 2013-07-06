//
//  OrangeTheme.m
//  ADVNewsstandTemplate
//
//  Created by Tope Abayomi on 23/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "OrangeTheme.h"

@implementation OrangeTheme

-(NSString*)backButtonImage{
    return @"orange-back";
}

-(NSString*)barButtonImage{
    return @"orange-barButton";
}

-(NSString*)navigationBackgroundImage{
    return @"orange-navigationBackground";
}

-(NSString*)backgroundImage{
    return @"orange-background";
}

-(NSString*)buttonDisabledImage{
    return @"orange-button-grey-pressed";
}

-(NSString*)buttonDisabledImagePressed{
    return @"orange-button-grey-pressed";
}

-(NSString*)buttonImage{
    return @"orange-button-orange";
}

-(NSString*)buttonImagePressed{
    return @"orange-button-orange-pressed";
}

-(NSString*)cellBackgroundImage{
    return @"orange-cellBackground";
}

-(NSString*)cellDividerImage{
    return @"orange-cellDivider";
}

-(UIColor*)themeColor{
    
    return [UIColor colorWithRed:212.0/255 green:58.0/255 blue:39.0/255 alpha:1.0];
}

-(NSString*)cellNibName{
    return @"IssueCell";
}

-(CGSize)cellSize{
    return CGSizeMake(300, 471);
}

-(UIEdgeInsets)cellEdgeInsets{
    return UIEdgeInsetsMake(50, 50, 50, 50);
}

-(CGFloat)cellLineSpacing{
    return 10.0f;
}

-(CGFloat)cellItemSpacing{
    return 10.0f;
}
@end
