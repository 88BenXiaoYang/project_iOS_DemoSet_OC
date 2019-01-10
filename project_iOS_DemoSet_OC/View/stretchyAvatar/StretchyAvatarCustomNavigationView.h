//
//  StretchyAvatarCustomNavigationView.h
//  project_iOS_DemoSet_OC
//
//  Created by by on 2019/1/1.
//  Copyright © 2019 by. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StretchyAvatarCustomNavigationView : UIView

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic,   copy) void(^customNaviViewBackBlock)(void);

@end

NS_ASSUME_NONNULL_END
