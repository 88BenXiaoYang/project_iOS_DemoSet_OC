//
//  BYSlideView.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/30.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYSlideView.h"

static NSInteger slideItemCommonTag = 1000;

@interface BYSlideView ()

@property (nonatomic, strong) UIImageView *slideImageView;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation BYSlideView

#pragma mark- Live circle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
        [self placeSubViews];
    }
    return self;
}

#pragma mark- Delegate
#pragma mark- Event Response methods
- (void)changeSlideItem:(UIButton *)sender {
    self.currentIndex = sender.tag - slideItemCommonTag;
    if (self.itemClickedBlock) {
        self.itemClickedBlock(self.currentIndex);
    }
}

#pragma mark- Private methods
- (void)prepare {
    self.currentIndex = 0; //default currentIndex
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)placeSubViews {
    
}

#pragma mark- Setter and getter
- (UIImageView *)slideImageView {
    if (!_slideImageView) {
        _slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, 0, 2)];
        _slideImageView.backgroundColor = [UIColor blueColor]; //default slideViewColor
        [self addSubview:_slideImageView];
    }
    return _slideImageView;
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
        }
    }];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        }
    }];
}

- (void)setSlideViewColor:(UIColor *)slideViewColor {
    _slideViewColor = slideViewColor;
    self.slideImageView.backgroundColor = slideViewColor;
}

- (void)setSlideItemArray:(NSArray *)slideItemArray {
    _slideItemArray = slideItemArray;
    
    CGFloat itemW = self.screenWidth / slideItemArray.count;
    [slideItemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *itemBtn = [self createSlideItemBtn];
        itemBtn.tag = slideItemCommonTag + idx;
        itemBtn.frame = CGRectMake(itemW * idx, 0, itemW, self.frame.size.height);
        [itemBtn setTitle:obj forState:UIControlStateNormal];
        [self addSubview:itemBtn];
        if (idx == self.currentIndex) {
            itemBtn.selected = YES;
            self.slideImageView.frame = CGRectMake(itemW * idx, self.frame.size.height - CGRectGetHeight(self.slideImageView.frame), itemW, CGRectGetHeight(self.slideImageView.frame));
        } else {
            itemBtn.selected = NO;
        }
    }];
}

- (UIButton *)createSlideItemBtn {
    UIButton *slideItemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [slideItemBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [slideItemBtn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [slideItemBtn addTarget:self action:@selector(changeSlideItem:) forControlEvents:UIControlEventTouchUpInside];
    return slideItemBtn;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex != currentIndex) {
        UIButton *preSelectedBtn = [self viewWithTag:_currentIndex + slideItemCommonTag];
        preSelectedBtn.selected = NO;
        
        UIButton *currentSelectesBtn = [self viewWithTag:currentIndex + slideItemCommonTag];
        currentSelectesBtn.selected = YES;
        
        CGRect slideViewRect = self.slideImageView.frame;
        slideViewRect.origin.x = CGRectGetMinX(currentSelectesBtn.frame);
        slideViewRect.size.width = CGRectGetWidth(currentSelectesBtn.frame);
        [UIView animateWithDuration:.2 animations:^{
            self.slideImageView.frame = slideViewRect;
        }];
        
        _currentIndex = currentIndex;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    self.currentIndex = selectedIndex;
}

@end
