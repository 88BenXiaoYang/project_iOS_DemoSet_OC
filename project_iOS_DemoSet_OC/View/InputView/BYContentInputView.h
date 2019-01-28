//
//  BYContentInputView.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/24.
//  Copyright © 2019 by. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BYContentInputView : UIView

@property (nonatomic, strong) void(^completeBlock) (NSString *text);
@property (nonatomic, strong) SAMTextView *textView;
@property (nonatomic, assign) NSInteger maxTextNumber;

//TBD: 暂时实现自动改变输入框
@property (nonatomic, assign) BOOL isChangeBool;
@property (nonatomic, strong) void(^textHeightChangeBlock)(CGFloat textHeight);
@property (nonatomic, copy) NSString *textString;

- (void)inputViewBecomeFirstResponder;
- (void)inputViewResignFirstResponder;

@end

NS_ASSUME_NONNULL_END
