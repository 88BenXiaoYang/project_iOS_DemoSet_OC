//
//  MasonryPracticeAViewController.m
//  AppA
//
//  Created by by on 2018/12/18.
//  Copyright © 2018 BY. All rights reserved.
//

#import "MasonryPracticeAViewController.h"
#import "Masonry.h"

#define MasonryScreenW [UIScreen mainScreen].bounds.size.width

@interface MasonryPracticeAViewController ()

@end

@implementation MasonryPracticeAViewController
#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepare];
    [self placeSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark- Overwrite
#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare
{
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)placeSubViews
{
//    [self layoutScrollView];
//    [self layoutXYViews];
    [self layoutGrid];
}

- (void)layoutScrollView
{
    UIScrollView *scroV = [[UIScrollView alloc] init];
    scroV.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:scroV];
    
    [scroV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    UIView *containerV = [[UIView alloc] init];
    containerV.backgroundColor = [UIColor purpleColor];
    [scroV addSubview:containerV];
    
    [containerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroV);
        make.width.equalTo(scroV);
    }];
    
    UIView *lastV = nil;
    
    for (NSInteger i = 0; i < 10; i ++) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1.0];
        [containerV addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(containerV);
            make.height.mas_equalTo(i * 10 + 20);
            
            if (lastV) {
                make.top.equalTo(lastV.mas_bottom);
            } else {
                make.top.equalTo(containerV.mas_top);
            }
        }];
        
        lastV = v;
    }
    
    [containerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastV.mas_bottom);
    }];
}

- (void)layoutXYViews
{
    UIView *sv11 = [[UIView alloc] init];
    sv11.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv11];
    
    UIView *sv12 = [[UIView alloc] init];
    sv12.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv12];
    
    UIView *sv13 = [[UIView alloc] init];
    sv13.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv13];
    
    UIView *sv21 = [[UIView alloc] init];
    sv21.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv21];
    
    UIView *sv31 = [[UIView alloc] init];
    sv31.backgroundColor = [UIColor redColor];
    [self.view addSubview:sv31];
    
    [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@[sv12, sv13]);
        make.centerX.equalTo(@[sv21, sv31]);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
    }];
    
    [self layoutVariedViewH:@[sv11, sv12, sv13]];
    [self layoutVariedViewV:@[sv11, sv21, sv31]];
}

- (void)layoutGrid
{
    //由子视图决定父视图大小
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view);
    }];
    
    [self layoutGridWithCellWidth:10 cellHeight:10 numPerRow:2 totalNum:9 viewPadding:10 viewPaddingCell:10 superView:containerView];
}

- (void)layoutVariedViewH:(NSArray *)views
{
    NSMutableArray *spaceViews = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (NSInteger i = 0; i < views.count + 1; i ++) {
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor redColor];
        [spaceViews addObject:v];
        [self.view addSubview:v];
        
        //确定填充间隔View的高
        //        [v mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.width.equalTo(v.mas_height);
        //        }];
    }
    
    UIView *v0 = spaceViews[0];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.centerY.equalTo((UIView *)views[0]);
    }];
    
    UIView *lastSpaceView = v0;
    
    for (NSInteger i = 0; i < views.count; i ++) {
        UIView *objV = views[i];
        UIView *spaceV = spaceViews[i + 1];
        
        [objV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpaceView.mas_right);
        }];
        
        [spaceV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(objV.mas_right);
            make.centerY.equalTo(objV);
            make.width.equalTo(v0);
        }];
        
        lastSpaceView = spaceV;
    }
    
    [lastSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
    }];
}

- (void)layoutVariedViewV:(NSArray *)views
{
    NSMutableArray *spaceViews = [NSMutableArray arrayWithCapacity:views.count + 1];
    
    for (NSInteger i = 0; i < views.count + 1; i ++) {
        UIView *v = [[UIView alloc] init];
        [self.view addSubview:v];
        [spaceViews addObject:v];
    }
    
    UIView *v0 = spaceViews[0];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo((UIView *)views[0]);
    }];
    
    UIView *lastSpaceView = v0;
    
    for (NSInteger i = 0; i < views.count; i ++) {
        UIView *objV = views[i];
        UIView *spaceV = spaceViews[i + 1];
        
        [objV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastSpaceView.mas_bottom);
        }];
        
        [spaceV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(objV.mas_bottom);
            make.centerX.equalTo(objV.mas_centerX);
            make.height.equalTo(v0);
        }];
        
        lastSpaceView = spaceV;
    }
    
    [lastSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
}

/**
 用Masonry布局九宫格
 
 @param cellWidth 格子宽度
 @param cellHeight 格子高度
 @param numPerRow 每行格子的数目
 @param totalNum 格子的总数
 @param viewPadding 格子距父视图的边距
 @param viewPaddingCell 格子间的距离
 @param superView 父视图
 */
