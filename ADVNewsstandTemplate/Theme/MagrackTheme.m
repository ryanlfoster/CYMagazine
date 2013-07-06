//
//  MagrackTheme.m
//  ADVNewsstandTemplate
//
//  Created by Tope Abayomi on 23/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "MagrackTheme.h"

@implementation MagrackTheme

-(NSString*)backButtonImage{
    return @"magrack-backButton";
}

-(NSString*)barButtonImage{
    return @"magrack-barButton";
}

-(NSString*)navigationBackgroundImage{
    return @"magrack-navigationBackground";
}

-(NSString*)backgroundImage{
    return @"red-background";
}

-(NSString*)buttonDisabledImage{
    return @"magrack-button-orange";
}

-(NSString*)buttonDisabledImagePressed{
    return @"magrack-button-orange-pressed";
}

-(NSString*)buttonImage{
    return @"magrack-button-orange";
}

-(NSString*)buttonImagePressed{
    return @"magrack-button-orange-pressed";
}

-(NSString*)cellBackgroundImage{
    return @"red-cellBackground";
}

-(NSString*)cellDividerImage{
    return @"red-cellDivider";
}

-(UIColor*)themeColor{

    return [UIColor colorWithRed:197.0/255 green:57.0/255 blue:57.0/255 alpha:1.0];
}

-(NSString*)cellNibName{
    return @"IssueCellMagrack";
}

-(CGSize)cellSize{
    return CGSizeMake(340, 200);
}

-(UIEdgeInsets)cellEdgeInsets{
    return UIEdgeInsetsMake(50, 0, 0, 0);
}

-(CGFloat)cellLineSpacing{
    return 10.0f;
}

-(CGFloat)cellItemSpacing{
    return 0.0f;
}

@end
