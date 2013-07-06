//
//  Theme.m
//  ADVNewsstandTemplate
//
//  Created by Tope Abayomi on 23/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "BlueTheme.h"

@implementation BlueTheme

-(NSString*)backButtonImage{
    return @"blue-back";
}

-(NSString*)barButtonImage{
    return @"blue-barButton";
}

-(NSString*)navigationBackgroundImage{
    return @"blue-navigationBackground";
}

-(NSString*)backgroundImage{
    return @"blue-background";
}

-(NSString*)buttonDisabledImage{
    return @"blue-button-grey-pressed";
}

-(NSString*)buttonDisabledImagePressed{
    return @"blue-button-grey-pressed";
}

-(NSString*)buttonImage{
    return @"blue-button-orange";
}

-(NSString*)buttonImagePressed{
    return @"blue-button-orange-pressed";
}

-(NSString*)cellBackgroundImage{
    return @"blue-cellBackground";
}

-(NSString*)cellDividerImage{
    return @"blue-cellDivider";
}

-(UIColor*)themeColor{

    return [UIColor colorWithRed:18.0/255 green:132.0/255 blue:195.0/255 alpha:1.0];
    
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
