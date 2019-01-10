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

+ (NSString *)timeStrFrom:(double)timeStmp{
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStmp];
    //    一分钟内  40秒前或刚刚
    //    一小时内 XX分钟前
    //    一小时到24小时  今天XX：XX或XX小时前
    //    24小时前  显示日期 比如6-25 13：25
    
    const NSTimeInterval min  = 60.0;
    const NSTimeInterval hour = 60.0 * 60;
    const NSTimeInterval day  = 60.0 * 60 * 24;
    
    NSTimeInterval interval = [date timeIntervalSinceNow];
    interval = ABS(interval);
    
    NSDateFormatter* fm = [[NSDateFormatter alloc] init];
    NSString* result = @"";
    
    //分情况
    NSDate* now = [NSDate date];
    [fm setDateFormat:@"yyyyMMdd"];
    NSString* todayStr = [fm stringFromDate:now];
    NSDate* today = [fm dateFromString:todayStr];//今天00：00
    
    if ([date timeIntervalSinceDate:today] > 0){
        //今天
        if (interval < min){
            result =  @"刚刚";
        }
        else    if(interval >= min
                   && interval < hour){
            interval /= min;
            result = [NSString stringWithFormat:@"%d分钟前", (int)interval];
        }
        else    if(interval >= hour
                   && interval < day){
            [fm setDateFormat:@"今天HH:mm"];
            result = [fm stringFromDate:date];
        }
    }
    else {
        //昨天之前
        [fm setDateFormat:@"MM-dd HH:mm"];
        result = [fm stringFromDate:date];
    }
    
    return result;
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
