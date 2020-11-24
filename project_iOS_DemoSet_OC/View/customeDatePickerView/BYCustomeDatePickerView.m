//
//  BYCustomeDatePickerView.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/10/21.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYCustomeDatePickerView.h"
#import "Masonry.h"

@interface BYCustomeDatePickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *toolBarView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIImageView *lineImgView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSArray *yearList;
@property (nonatomic, strong) NSArray *monthList;
@property (nonatomic, strong) NSArray *dayList;
@property (nonatomic, strong) NSArray *hourList;
@property (nonatomic, strong) NSArray *minuteList;
@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat pickerMargin;
@property (nonatomic, assign) BYCustomeDatePickerType datePickerType;

@end

@implementation BYCustomeDatePickerView
#pragma mark- Live circle
- (instancetype)init {
    return [self initWithType:BYCustomeDatePickerTypeShortDate];
}
#pragma mark- Overwrite
#pragma mark- Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        return 5;
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        return 2;
    } else {
        return 3;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (self.datePickerType == BYCustomeDatePickerTypeShortDate || self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        if (component == 0) {
            if (self.yearList) {
                return self.yearList.count;
            }
            return 0;
        } else if (component == 1) {
            if (self.monthList) {
                return self.monthList.count;
            }
            return 0;
        } else if (component == 2) {
            if (self.dayList) {
                return self.dayList.count;
            }
            return 0;
        } else if (component == 3) {
            if (self.hourList) {
                return self.hourList.count;
            }
            return 0;
        } else if (component == 4) {
            if (self.minuteList) {
                return self.minuteList.count;
            }
            return 0;
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        if (component == 0) {
            if (self.hourList) {
                return self.hourList.count;
            }
            return 0;
        } else if (component == 1) {
            if (self.minuteList) {
                return self.minuteList.count;
            }
            return 0;
        }
    }
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    for (UIView *separatorView in pickerView.subviews) {
        if (separatorView.frame.size.height < 1) {
            [self drawSeparatorView:separatorView];
        }
    }
    UILabel *rowLabel = [self labelWithTextColor:[UIColor blackColor] font:[UIFont systemFontOfSize:20] textAlignment:NSTextAlignmentCenter];
    if (self.datePickerType == BYCustomeDatePickerTypeShortDate || self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        if (component == 0) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.yearList objectAtIndex:row]];
        } else if (component == 1) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.monthList objectAtIndex:row]];
        } else if (component == 2) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.dayList objectAtIndex:row]];
        } else if (component == 3) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.hourList objectAtIndex:row]];
        } else if (component == 4) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.minuteList objectAtIndex:row]];
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        if (component == 0) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.hourList objectAtIndex:row]];
        } else if (component == 1) {
            rowLabel.text = [NSString stringWithFormat:@"%@", [self.minuteList objectAtIndex:row]];
        }
    }
    return rowLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.datePickerType == BYCustomeDatePickerTypeShortDate) {
        if (component == 0) {
            [self reloadMonthArray];
            [self.pickerView reloadComponent:1];
            [self reloadDayArray];
            [self.pickerView reloadComponent:2];
        } else if (component == 1) {
            [self reloadDayArray];
            [self.pickerView reloadComponent:2];
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        if (component == 0) {
            [self reloadMonthArray];
            [self.pickerView reloadComponent:1];
            [self reloadDayArray];
            [self.pickerView reloadComponent:2];
            [self reloadHourArray];
            [self.pickerView reloadComponent:3];
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:4];
        } else if (component == 1) {
            [self reloadDayArray];
            [self.pickerView reloadComponent:2];
            [self reloadHourArray];
            [self.pickerView reloadComponent:3];
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:4];
        } else if (component == 2) {
            [self reloadHourArray];
            [self.pickerView reloadComponent:3];
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:4];
        } else if (component == 3) {
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:4];
        }
    } else {
        if (component == 0) {
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
        }
    }
    [self updateSelectedDate];
}

#pragma mark- Notification methods
#pragma mark- Interface methods
- (id)initWithType:(BYCustomeDatePickerType)datePickerType {
    self = [super init];
    if (self) {
        self.datePickerType = datePickerType;
        [self builData];
        [self layoutUI];
    }
    return self;
}

