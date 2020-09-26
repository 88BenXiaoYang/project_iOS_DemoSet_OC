//
//  BYSuspendContentCell.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/9/26.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYSuspendContentCell.h"

@interface BYSuspendContentCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation BYSuspendContentCell
#pragma mark- Live circle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutUI];
    }
    return self;
}

#pragma mark- Overwrite
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if ([self.currentStr isEqualToString:self.titleStr]) {
        self.titleLabel.textColor = [UIColor orangeColor];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
    }
}

#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)layoutUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark- Setter and getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = titleStr;
}

@end
