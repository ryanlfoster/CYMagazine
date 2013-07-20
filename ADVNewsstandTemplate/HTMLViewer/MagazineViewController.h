//
//  MagazineViewController.h
//  ADVNewsstand
//
//  Created by Tope Abayomi on 10/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagazineViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIWebView* webView;

@property (nonatomic, assign) int pageIndex;

@property (nonatomic, strong) NSString* path;

@property (nonatomic, strong) NSString* lastPathComponent;

@end
