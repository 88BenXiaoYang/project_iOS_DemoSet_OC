//
//  BYAvatarViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2019/1/1.
//  Copyright © 2019 by. All rights reserved.
//

#import "BYAvatarViewController.h"
#import "Masonry.h"
#import "HeaderCollectionReusableView.h"
#import "StretchyHeaderCollectionViewLayout.h"
#import "StretchyAvatarCustomNavigationView.h"
#import "BYStretchyAvatarCollectionViewCell.h"
#import "BYTools.h"

@interface BYAvatarViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) StretchyHeaderCollectionViewLayout *stretchyLayout;
@property (nonatomic, strong) StretchyAvatarCustomNavigationView *customNavigationView;
@property (nonatomic, strong) UIView *customStatusView;
@property (nonatomic, strong) UIImageView *avaImageView;
@property (nonatomic, strong) UIImageView *collectionBgImageView;
@property (nonatomic, strong) UICollectionView *containerCollectionView;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation BYAvatarViewController

#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self placeSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark- Overwrite
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark- Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BYStretchyAvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BYStretchyAvatarCollectionViewCell class]) forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.row == 0) {
            HeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderCollectionReusableView class]) forIndexPath:indexPath];
            self.avaImageView = headerView.headerImageView;
            return headerView;
        }
    }
    return nil;
}

//layoutDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.view.frame.size.width, 200);
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.screenWidth, 160);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _containerCollectionView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        [self changeNavAlphaWithConnentOffset:offsetY];
    }
}

#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    self.view.backgroundColor = [UIColor whiteColor];
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
}

- (void)placeSubViews {
    [self.view addSubview:self.customStatusView];
    [self.view addSubview:self.customNavigationView];
    [self.view addSubview:self.containerCollectionView];
    
    [self.customStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.equalTo(self.customNavigationView);
    }];
    
    [self.customNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.containerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.customNavigationView.mas_bottom);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

-(void)changeNavAlphaWithConnentOffset:(CGFloat)offsetY {
    if (offsetY> - 20) {
        CGFloat startChangeOffset = -20;
        CGFloat d = 56;
        CGFloat imageReduce = 1-(offsetY-startChangeOffset)/(d*3);
        CGFloat alpha = MIN(1,(offsetY + 20)/100);
        self.customNavigationView.containerView.alpha = (alpha <= 0.2) ? 0.0 : alpha;
        CGAffineTransform t = CGAffineTransformMakeTranslation(0,(1-alpha));
        self.avaImageView.transform = CGAffineTransformScale(t,imageReduce, imageReduce);
        if (offsetY > 50) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
//                self.customNavigationView.alpha = alpha;
            }completion:^(BOOL finished) {
            }];
            if (alpha > 0.5)
            {
                [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.avaImageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            } else {
                self.avaImageView.hidden = NO;
            }
        }else{
            self.avaImageView.hidden = NO;
        }
    }
}

#pragma mark- Setter and getter
- (UIView *)customStatusView {
    if (!_customStatusView) {
        _customStatusView = [[UIView alloc] init];
        _customStatusView.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0x4c6ff9];
    }
    return _customStatusView;
}

- (StretchyAvatarCustomNavigationView *)customNavigationView {
    if (!_customNavigationView) {
        _customNavigationView = [[StretchyAvatarCustomNavigationView alloc] init];
        _customNavigationView.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0x4c6ff9];
        _customNavigationView.containerView.alpha = 0;
        __weak typeof(BYAvatarViewController) *weakself = self;
        _customNavigationView.customNaviViewBackBlock = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
    }
    return _customNavigationView;
}

- (StretchyHeaderCollectionViewLayout *)stretchyLayout {
    if (!_stretchyLayout) {
        _stretchyLayout = [[StretchyHeaderCollectionViewLayout alloc] init];
        _stretchyLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
    }
    return _stretchyLayout;
}

- (UIImageView *)collectionBgImageView {
    if (!_collectionBgImageView) {
        _collectionBgImageView = [[UIImageView alloc] init];
        _collectionBgImageView.image = [UIImage imageNamed:@"listbgimageview"];
    }
    return _collectionBgImageView;
}

- (UICollectionView *)containerCollectionView {
    if (!_containerCollectionView) {
        _containerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.stretchyLayout];
        _containerCollectionView.backgroundColor = [UIColor whiteColor];
        _containerCollectionView.alwaysBounceVertical = YES;
        _containerCollectionView.showsVerticalScrollIndicator = NO;
        _containerCollectionView.showsHorizontalScrollIndicator = NO;
        _containerCollectionView.dataSource = self;
        _containerCollectionView.delegate = self;
        _containerCollectionView.backgroundView = self.collectionBgImageView;
        
        [_containerCollectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderCollectionReusableView class])];
        [_containerCollectionView registerClass:[BYStretchyAvatarCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BYStretchyAvatarCollectionViewCell class])];
    }
    return _containerCollectionView;
}

@end
