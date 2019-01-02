//
//  BYBannerSlideView.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2018/12/30.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYBannerSlideView.h"
#import "Masonry.h"

@interface BYBannerSlideView ()

@property (nonatomic, strong) UIScrollView *scroView;
@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation BYBannerSlideView

#pragma mark- Live circle
- (instancetype)initWithFrame:(CGRect)frame
{
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
- (void)choiceItem:(id)sender
{
    
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare
{
    
}

- (void)placeSubViews
{
    [self layoutStackViewAndScrollView];
}

- (void)addStackItemsWithStackView:(UIStackView *)stackView itemW:(CGFloat)itemW itemH:(CGFloat)itemH
{
    for (NSInteger i = 0; i < 5; i ++) {
        UIButton *btn = [[UIButton alloc] init];
        //        btn.tag = commonTag + i;
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1.0];
        NSString *btnNumber = [NSString stringWithFormat:@"btn : %ld", i];
        [btn setTitle:btnNumber forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(choiceItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [stackView addArrangedSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(itemW);
            make.height.mas_equalTo(itemH);
        }];
        
        //        UIImageView *bannerImgView = [self bannerImageView];
        //
        //        [bannerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.width.mas_equalTo(itemW);
        //            make.height.mas_equalTo(itemH);
        //        }];
    }
}

- (void)layoutStackViewAndScrollView
{
    [self addSubview:self.scroView];
    [self.scroView addSubview:self.stackView];
    
    [_scroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scroView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self addStackItemsWithStackView:_stackView itemW:303 itemH:166];
}

#pragma mark- Setter and getter
- (UIScrollView *)scroView
{
    if (!_scroView) {
        _scroView = [[UIScrollView alloc] init];
        _scroView.backgroundColor = [UIColor whiteColor];
        _scroView.showsHorizontalScrollIndicator = NO;
        [_scroView setContentInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    return _scroView;
}

- (UIStackView *)stackView
{
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.spacing = 10;
    }
    return _stackView;
}

- (UIImageView *)bannerImageView
{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.contentMode = UIViewContentModeScaleToFill;
    imgView.backgroundColor = [UIColor orangeColor];
    return imgView;
}

@end
