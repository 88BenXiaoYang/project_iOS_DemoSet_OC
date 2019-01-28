//
//  NSString+Tools.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/27.
//  Copyright © 2019 by. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (NSString *)tool_stringByTrimmingCharacters {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet controlCharacterSet]];
    return string;
}

@end
