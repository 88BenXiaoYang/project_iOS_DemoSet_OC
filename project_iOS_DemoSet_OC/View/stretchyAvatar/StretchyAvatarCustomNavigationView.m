//
//  StretchyAvatarCustomNavigationView.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2019/1/1.
//  Copyright © 2019 by. All rights reserved.
//

#import "StretchyAvatarCustomNavigationView.h"
#import "Masonry.h"

@interface StretchyAvatarCustomNavigationView ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *backBtn;

@end

@implementation StretchyAvatarCustomNavigationView

#pragma mark- Live circle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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
- (void)goBack {
    if (self.customNaviViewBackBlock) {
        self.customNaviViewBackBlock();
    }
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
}

- (void)placeSubViews {
    [self addSubview:self.containerView];
    [self addSubview:self.backBtn];
    [self.containerView addSubview:self.avatarImageView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3.5);
        make.centerX.mas_equalTo(0);
        make.width.height.mas_equalTo(37);
    }];
}

#pragma mark- Setter and getter
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:[UIImage imageNamed:@"back_icon_white"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 37/2;
        _avatarImageView.layer.masksToBounds=YES;
        _avatarImageView.backgroundColor = [UIColor orangeColor];
    }
    return _avatarImageView;
}

@end