- (void)show {
    if (!self.selectedDate) {
        self.selectedDate = [NSDate new];
    }
    
    if (self.datePickerType == BYCustomeDatePickerTypeShortDate || self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        [self reloadYearArray];
        [self.pickerView reloadComponent:0];
        NSString *selectedYear = [self convertDateToString:self.selectedDate dateFormat:@"yyyy"];
        if ([self.yearList containsObject:selectedYear]) {
            NSInteger yearIndex = [self.yearList indexOfObject:selectedYear];
            [self.pickerView selectRow:yearIndex inComponent:0 animated:NO];
        }
        
        [self reloadMonthArray];
        [self.pickerView reloadComponent:1];
        NSString *selectedMonth = [self convertDateToString:self.selectedDate dateFormat:@"M"];
        if ([self.monthList containsObject:selectedMonth]) {
            NSInteger monthIndex = [self.monthList indexOfObject:selectedMonth];
            [self.pickerView selectRow:monthIndex inComponent:1 animated:NO];
        }
        
        [self reloadDayArray];
        [self.pickerView reloadComponent:2];
        NSString *selectedDay = [self convertDateToString:self.selectedDate dateFormat:@"d"];
        if ([self.dayList containsObject:selectedDay]) {
            NSInteger dayIndex = [self.dayList indexOfObject:selectedDay];
            [self.pickerView selectRow:dayIndex inComponent:2 animated:NO];
        }
        if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
            [self reloadHourArray];
            [self.pickerView reloadComponent:3];
            NSString *selectedHour = [self convertDateToString:self.selectedDate dateFormat:@"HH"];
            if ([self.hourList containsObject:selectedHour]) {
                NSInteger hourIndex = [self.hourList indexOfObject:selectedHour];
                [self.pickerView selectRow:hourIndex inComponent:3 animated:NO];
            }
            
            [self reloadMinuteArray];
            [self.pickerView reloadComponent:4];
            NSString *selectedMinute = [self convertDateToString:self.selectedDate dateFormat:@"m"];
            if ([self.minuteList containsObject:selectedMinute]) {
                NSInteger minuteIndex = [self.minuteList indexOfObject:selectedMinute];
                [self.pickerView selectRow:minuteIndex inComponent:4 animated:NO];
            }
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        [self reloadHourArray];
        [self.pickerView reloadComponent:0];
        NSString *selectedHour = [self convertDateToString:self.selectedDate dateFormat:@"HH"];
        if ([self.hourList containsObject:selectedHour]) {
            NSInteger hourIndex = [self.hourList indexOfObject:selectedHour];
            [self.pickerView selectRow:hourIndex inComponent:0 animated:NO];
        }
        
        [self reloadMinuteArray];
        [self.pickerView reloadComponent:1];
        NSString *selectedMinute = [self convertDateToString:self.selectedDate dateFormat:@"m"];
        if ([self.minuteList containsObject:selectedMinute]) {
            NSInteger minuteIndex = [self.minuteList indexOfObject:selectedMinute];
            [self.pickerView selectRow:minuteIndex inComponent:1 animated:NO];
        }
    }
    [self updateSelectedDate];
    [self showAnimated];
}

#pragma mark- Event Response methods
- (void)tapGesture:(UIGestureRecognizer *)gesture {
    
}

- (void)cancelBtnAction:(UIButton *)sender {
    [self closeAnimated];
}

- (void)confirmBtnAction:(UIButton *)sender {
    [self updateSelectedDate];
    if (self.dateValueChanged) {
        self.dateValueChanged(self.selectedDate);
    }
    [self closeAnimated];
}

#pragma mark- Net request
#pragma mark- Common Tool
- (NSString *)convertDateToString:(NSDate *)date dateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

- (NSDate *)convertStringToDate:(NSString *)dateStr format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:dateStr];
}

- (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)alignment {
    UILabel *lab = [[UILabel alloc] init];
    lab.textColor = textColor;
    lab.font = font;
    lab.textAlignment = alignment;
    return lab;
}

