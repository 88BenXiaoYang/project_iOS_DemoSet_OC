//
//  BYTools.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/12/11.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYTools.h"

@interface BYTools () {
    CGFloat _screenWidth;
    CGFloat _screenHeight;
}

@end

@implementation BYTools

static BYTools *_instance = nil;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)shareTools {
    if (!_instance) {
        _instance = [[self alloc] init];
        [_instance prepare];
    }
    return _instance;
}

- (void)prepare {
    _screenWidth = [UIScreen mainScreen].bounds.size.width;
    _screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (NSString *)handleStringAppenddingWithOriginalString:(NSString *)OriginalString specificString:(NSString *)specificString {
    NSString *compoundString;
    NSString *specifString = [@" " stringByAppendingString:specificString];
    CGSize specifStringSize = [specifString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    specifStringSize.width += 8;
    
    NSString *origiString = [OriginalString stringByAppendingString:specifString];
    CGSize origiStringSize = [origiString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    if (origiStringSize.width >= 2*(_screenWidth - 60)) {
        NSString *symbolString = @"...";
        CGSize symbolSize = [symbolString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        
        CGFloat diffStringSize = origiStringSize.width - 2*(_screenWidth - 60);
        CGFloat diffValue = fabs(diffStringSize + specifStringSize.width + symbolSize.width);
        CGFloat compoundStringFinallySize = origiStringSize.width - diffValue;
        NSUInteger subStringWidth = floorf(compoundStringFinallySize);
        NSUInteger textLen = 0;
        for (NSInteger i = 0; i < origiString.length; i ++) {
            NSString *subString = [origiString substringWithRange:NSMakeRange(0, i)];
            CGSize subStringSize = [subString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
            if (subStringSize.width >= subStringWidth) {
                textLen = i;
                break;
            }
        }
        NSString *finallySubString = [origiString substringWithRange:NSMakeRange(0, textLen)];
        
        finallySubString = [finallySubString stringByAppendingString:symbolString];
        finallySubString = [finallySubString stringByAppendingString:specifString];
        compoundString = finallySubString;
    } else {
        compoundString = origiString;
    }
    return compoundString;
}

- (NSMutableAttributedString *)handleContentText:(NSString *)contentText {
    NSArray *componentsArray = [contentText componentsSeparatedByString:@" "];
    NSString *numString = [componentsArray lastObject];
    
    NSUInteger numLen = numString.length;
    NSUInteger titleLen = contentText.length - numLen - 1;
    
    NSMutableAttributedString *resultString = [[NSMutableAttributedString alloc] initWithString:contentText];
    [resultString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size: 14], NSForegroundColorAttributeName:[_instance colorWithRGBHex:0x272727]} range:NSMakeRange(0, titleLen)];
    [resultString addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Light" size: 14], NSForegroundColorAttributeName:[_instance colorWithRGBHex:0xA7A7A7]} range:NSMakeRange(titleLen + 1, numLen)];
    
    return resultString;
}

- (UIColor *)colorWithRGBHex:(UInt32)hex {
    
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

@end
