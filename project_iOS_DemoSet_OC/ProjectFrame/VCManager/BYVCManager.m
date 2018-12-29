//
//  BYVCManager.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/29.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYVCManager.h"
#import "BYHomePageViewController.h"

@implementation BYVCManager

static BYVCManager *_instance = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareVCManager {
    if (!_instance) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

- (UITabBarController *)rootTabBarController {
    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    
    BYHomePageViewController *naviRootVC = [[BYHomePageViewController alloc] init];
    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:naviRootVC];
    
    tabBarC.viewControllers = @[naviC];
    return tabBarC;
}

@end
