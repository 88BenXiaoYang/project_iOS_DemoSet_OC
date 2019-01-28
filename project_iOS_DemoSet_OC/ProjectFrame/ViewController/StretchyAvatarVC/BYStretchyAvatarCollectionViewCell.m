//
//  BYStretchyAvatarCollectionViewCell.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2019/1/1.
//  Copyright © 2019 by. All rights reserved.
//

#import "BYStretchyAvatarCollectionViewCell.h"
#import "Masonry.h"

@interface BYStretchyAvatarCollectionViewCell ()

@property (nonatomic, strong) UIView *contentContainerView;

@end

@implementation BYStretchyAvatarCollectionViewCell

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
    self.backgroundColor = [UIColor clearColor];
}

- (void)placeSubViews {
    [self.contentView addSubview:self.contentContainerView];
    
    [self.contentContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
}

#pragma mark- Setter and getter
- (UIView *)contentContainerView {
    if (!_contentContainerView) {
        _contentContainerView = [[UIView alloc] init];
        _contentContainerView.layer.cornerRadius = 5;
        _contentContainerView.layer.masksToBounds = YES;
        _contentContainerView.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1.0];
    }
    return _contentContainerView;
}

@end
