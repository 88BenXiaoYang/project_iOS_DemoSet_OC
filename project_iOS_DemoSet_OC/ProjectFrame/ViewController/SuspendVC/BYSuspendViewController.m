//
//  BYSuspendViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/9/26.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYSuspendViewController.h"
#import "BYSuspendView.h"

@interface BYSuspendViewController ()

@property (nonatomic, strong) BYSuspendView *suspendView;

@end

@implementation BYSuspendViewController
#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutUI];
}

#pragma mark- Overwrite
#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
- (void)showSuspendView:(UIButton *)sender {
    BYSuspendView *suspendView = [[BYSuspendView alloc] init];
//    if (sender.tag == 1 || sender.tag == 2) {
//        [suspendView showWithType:BYSuspendTypeVertical anchorView:sender];
//    } else {
//        [suspendView showWithType:BYSuspendTypeHorizontal anchorView:sender];
//    }
    if (sender.tag == 1) {
        [suspendView showWithStyleTpye:BYStyleTpyeLeft anchorView:sender];
    } else {
        [suspendView showWithStyleTpye:BYStyleTpyeRight anchorView:sender];
    }
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)layoutUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *leftBtn = [self createItemBtnWithRect:CGRectMake(15, 150, 100, 40) title:@"leftBtn" tag:1];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn = [self createItemBtnWithRect:CGRectMake(kScreenWidth_suspend-115, 150, 100, 40) title:@"rightBtn" tag:2];
    [self.view addSubview:rightBtn];
}

- (UIButton *)createItemBtnWithRect:(CGRect)rect title:(NSString *)title tag:(NSInteger)tag {
    UIButton *btn = [[UIButton alloc] initWithFrame:rect];
    btn.tag = tag;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showSuspendView:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

#pragma mark- Setter and getter
- (BYSuspendView *)suspendView {
    if (!_suspendView) {
        _suspendView = [[BYSuspendView alloc] init];
    }
    return _suspendView;
}

@end
