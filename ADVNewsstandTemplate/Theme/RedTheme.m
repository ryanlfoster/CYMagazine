//
//  RedTheme.m
//  ADVNewsstandTemplate
//
//  Created by Tope Abayomi on 23/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "RedTheme.h"

@implementation RedTheme

-(NSString*)backButtonImage{
    return @"red-back";
}

-(NSString*)barButtonImage{
    return @"red-barButton";
}

-(NSString*)navigationBackgroundImage{
    return @"red-navigationBackground";
}

-(NSString*)backgroundImage{
    return @"red-background";
}

-(NSString*)buttonDisabledImage{
    return @"red-button-grey-pressed";
}

-(NSString*)buttonDisabledImagePressed{
    return @"red-button-grey-pressed";
}

-(NSString*)buttonImage{
    return @"red-button-orange";
}

-(NSString*)buttonImagePressed{
    return @"red-button-orange-pressed";
}

-(NSString*)cellBackgroundImage{
    return @"red-cellBackground";
}

-(NSString*)cellDividerImage{
    return @"red-cellDivider";
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
