//
//  BYCustomeDatePickerView.h
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/10/21.
//  Copyright © 2020 by. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define KTextColor [UIColor orangeColor]

typedef NS_ENUM(NSInteger, BYCustomeDatePickerType) {
    BYCustomeDatePickerTypeShortDate,
    BYCustomeDatePickerTypeLongDate,
    BYCustomeDatePickerTypeTime,
};

typedef void(^BYCustomeDatePickerViewValueChangedBlock)(NSDate *__nullable date);

@interface BYCustomeDatePickerView : UIView

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, assign) BOOL supportIndefinite;
@property (nonatomic,   copy) BYCustomeDatePickerViewValueChangedBlock dateValueChanged;

- (id)initWithType:(BYCustomeDatePickerType)datePickerType;
- (void)show;

@end

NS_ASSUME_NONNULL_END
