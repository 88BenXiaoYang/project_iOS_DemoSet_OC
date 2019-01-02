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

@property (nonatomic, strong) UIView *avaterBgView;

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
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    
}

- (void)placeSubViews {
    [self addSubview:self.avaterBgView];
    [self.avaterBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.width.height.mas_offset(64);
    }];
}

#pragma mark- Setter and getter
- (UIView *)avaterBgView {
    if (!_avaterBgView) {
        _avaterBgView = [[UIView alloc] init];
        [_avaterBgView addSubview:self.avatarImageView];
    }
    return _avaterBgView;
}

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20 + (44 - 20)/2, 20, 20)];
        _avatarImageView.backgroundColor = [UIColor purpleColor];
    }
    return _avatarImageView;
}

@end
