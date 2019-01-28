//
//  BYInputVCCell.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/28.
//  Copyright © 2019 by. All rights reserved.
//

#import "BYInputVCCell.h"
#import "Masonry.h"

@interface BYInputVCCell ()

@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UIImageView *contentBgImageView;

@end

@implementation BYInputVCCell

#pragma mark- Live circle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self prepare];
        [self placeSubViews];
    }
    return self;
}

#pragma mark- Overwrite
#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)placeSubViews {
    [self.contentView addSubview:self.contentBgImageView];
    [self.contentView addSubview:self.contentLab];
}

#pragma mark- Setter and getter
- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = [[UILabel alloc] init];
        _contentLab.numberOfLines = 0;
        _contentLab.font = [UIFont systemFontOfSize:14];
        _contentLab.textColor = [UIColor blackColor];
        _contentLab.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLab;
}

- (UIImageView *)contentBgImageView {
    if (!_contentBgImageView) {
        _contentBgImageView = [[UIImageView alloc] init];
        _contentBgImageView.layer.cornerRadius = 5;
        _contentBgImageView.layer.masksToBounds = YES;
        _contentBgImageView.backgroundColor = [UIColor orangeColor];
    }
    return _contentBgImageView;
}

- (void)setInputModel:(BYInputModel *)inputModel {
    self.contentLab.text = inputModel.contentStr;
    
    [self.contentLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-20);
    }];
    
    [self.contentBgImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
}

@end