#pragma mark- Private methods
- (void)builData {
    if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        self.titleList = @[@"年", @"月", @"日", @"时", @"分"];
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        self.titleList = @[@"时", @"分"];
    } else {
        self.titleList = @[@"年", @"月", @"日"];
    }
}

- (void)layoutUI {
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
    
    self.contentHeight = 280;
    self.pickerMargin = 30;
    
    [self addSubview:self.contentView];
}

- (NSInteger)dayCountOfMonth:(NSInteger)month andYear:(NSInteger)year {
    NSInteger dayCount = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            dayCount = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            dayCount = 30;
            break;;
        case 2:
            if (year % 4 == 0 && year % 100 != 0) {//普通年份，非100整数倍
                dayCount = 29;
            } else if(year % 400 == 0) {//世纪年份
                dayCount = 29;
            } else {
                dayCount = 28;
            }
            break;
        default:
            break;
    }
    return dayCount;
}

- (void)reloadYearArray {
    NSInteger startYear = 1970;
    NSInteger endYear = 2099;
    
    if (self.startDate) {
        startYear = [[self convertDateToString:self.startDate dateFormat:@"yyyy"] integerValue];
    }
    
    if (self.endDate) {
        endYear = [[self convertDateToString:self.endDate dateFormat:@"yyyy"] integerValue];
    }
    
    NSMutableArray *yearArray = [NSMutableArray array];
    for (NSInteger i = startYear; i <= endYear; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.yearList = yearArray;
    
    NSInteger curIndex = [self.pickerView selectedRowInComponent:0];
    if (curIndex >= self.yearList.count) {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
}

- (void)reloadMonthArray {
    NSInteger startMonth = 1;
    NSInteger endMonth = 12;
    
    NSInteger yearIndex = [self.pickerView selectedRowInComponent:0];
    NSString *selectedYear = [self.yearList objectAtIndex:yearIndex];
    
    if (self.startDate) {
        NSString *startYear = [self convertDateToString:self.startDate dateFormat:@"yyyy"];
        if ([startYear isEqualToString:selectedYear]) {
            startMonth = [[self convertDateToString:self.startDate dateFormat:@"M"] integerValue];
        }
    }
    
    if (self.endDate) {
        NSString *endYear = [self convertDateToString:self.endDate dateFormat:@"yyyy"];
        if ([endYear isEqualToString:selectedYear]) {
            endMonth = [[self convertDateToString:self.endDate dateFormat:@"M"] integerValue];
        }
    }
    
    NSMutableArray *monthArray = [NSMutableArray array];
    for (NSInteger i = startMonth; i <= endMonth; i++) {
        [monthArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.monthList = monthArray;
    
    NSInteger curIndex = [self.pickerView selectedRowInComponent:1];
    if (curIndex >= self.monthList.count) {
        [self.pickerView selectRow:0 inComponent:1 animated:NO];
    }
}

- (void)reloadDayArray {
    NSInteger startDay = 1;
    
    NSInteger yearIndex = [self.pickerView selectedRowInComponent:0];
    NSString *selectedYear = [self.yearList objectAtIndex:yearIndex];
    NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
    NSString *selectedMonth = [self.monthList objectAtIndex:monthIndex];
    NSInteger endDay = [self dayCountOfMonth:[selectedMonth integerValue] andYear:[selectedYear integerValue]];
    
    if (self.startDate) {
        NSString *startDate = [self convertDateToString:self.startDate dateFormat:@"yyyyM"];
        NSString *selectedDate = [NSString stringWithFormat:@"%@%@", selectedYear, selectedMonth];
        if ([startDate isEqualToString:selectedDate]) {
            startDay = [[self convertDateToString:self.startDate dateFormat:@"d"] integerValue];
        }
    }
    
    if (self.endDate) {
        NSString *endDate = [self convertDateToString:self.endDate dateFormat:@"yyyyM"];
        NSString *selectedDate = [NSString stringWithFormat:@"%@%@", selectedYear, selectedMonth];
        if ([endDate isEqualToString:selectedDate]) {
            endDay = [[self convertDateToString:self.endDate dateFormat:@"d"] integerValue];
        }
    }
    
    NSMutableArray *dayArray = [NSMutableArray array];
    for (NSInteger i = startDay; i <= endDay; i++) {
        [dayArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.dayList = dayArray;
    
    NSInteger curIndex = [self.pickerView selectedRowInComponent:2];
    if (curIndex >= self.dayList.count) {
        [self.pickerView selectRow:0 inComponent:2 animated:NO];
    }
}

- (void)reloadHourArray {
    NSInteger startHour = 0;
    NSInteger endHour = 23;
    
    if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        NSInteger yearIndex = [self.pickerView selectedRowInComponent:0];
        NSString *selectedYear = [self.yearList objectAtIndex:yearIndex];
        NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
        NSString *selectedMonth = [self.monthList objectAtIndex:monthIndex];
        NSInteger dayIndex = [self.pickerView selectedRowInComponent:2];
        NSString *selectedDay = [self.dayList objectAtIndex:dayIndex];
        
        if (self.startDate) {
            NSString *startDate = [self convertDateToString:self.startDate dateFormat:@"yyyyMd"];
            NSString *selectedDate = [NSString stringWithFormat:@"%@%@%@", selectedYear, selectedMonth, selectedDay];
            if ([startDate isEqualToString:selectedDate]) {
                startHour = [[self convertDateToString:self.startDate dateFormat:@"H"] integerValue];
            }
        }
        
        if (self.endDate) {
            NSString *endDate = [self convertDateToString:self.endDate dateFormat:@"yyyyMd"];
            NSString *selectedDate = [NSString stringWithFormat:@"%@%@%@", selectedYear, selectedMonth, selectedDay];
            if ([endDate isEqualToString:selectedDate]) {
                endHour = [[self convertDateToString:self.endDate dateFormat:@"H"] integerValue];
            }
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        if (self.startDate) {
            startHour = [[self convertDateToString:self.startDate dateFormat:@"H"] integerValue];
        }
        
        if (self.endDate) {
            endHour = [[self convertDateToString:self.endDate dateFormat:@"H"] integerValue];
        }
    }
    
    NSMutableArray *hourArray = [NSMutableArray array];
    for (NSInteger i = startHour; i <= endHour; i++) {
        [hourArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.hourList = hourArray;
    
    if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        NSInteger curIndex = [self.pickerView selectedRowInComponent:0];
        if (curIndex >= self.hourList.count) {
            [self.pickerView selectRow:0 inComponent:0 animated:NO];
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        NSInteger curIndex = [self.pickerView selectedRowInComponent:3];
        if (curIndex >= self.hourList.count) {
            [self.pickerView selectRow:0 inComponent:3 animated:NO];
        }
    }
}

- (void)reloadMinuteArray {
    NSInteger startMinute = 0;
    NSInteger endMinute = 59;
    
    if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        NSInteger yearIndex = [self.pickerView selectedRowInComponent:0];
        NSString *selectedYear = [self.yearList objectAtIndex:yearIndex];
        NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
        NSString *selectedMonth = [self.monthList objectAtIndex:monthIndex];
        NSInteger dayIndex = [self.pickerView selectedRowInComponent:2];
        NSString *selectedDay = [self.dayList objectAtIndex:dayIndex];
        NSInteger hourIndex = [self.pickerView selectedRowInComponent:3];
        NSString *selectedHour = [self.hourList objectAtIndex:hourIndex];

        if (self.startDate) {
            NSString *startDate = [self convertDateToString:self.startDate dateFormat:@"yyyyMdH"];
            NSString *selectedDate = [NSString stringWithFormat:@"%@%@%@%@", selectedYear, selectedMonth, selectedDay, selectedHour];
            if ([startDate isEqualToString:selectedDate]) {
                startMinute = [[self convertDateToString:self.startDate dateFormat:@"m"] integerValue];
            }
        }
        
        if (self.endDate) {
            NSString *endDate = [self convertDateToString:self.endDate dateFormat:@"yyyyMdH"];
            NSString *selectedDate = [NSString stringWithFormat:@"%@%@%@%@", selectedYear, selectedMonth, selectedDay, selectedHour];
            if ([endDate isEqualToString:selectedDate]) {
                endMinute = [[self convertDateToString:self.endDate dateFormat:@"m"] integerValue];
            }
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        NSInteger hourIndex = [self.pickerView selectedRowInComponent:0];
        NSString *selectedHour = [self.hourList objectAtIndex:hourIndex];
        
        if (self.startDate) {
            NSString *startHour = [self convertDateToString:self.startDate dateFormat:@"H"];
            if ([startHour isEqualToString:selectedHour]) {
                startMinute = [[self convertDateToString:self.startDate dateFormat:@"m"] integerValue];
            }
        }
        
        if (self.endDate) {
            NSString *endHour = [self convertDateToString:self.endDate dateFormat:@"H"];
            if ([endHour isEqualToString:selectedHour]) {
                endMinute = [[self convertDateToString:self.endDate dateFormat:@"m"] integerValue];
            }
        }
    }
    
    NSMutableArray *minuteArray = [[NSMutableArray alloc] init];
    for (NSInteger i = startMinute; i <= endMinute;  i ++) {
        [minuteArray addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    self.minuteList = minuteArray;
    
    if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        NSInteger curIndex = [self.pickerView selectedRowInComponent:1];
        if (curIndex >= self.minuteList.count) {
            [self.pickerView selectRow:0 inComponent:1 animated:NO];
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        NSInteger curIndex = [self.pickerView selectedRowInComponent:4];
        if (curIndex >= self.minuteList.count) {
            [self.pickerView selectRow:0 inComponent:4 animated:NO];
        }
    }
}

- (void)drawSeparatorView:(UIView *)separatorView {
    CGFloat spacing = (CGRectGetWidth(separatorView.frame) / self.titleList.count - 40) / 2;
    CGFloat xOffset = spacing;
    separatorView.backgroundColor = [UIColor whiteColor];
    if (separatorView.subviews.count < 1) {
        for (NSInteger i = 0; i < self.titleList.count; i ++) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(xOffset, 0, 40, CGRectGetHeight(separatorView.frame))];
            lineView.backgroundColor = KTextColor;
            [separatorView addSubview:lineView];
            
            xOffset += 40 + 2 * spacing;
        }
    }
}

- (void)updateSelectedDate {
    if (self.datePickerType == BYCustomeDatePickerTypeShortDate || self.datePickerType == BYCustomeDatePickerTypeLongDate) {
        NSInteger yearIndex = [self.pickerView selectedRowInComponent:0];
        int selectedYear = [[self.yearList objectAtIndex:yearIndex] intValue];
        NSInteger monthIndex = [self.pickerView selectedRowInComponent:1];
        int selectedMonth = [[self.monthList objectAtIndex:monthIndex] intValue];
        NSInteger datIndex = [self.pickerView selectedRowInComponent:2];
        int selectedDay = [[self.dayList objectAtIndex:datIndex] intValue];
        if (self.datePickerType == BYCustomeDatePickerTypeShortDate) {
            NSString *currentDate = [NSString stringWithFormat:@"%d-%02d-%02d", selectedYear, selectedMonth, selectedDay];
            self.timeLab.text = currentDate;
            self.selectedDate = [self convertStringToDate:currentDate format:@"yyyy-MM-dd"];
        } else if (self.datePickerType == BYCustomeDatePickerTypeLongDate) {
            NSInteger hourIndex = [self.pickerView selectedRowInComponent:3];
            int selectedHour = [[self.hourList objectAtIndex:hourIndex] intValue];
            NSInteger minuteIndex = [self.pickerView selectedRowInComponent:4];
            int selectedMinute = [[self.minuteList objectAtIndex:minuteIndex] intValue];
            NSString *currentDate = [NSString stringWithFormat:@"%d-%02d-%02d %02d:%02d", selectedYear, selectedMonth, selectedDay, selectedHour, selectedMinute];
            self.timeLab.text = currentDate;
            self.selectedDate = [self convertStringToDate:currentDate format:@"yyyy-MM-dd HH:mm"];
        }
    } else if (self.datePickerType == BYCustomeDatePickerTypeTime) {
        NSInteger hourIndex = [self.pickerView selectedRowInComponent:0];
        int selectedHour = [[self.hourList objectAtIndex:hourIndex] intValue];
        NSInteger minuteIndex = [self.pickerView selectedRowInComponent:1];
        int selectedMinute = [[self.minuteList objectAtIndex:minuteIndex] intValue];
        NSString *currentDate = [NSString stringWithFormat:@"%@ %02d:%02d", [self convertDateToString:[NSDate new] dateFormat:@"yyyy-MM-dd"], selectedHour, selectedMinute];
        self.timeLab.text = currentDate;
        self.selectedDate = [self convertStringToDate:currentDate format:@"yyyy-MM-dd HH:mm"];
    }
}

- (void)showAnimated {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), self.contentHeight);
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - self.contentHeight, CGRectGetWidth([UIScreen mainScreen].bounds), self.contentHeight);
    }];
}

- (void)closeAnimated {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds), self.contentHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark- Setter and getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds) - self.contentHeight, CGRectGetWidth([UIScreen mainScreen].bounds), self.contentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        
        [_contentView addSubview:self.toolBarView];
        [_contentView addSubview:self.navView];
        [_contentView addSubview:self.pickerView];
//        [_contentView addSubview:self.self.datePicker];
    }
    return _contentView;
}

- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 63)];
        
        [_toolBarView addSubview:self.cancelBtn];
        [_toolBarView addSubview:self.confirmBtn];
        [_toolBarView addSubview:self.titleView];
        [_toolBarView addSubview:self.lineImgView];
    }
    return _toolBarView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(75, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 172, CGRectGetHeight(self.toolBarView.frame))];
        
        [_titleView addSubview:self.titleLab];
        [_titleView addSubview:self.timeLab];
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.centerX.equalTo(_titleView);
        }];
        
        [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(31);
            make.centerX.equalTo(_titleView);
        }];
    }
    return _titleView;
}

- (UIView *)navView {
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(self.pickerMargin, 64, CGRectGetWidth(self.contentView.frame) - self.pickerMargin * 2, 43)];
        
        CGFloat xOffset = 0;
        
        for (NSInteger i = 0; i < self.titleList.count; i++) {
            UILabel *titLab = [[UILabel alloc] init];
            titLab.textColor = KTextColor;
            titLab.font = [UIFont systemFontOfSize:18];
            titLab.textAlignment = NSTextAlignmentCenter;
            titLab.frame = CGRectMake(xOffset, 0, CGRectGetWidth(_navView.frame)/self.titleList.count, CGRectGetHeight(_navView.frame));
            titLab.text = [self.titleList objectAtIndex:i];
            [_navView addSubview:titLab];
            xOffset += CGRectGetWidth(_navView.frame) / self.titleList.count;
        }
    }
    return _navView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.text = @"请选择时间";
    }
    return _titleLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.textColor = KTextColor;
        _timeLab.font = [UIFont systemFontOfSize:16];
        _timeLab.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLab;
}

- (UIImageView *)lineImgView {
    if (!_lineImgView) {
        _lineImgView = [[UIImageView alloc] initWithFrame:CGRectMake(18, CGRectGetHeight(self.toolBarView.frame) - 1, CGRectGetWidth(self.toolBarView.frame) - 36, 1)];
        _lineImgView.backgroundColor = KTextColor;
    }
    return _lineImgView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, 60, CGRectGetHeight(self.toolBarView.frame))];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 75, 0, 60, CGRectGetHeight(self.toolBarView.frame))];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:KTextColor forState:UIControlStateNormal];
        _confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.pickerMargin, 108, CGRectGetWidth([UIScreen mainScreen].bounds) - self.pickerMargin * 2, 172)];
        _pickerView.backgroundColor = [UIColor purpleColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(self.pickerMargin, 108, CGRectGetWidth([UIScreen mainScreen].bounds) - self.pickerMargin * 2, 172)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        } else {
            // Fallback on earlier versions
        }
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    }
    return _datePicker;
}

@end
