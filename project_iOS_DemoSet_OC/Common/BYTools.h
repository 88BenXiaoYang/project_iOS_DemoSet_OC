//
//  BYTools.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/12/11.
//  Copyright © 2018 by. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BYTools : NSObject

+ (instancetype)shareTools;

/**
 字符串的拼接，如源字符串超出指定长度，对源字符串进行截取然后拼接上指定的字符串

 @param OriginalString 源字符串
 @param specificString 指定字符串
 @return 拼接后的字符串
 */
- (NSString *)handleStringAppenddingWithOriginalString:(NSString *)OriginalString specificString:(NSString *)specificString;

/**
 处理文本内容指定部分的属性，如颜色

 @param contentText 待处理的文本
 @return 处理后的文本
 */
- (NSMutableAttributedString *)handleContentText:(NSString *)contentText;

@end

NS_ASSUME_NONNULL_END
