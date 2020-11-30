//
//  BYTimer.h
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/11/24.
//  Copyright © 2020 by. All rights reserved.
//
//  使用GCD实现定时器

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYTimer : NSObject

//返回创建定时器后的唯一标识
+ (NSString *)execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async;

//调用该方法不会产生循环引用，因block会对target产生强引用，但target不会对block产生强引用，即是单方强引用，不会产生循环引用，使用GCD中的block同理
+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async;

+ (void)cancelTask:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
