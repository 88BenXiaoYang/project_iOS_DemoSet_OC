//
//  BYHomePageViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/11/29.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYHomePageViewController.h"
#import "BYSlideView.h"
#import "BYStreamViewCell.h"
#import "BYBannerSliderViewCell.h"
#import "BYAvatarViewController.h"

@interface BYHomePageViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _contentOffsetY;
    CGFloat _oldContentOffsetY;
    CGFloat _newContentOffsetY;
}

@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BYHomePageViewController

#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepare];
    [self placeSubViews];
}

#pragma mark- Overwrite
#pragma mark- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdenti"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"头像列表";
        return cell;
    } else if (indexPath.row == 1) {
        BYStreamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BYStreamViewCell class])];
        return cell;
    }
    BYBannerSliderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BYBannerSliderViewCell class])];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 50;
    } else if (indexPath.row == 1) {
        return 150;
    }
    
    return 196;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BYAvatarViewController *avatarVC = [[BYAvatarViewController alloc] init];
        avatarVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:avatarVC animated:YES];
    }
}

//判断滑动方向
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _contentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _newContentOffsetY = scrollView.contentOffset.y;
    if (_newContentOffsetY > _oldContentOffsetY && _oldContentOffsetY > _contentOffsetY) {
        //向上滑动
        //to do ...
    } else if (_newContentOffsetY < _oldContentOffsetY && _oldContentOffsetY < _contentOffsetY) {
        //向下滑动
        //to do ...
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _oldContentOffsetY = scrollView.contentOffset.y;
}

#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"~~~";
    
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)placeSubViews {
    BYSlideView *slideView = [[BYSlideView alloc] initWithFrame:CGRectMake(0, 100, self.screenWidth, 50)];
    slideView.slideItemArray = @[@"AAA", @"BBB", @"CCC"];
    //    slideView.selectedIndex = 1;
    //    slideView.slideViewColor = [UIColor yellowColor];
    [self.view addSubview:slideView];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(slideView.frame), self.screenWidth, self.screenHeight - CGRectGetMaxY(slideView.frame));
}

#pragma mark- Setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 100;
        [_tableView registerClass:[BYStreamViewCell class] forCellReuseIdentifier:NSStringFromClass([BYStreamViewCell class])];
        [_tableView registerClass:[BYBannerSliderViewCell class] forCellReuseIdentifier:NSStringFromClass([BYBannerSliderViewCell class])];
    }
    return _tableView;
}

@end
