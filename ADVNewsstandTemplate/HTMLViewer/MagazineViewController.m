//
//  MagazineViewController.m
//  ADVNewsstand
//
//  Created by Tope Abayomi on 10/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "MagazineViewController.h"

@interface MagazineViewController ()

- (void)loadWebViewWithPageAtPath:(NSString*)filePath;

@end

@implementation MagazineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!self.webView){
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.webView];
    }
    
    [self loadWebViewWithPageAtPath:self.path];
}

- (void)loadWebViewWithPageAtPath:(NSString*)filePath {
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //NSLog(@"• Loading: book/%@", [[NSFileManager defaultManager] displayNameAtPath:filePath]);
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
