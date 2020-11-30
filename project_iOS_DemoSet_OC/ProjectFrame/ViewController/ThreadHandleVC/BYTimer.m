//
//  BYTimer.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/11/24.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYTimer.h"

static NSMutableDictionary *timers;
dispatch_semaphore_t semaphore;

@implementation BYTimer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers = [NSMutableDictionary dictionary];
        semaphore = dispatch_semaphore_create(1);
    });
}

+ (NSString *)execTask:(void (^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!task || start < 0 || (interval <= 0 && repeats)) return nil;
    
    //队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    //创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //定时器的唯一标识
    NSString *name = [NSString stringWithFormat:@"%zd", timers.count];
    timers[name] = timer;
    dispatch_semaphore_signal(semaphore);
    
    //设置回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        
        if (!repeats) { //不重复的任务
            [self cancelTask:name];
        }
    });
    
    //启动定时器
    dispatch_resume(timer);
    
    return name;
}

+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeats:(BOOL)repeats async:(BOOL)async {
    if (!target || !selector) return nil;
    
    return [self execTask:^{
        if ([target respondsToSelector:selector]) {
            //Xcode强制去除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [target performSelector:selector];
#pragma clang diagnostic pop
        }
    } start:start interval:interval repeats:repeats async:async];
}

+ (void)cancelTask:(NSString *)name {
    if (name.length == 0) return;
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    dispatch_source_t timer = timers[name];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers removeObjectForKey:name];
    }
    
    dispatch_semaphore_signal(semaphore);
}

@end
