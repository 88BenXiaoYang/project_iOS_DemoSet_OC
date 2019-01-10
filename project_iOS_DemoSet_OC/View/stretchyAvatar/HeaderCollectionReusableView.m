//
//  HeaderCollectionReusableView.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2019/1/1.
//  Copyright © 2019 by. All rights reserved.
//

#import "HeaderCollectionReusableView.h"
#import "Masonry.h"
#import "BYTools.h"

@interface HeaderCollectionReusableView ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation HeaderCollectionReusableView

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
- (void)layoutSubviews {
    [super layoutSubviews];
//    self.bgImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.containerView.frame = CGRectMake(-self.frame.origin.x, -self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    self.backgroundColor = [UIColor clearColor];
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)placeSubViews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.containerView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(130);
    }];
}

#pragma mark- Setter and getter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
        
        [_containerView addSubview:self.contentContainerView];
        [_containerView addSubview:self.headerImageView];
        
        [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo((self.screenWidth - 70)/2);
            make.width.height.mas_equalTo(70);
        }];
        
        [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(self.screenWidth - 20, 200 - 5));
        }];
    }
    return _containerView;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.cornerRadius = 70/2;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headerImageView;
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"headerbgimageview"];
    }
    return _bgImageView;
}

- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
        _contentContainerView.backgroundColor = [UIColor whiteColor];
        _contentContainerView.layer.cornerRadius = 5;
        _contentContainerView.layer.masksToBounds = YES;
    }
    return _contentContainerView;
}

@end
