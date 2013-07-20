//
//  MagazinePageViewController.m
//  ADVNewsstand
//
//  Created by Tope Abayomi on 10/07/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "MagazinePageViewController.h"
#import "MagazineViewController.h"

@interface MagazinePageViewController ()

@property (nonatomic, strong) UIToolbar* toolbar;

@property (nonatomic, assign) BOOL barsHidden;

@end

@implementation MagazinePageViewController

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
    
    self.pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           options:nil];
    
    self.pageController.dataSource = self;
    self.pageController.view.frame = self.view.bounds;
    
    [self.view addSubview:self.pageController.view];
    
    MagazineViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = @[initialViewController];
    
    [self.pageController setViewControllers:viewControllers
                             direction:UIPageViewControllerNavigationDirectionForward
                              animated:NO
                            completion:nil];
    
    
    [self.pageController didMoveToParentViewController:self];
   
    CGRect toolbarRect = self.view.bounds;
	toolbarRect.size.height = 44;
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:toolbarRect];
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UIBarButtonItem *returnButton = [[UIBarButtonItem alloc] initWithTitle:@"All Issues" style:UIBarButtonItemStyleBordered target:self action:@selector(returnToIssuesListTappedInToolbar:)];
    self.toolbar.items = @[returnButton];
    self.barsHidden = NO;
    [self.view addSubview:self.toolbar];

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    
    tapGesture.numberOfTouchesRequired = 1;
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.delegate = self;
    [self.pageController.view addGestureRecognizer:tapGesture];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(MagazineViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    
    NSUInteger index = [self indexOfViewController:(MagazineViewController *)viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index ==  self.htmlFiles.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (MagazineViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if ((self.htmlFiles.count == 0) || (index >= self.htmlFiles.count)) {
        return nil;
    }

    NSString* path = [NSString stringWithFormat:@"%@/%@", self.issueInfo.nkIssue.contentURL.path, self.htmlFiles[index]];
    
    MagazineViewController *magController = [[MagazineViewController alloc] init];
    
    magController.path = path;
    magController.lastPathComponent = self.htmlFiles[index];
    
    return magController;
}

- (NSUInteger)indexOfViewController:(MagazineViewController *)viewController
{
    return [self.htmlFiles indexOfObject:viewController.lastPathComponent];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)handleSingleTap:(UIGestureRecognizer*)gesture{
    
    [self toggleBarVisibility];
}

- (void)toggleBarVisibility{
    
    CGRect newNavigationFrame = [self getNewNavigationFrame:self.barsHidden];
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.toolbar.frame = newNavigationFrame;
                     }
                     completion:^(BOOL finished) {
                         self.barsHidden = !self.barsHidden;
                     }];
}

- (CGRect)getNewNavigationFrame:(BOOL)hidden {
    
    int navX = self.toolbar.frame.origin.x;
    int navW = self.toolbar.frame.size.width;
    int navH = self.toolbar.frame.size.height;
    
    if (hidden) {
        return CGRectMake(navX, 0, navW, navH);
    } else {
        return CGRectMake(navX, -55, navW, navH);
    }
}

- (IBAction)returnToIssuesListTappedInToolbar:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
