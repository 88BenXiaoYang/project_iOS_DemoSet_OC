//
//  NSString+Tools.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/27.
//  Copyright © 2019 by. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Tools)

/**
 去除字符串两端的空格及换行

 @return 去除字符串两端的空格及换行的字符串
 */
- (NSString *)tool_stringByTrimmingCharacters;

@end

NS_ASSUME_NONNULL_END
