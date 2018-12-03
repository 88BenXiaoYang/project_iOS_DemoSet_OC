//
//  BYSlideView.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/30.
//  Copyright © 2018 by. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYSlideView : UIView

@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIColor *slideViewColor;
@property (nonatomic, strong) NSArray *slideItemArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic,   copy) void(^itemClickedBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