- (void)layoutGridWithCellWidth:(CGFloat)cellWidth
                     cellHeight:(CGFloat)cellHeight
                      numPerRow:(NSInteger)numPerRow
                       totalNum:(NSInteger)totalNum
                    viewPadding:(CGFloat)viewPadding
                viewPaddingCell:(CGFloat)viewPaddingCell
                      superView:(UIView *)superView
{
    __block UILabel *lastView = nil; //记录上一个view
    __block UILabel *lastRowView = nil; //记录上一行view
    __block NSInteger lastRowNo = 0; //记录上一行号
    
    NSMutableArray *cells = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalNum; i ++) {
        UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1.0];
        [superView addSubview:lab];
        [cells addObject:lab];
    }
    
    //循环布局cells
    for (NSInteger i = 0; i < cells.count; i ++) {
        UILabel *lb = cells[i];
        
        BOOL isFirstRow = [self isFirstRowWithIndex:i numOfRow:numPerRow];
        BOOL isFirstCol = [self isFirstColWithIndex:i numOfRow:numPerRow];
        BOOL isLastRow = [self isLastRowWithIndex:i numOfRow:numPerRow totalNum:totalNum];
        BOOL isLastCol = [self isLastColWithIndex:i numOfRow:numPerRow totalNum:totalNum];
        
        NSInteger currentRow = i/numPerRow;
        
        if (currentRow != lastRowNo) {
            lastRowView = lastView;
            lastRowNo = currentRow;
        }
        
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            if (cellWidth > 0 && cellHeight > 0) {
                make.width.mas_equalTo(cellWidth);
                make.height.mas_equalTo(cellHeight);
            } else {
                if (cellWidth == 0 && cellHeight == 0) {
                    CGFloat itemW = (MasonryScreenW - (numPerRow-1)*viewPaddingCell - viewPadding*2)/numPerRow;
                    make.width.mas_equalTo(itemW);
                    make.height.equalTo(lb.mas_width);
                } else {
                    CGFloat itemW = 0;
                    CGFloat itemH = 0;
                    if (cellWidth == 0) {
                        itemW = 30;
                        itemH = cellHeight;
                    } else {
                        itemW = cellWidth;
                        itemH = 30;
                    }
                    
                    make.width.mas_equalTo(itemW);
                    make.height.mas_equalTo(itemH);
                }
            }
            
            //layout top
            if (isFirstRow) {
                make.top.equalTo(superView.mas_top).offset(viewPadding);
            } else {
                if (lastRowView) {
                    make.top.equalTo(lastRowView.mas_bottom).offset(viewPaddingCell);
                }
            }
            
            //layout left
            if (isFirstCol) {
                make.left.equalTo(superView.mas_left).offset(viewPadding);
            } else {
                if (lastView) {
                    make.left.equalTo(lastView.mas_right).offset(viewPaddingCell);
                }
            }
            
            //layout firstRow & lastCol
            if (isFirstRow && isLastCol) {
                make.right.equalTo(superView.mas_right).offset(-viewPadding);
            }
            
            //layout lastRow & firstCol
            if (isLastRow && isFirstCol) {
                make.bottom.equalTo(superView.mas_bottom).offset(-viewPadding);
            }
        }];
        
        lastView = lb;
    }
}

/**
 是否是第一行
 
 @param index 当前下标
 @param numPerRow 每行格子个数
 @return 判断结果
 */
- (BOOL)isFirstRowWithIndex:(NSInteger)index numOfRow:(NSInteger)numPerRow
{
    if (numPerRow != 0) {
        return index/numPerRow == 0; //除：求行号
    }
    return NO;
}

/**
 是否是第一列
 
 @param index 当前下标
 @param numPerRow 每行格子个数
 @return 判断结果
 */
- (BOOL)isFirstColWithIndex:(NSInteger)index numOfRow:(NSInteger)numPerRow
{
    if (numPerRow != 0) {
        return index%numPerRow == 0; //取模：求列号
    }
    return NO;
}

/**
 是否是最后一行
 
 @param index 当前下标
 @param numPerRow 每行格子个数
 @param totalNum 格子的总个数
 @return 判断结果
 */
- (BOOL)isLastRowWithIndex:(NSInteger)index numOfRow:(NSInteger)numPerRow totalNum:(NSInteger)totalNum
{
    NSInteger totalRow = ceil(totalNum/(CGFloat)numPerRow); //ceil：返回大于或者等于指定表达式的最小整数
    
    if (numPerRow != 0) {
        return index/numPerRow == totalRow - 1;
    }
    return NO;
}

/**
 是否是最后一列
 
 @param index 当前下标
 @param numPerRow 每行格子个数
 @param totalNum 格子的总个数
 @return 判断结果
 */
- (BOOL)isLastColWithIndex:(NSInteger)index numOfRow:(NSInteger)numPerRow totalNum:(NSInteger)totalNum
{
    if (numPerRow != 0) {
        if (totalNum < numPerRow) {
            return index == numPerRow - 1;
        }
        return index%numPerRow == numPerRow - 1;
    }
    return NO;
}

#pragma mark- Setter and getter

@end
