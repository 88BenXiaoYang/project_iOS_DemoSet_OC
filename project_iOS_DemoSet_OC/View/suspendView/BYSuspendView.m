//
//  BYSuspendView.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/9/26.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYSuspendView.h"
#import "BYSuspendContentCell.h"

@interface BYSuspendView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) CGRect anchorRect;
@property (nonatomic, assign) CGFloat sideslipOffset;
@property (nonatomic, assign) BYSuspendType styleType;
@property (nonatomic, assign) BYSShowOrientationType showOrientationType;
//content detial
@property (nonatomic, strong) UIImageView *contentBgImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BYStyleTpye type;
@property (nonatomic,   copy) NSString *currentStr;

@end

@implementation BYSuspendView
#pragma mark- Live circle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self layoutUI];
    }
    return self;
}

#pragma mark- Overwrite
#pragma mark- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYSuspendContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BYSuspendContentCell class])];
    cell.titleStr = self.dataArray[indexPath.row];
    cell.currentStr = self.currentStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentStr = self.dataArray[indexPath.row];
    [self.tableView reloadData];
    [self dismissStyleVertical];
}

#pragma mark- Notification methods
#pragma mark- Interface methods
- (void)showWithType:(BYSuspendType)type anchorView:(UIButton *)anchorView {
    self.styleType = type;
    self.anchorRect = [anchorView convertRect:anchorView.bounds toView:self.window];
    if (type == BYSuspendTypeSideslip) {
        [self showStyleSideslip];
    } else if (type == BYSuspendTypeHorizontal) {
        [self showStyleHorizontal];
    } else if (type == BYSuspendTypeVertical) {
        [self showStyleVertical];
    }
}

- (void)showWithStyleTpye:(BYStyleTpye)styleType anchorView:(UIButton *)anchorView {
    self.type = styleType;
    self.anchorRect = [anchorView convertRect:anchorView.bounds toView:self.window];
    [self show];
}

#pragma mark- Event Response methods
- (void)swipLeft {
    [self dismissStyleSideslip];
}

- (void)tapGesture:(UIGestureRecognizer *)gesture {
//    if (self.styleType == BYSuspendTypeHorizontal) {
//        [self dismissStyleHorizontal];
//    } else {
//        [self dismissStyleVertical];
//    }
    
    [self dismiss];
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)layoutUI {
    [self addSubview:self.bgView];
    [self.window addSubview:self];
}

#pragma mark- Style type
- (void)show {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.bgView addGestureRecognizer:tapGesture];
    
    CGFloat contentViewH = 250;
    if (self.type == BYStyleTpyeLeft) {
        self.contentBgImageView.backgroundColor = [UIColor orangeColor];
        self.contentView.frame = CGRectMake(CGRectGetMinX(self.anchorRect), CGRectGetMaxY(self.anchorRect), 200, 0);
    } else {
        self.contentBgImageView.backgroundColor = [UIColor purpleColor];
        self.contentView.frame = CGRectMake(CGRectGetMaxX(self.anchorRect)-200, CGRectGetMaxY(self.anchorRect), 200, 0);
    }

    [self addSubview:self.contentView];
    
    CGRect frame = self.contentView.frame;
    frame.size.height = contentViewH;
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
    }];
}

- (void)dismiss {
    CGRect frame = self.contentView.frame;
    frame.size.height = 0;
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//默认
- (void)showStyleDefault {
    [self showStyleSideslip];
}

- (void)dismissStyleDefault {
    [self dismissStyleSideslip];
}

//侧滑
- (void)showStyleSideslip {
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipLeft)];
    [self addGestureRecognizer:swipeGesture];
    
    self.sideslipOffset = 100;
    self.contentView.frame = CGRectMake(kScreenWidth_suspend, 0, kScreenWidth_suspend - self.sideslipOffset, kScreenHeight_suspend);

    [self addSubview:self.contentView];
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = self.sideslipOffset;
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
    }];
}

- (void)dismissStyleSideslip {
    CGRect frame = self.contentView.frame;
    frame.origin.x = kScreenWidth_suspend;
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//水平
- (void)showStyleHorizontal {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.bgView addGestureRecognizer:tapGesture];
    
    //定位垂直锚点、方向
    CGFloat contentViewW = 100;
    if (CGRectGetMinX(self.anchorRect)+contentViewW >= kScreenWidth_suspend) {
        self.showOrientationType = BYSShowOrientationTypeLeft;
        self.contentView.frame = CGRectMake(CGRectGetMaxX(self.anchorRect), CGRectGetMaxY(self.anchorRect), 0, 150);
    } else {
        self.contentView.frame = CGRectMake(CGRectGetMinX(self.anchorRect), CGRectGetMaxY(self.anchorRect), 0, 150);
    }

    [self addSubview:self.contentView];
    
    CGRect frame = self.contentView.frame;
    frame.size.width = contentViewW;
    if (self.showOrientationType == BYSShowOrientationTypeLeft) {
        frame.origin.x = CGRectGetMaxX(self.anchorRect) - contentViewW;
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
    }];
}

- (void)dismissStyleHorizontal {
    CGRect frame = self.contentView.frame;
    frame.size.width = 0;
    if (self.showOrientationType == BYSShowOrientationTypeLeft) {
        frame.origin.x = CGRectGetMaxX(self.anchorRect);
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//垂直
- (void)showStyleVertical {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.bgView addGestureRecognizer:tapGesture];
    
    //定位垂直锚点、方向
    CGFloat contentViewH = 150;
    if (CGRectGetMaxY(self.anchorRect)+contentViewH >= kScreenHeight_suspend) {
        self.showOrientationType = BYSShowOrientationTypeUp;
        self.contentView.frame = CGRectMake(CGRectGetMinX(self.anchorRect), CGRectGetMinY(self.anchorRect), 100, 0);
    } else {
        self.contentView.frame = CGRectMake(CGRectGetMinX(self.anchorRect), CGRectGetMaxY(self.anchorRect), 100, 0);
    }

    [self addSubview:self.contentView];
    
    CGRect frame = self.contentView.frame;
    frame.size.height = contentViewH;
    
    if (self.showOrientationType == BYSShowOrientationTypeUp) {
        frame.origin.y = CGRectGetMinY(self.anchorRect) - contentViewH;
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
    }];
}

- (void)dismissStyleVertical {
    CGRect frame = self.contentView.frame;
    frame.size.height = 0;
    
    if (self.showOrientationType == BYSShowOrientationTypeUp) {
        frame.origin.y = CGRectGetMinY(self.anchorRect);
    }
    
    [UIView animateWithDuration:.25 animations:^{
        self.contentView.frame = frame;
        self.bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark- Setter and getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor clearColor];
//        _bgView.alpha = 0.5;
    }
    return _bgView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.masksToBounds = YES;
        
        [_contentView addSubview:self.contentBgImageView];
        [_contentView addSubview:self.tableView];
    }
    return _contentView;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

- (UIImageView *)contentBgImageView {
    if (!_contentBgImageView) {
        _contentBgImageView = [[UIImageView alloc] init];
        _contentBgImageView.layer.masksToBounds = YES;
        _contentBgImageView.layer.cornerRadius = 5;
        _contentBgImageView.frame = CGRectMake(0, 0, 200, 250);
    }
    return _contentBgImageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(5, 5, 190, 240);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[BYSuspendContentCell class] forCellReuseIdentifier:NSStringFromClass([BYSuspendContentCell class])];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"testA", @"testB", @"testC", @"testD", @"testE", @"testF"];
    }
    return _dataArray;
}

@end
