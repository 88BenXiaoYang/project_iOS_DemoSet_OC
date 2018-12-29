//
//  BYVCManager.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/29.
//  Copyright © 2018 by. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYVCManager : NSObject

+ (instancetype)shareVCManager;

- (UITabBarController *)rootTabBarController;

@end

NS_ASSUME_NONNULL_END
