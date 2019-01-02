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

@interface BYAvatarViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) StretchyHeaderCollectionViewLayout *stretchyLayout;
@property (nonatomic, strong) StretchyAvatarCustomNavigationView *customNavigationView;
@property (nonatomic, strong) UIImageView *avaImageView;
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
#pragma mark- Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
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
    return CGSizeMake(self.view.frame.size.width/2, 100);
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
    [self.view addSubview:self.containerCollectionView];
    [self.view addSubview:self.customNavigationView];
}

-(void)changeNavAlphaWithConnentOffset:(CGFloat)offsetY {
    if (offsetY> - 20) {
        CGFloat startChangeOffset = -20;
        CGFloat d = 56;
        CGFloat imageReduce = 1-(offsetY-startChangeOffset)/(d*3);
        CGFloat alpha = MIN(1,(offsetY + 20)/100);
        CGAffineTransform t = CGAffineTransformMakeTranslation(0,(1-alpha));
        self.avaImageView.transform = CGAffineTransformScale(t,imageReduce, imageReduce);
        if (offsetY > 50) {
            [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.customNavigationView.backgroundColor          =  [UIColor redColor];
                
            }completion:^(BOOL finished) {
            }];
            if (alpha > 0.5)
            {
                [UIView animateWithDuration:1 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.customNavigationView.avatarImageView.hidden = NO;
                    self.avaImageView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }else
            {
                self.avaImageView.hidden = NO;
                
            }
        }else{
            self.avaImageView.hidden = NO;
            self.customNavigationView.avatarImageView.hidden = YES;
            self.customNavigationView.backgroundColor          = [UIColor clearColor];
        }
    }
}

#pragma mark- Setter and getter
- (StretchyAvatarCustomNavigationView *)customNavigationView {
    if (!_customNavigationView) {
        _customNavigationView = [[StretchyAvatarCustomNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, 64)];
        [_customNavigationView.avatarImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(23);
            make.width.height.mas_offset(37);
            make.centerX.mas_equalTo(0);
        }];
        _customNavigationView.avatarImageView.backgroundColor = [UIColor orangeColor];
        _customNavigationView.avatarImageView.layer.cornerRadius = 37/2;
        _customNavigationView.avatarImageView.layer.masksToBounds=YES;
//        _customNavigationView.avatarImageView.layer.borderWidth=1;
//        _customNavigationView.avatarImageView.layer.borderColor=[UIColor whiteColor].CGColor;
        _customNavigationView.avatarImageView.hidden = YES;
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

- (UICollectionView *)containerCollectionView {
    if (!_containerCollectionView) {
        _containerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight) collectionViewLayout:self.stretchyLayout];
        _containerCollectionView.backgroundColor = [UIColor whiteColor];
        _containerCollectionView.alwaysBounceVertical = YES;
        _containerCollectionView.showsVerticalScrollIndicator = NO;
        _containerCollectionView.showsHorizontalScrollIndicator = NO;
        _containerCollectionView.dataSource = self;
        _containerCollectionView.delegate = self;
        
        [_containerCollectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HeaderCollectionReusableView class])];
        [_containerCollectionView registerClass:[BYStretchyAvatarCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BYStretchyAvatarCollectionViewCell class])];
    }
    return _containerCollectionView;
}

@end
