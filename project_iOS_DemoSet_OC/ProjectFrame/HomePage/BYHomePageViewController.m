//
//  BYHomePageViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/29.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYHomePageViewController.h"
#import "BYSlideView.h"

@interface BYHomePageViewController ()

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation BYHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"~~~";
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    BYSlideView *slideView = [[BYSlideView alloc] initWithFrame:CGRectMake(0, 100, self.screenWidth, 50)];
    slideView.slideItemArray = @[@"AAA", @"BBB", @"CCC"];
//    slideView.selectedIndex = 1;
//    slideView.slideViewColor = [UIColor yellowColor];
    [self.view addSubview:slideView];
}

@end
