//
//  ADVTheme.h
//  ADVNewsstandTemplate
//
//  Created by Tope Abayomi on 23/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADVTheme <NSObject>

-(NSString*)backButtonImage;
-(NSString*)barButtonImage;
-(NSString*)navigationBackgroundImage;
-(NSString*)backgroundImage;
-(NSString*)buttonDisabledImage;
-(NSString*)buttonDisabledImagePressed;
-(NSString*)buttonImage;
-(NSString*)buttonImagePressed;
-(NSString*)cellBackgroundImage;
-(NSString*)cellDividerImage;
-(UIColor*)themeColor;
-(NSString*)cellNibName;
-(CGSize)cellSize;
-(UIEdgeInsets)cellEdgeInsets;
-(CGFloat)cellLineSpacing;
-(CGFloat)cellItemSpacing;
@end
