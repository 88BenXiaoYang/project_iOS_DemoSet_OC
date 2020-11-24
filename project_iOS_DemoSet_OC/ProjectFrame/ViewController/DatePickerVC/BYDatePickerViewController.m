//
//  BYDatePickerViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/10/21.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYDatePickerViewController.h"
#import "BYCustomeDatePickerView.h"

@interface BYDatePickerViewController ()

@end

@implementation BYDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BYCustomeDatePickerView *datePickerView = [[BYCustomeDatePickerView alloc] initWithType:BYCustomeDatePickerTypeLongDate];
    datePickerView.startDate = [self convertStringToDate:@"2020-09-01 16:11" format:@"yyyy-MM-dd HH:mm"];
    datePickerView.endDate = [self convertStringToDate:@"2020-11-01 16:11" format:@"yyyy-MM-dd HH:mm"];
    [datePickerView show];
    datePickerView.dateValueChanged = ^(NSDate * _Nullable date) {
        NSLog(@"current_datePicker_value:%@", date);
    };
}

- (NSDate *)convertStringToDate:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateStr];
}

@end
