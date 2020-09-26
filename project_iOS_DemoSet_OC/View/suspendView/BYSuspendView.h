//
//  BYSuspendView.h
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/9/26.
//  Copyright © 2020 by. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth_suspend [UIScreen mainScreen].bounds.size.width
#define kScreenHeight_suspend [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSInteger, BYSuspendType) {
    BYSuspendTypeSideslip,
    BYSuspendTypeHorizontal,
    BYSuspendTypeVertical,
};

typedef NS_ENUM(NSInteger, BYSShowOrientationType) {
    BYSShowOrientationTypeUp = 1,
    BYSShowOrientationTypeDown,
    BYSShowOrientationTypeLeft,
    BYSShowOrientationTypeRight,
};

typedef NS_ENUM(NSInteger, BYStyleTpye) {
    BYStyleTpyeLeft = 1,
    BYStyleTpyeRight,
};

NS_ASSUME_NONNULL_BEGIN

@interface BYSuspendView : UIView

- (void)showWithType:(BYSuspendType)type anchorView:(UIButton *)anchorView;
- (void)showWithStyleTpye:(BYStyleTpye)styleType anchorView:(UIButton *)anchorView;

@end

NS_ASSUME_NONNULL_END
