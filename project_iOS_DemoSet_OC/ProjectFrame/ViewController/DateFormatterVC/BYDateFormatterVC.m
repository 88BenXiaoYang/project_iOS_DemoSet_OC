//
//  BYDateFormatterVC.m
//  project_iOS_DemoSet_OC
//
//  Created by 卞雍 on 2020/11/30.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYDateFormatterVC.h"
#import "Masonry.h"
#import "CommonDefine.h"
#import "BYDateFormatterLoadHTMLVC.h"

typedef NS_ENUM(NSUInteger, BYTimeStyleType) {
    BYTimeStyleType_M_d_yy = 1000,
    BYTimeStyleType_d_MMM,
    BYTimeStyleType_d_MMMM_yy,
    BYTimeStyleType_d_MMMM,
    BYTimeStyleType_MMMM_yy,
    BYTimeStyleType_hh_mm_tt,
    BYTimeStyleType_h_mm_ss_t,
    BYTimeStyleType_H_mm_ss,
    BYTimeStyleType_M_d_yyyy_H_mm,
    BYTimeStyleTypeHTML
};

@interface BYDateFormatterVC ()

@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) NSArray *styleArray;
@property (nonatomic, strong) NSArray *ruleArray;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIScrollView *ruleScro;

@end

@implementation BYDateFormatterVC
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
- (void)showTime:(UIButton *)sender {
    switch (sender.tag) {
        case BYTimeStyleType_M_d_yy:
        {
            [self.dateFormatter setDateFormat:@"M/d/yy"];
        }
            break;
        case BYTimeStyleType_d_MMM:
        {
            [self.dateFormatter setDateFormat:@"d-MMM"];
        }
            break;
        case BYTimeStyleType_d_MMMM_yy:
        {
            [self.dateFormatter setDateFormat:@"d-MMMM-yy"];
        }
            break;
        case BYTimeStyleType_d_MMMM:
        {
            [self.dateFormatter setDateFormat:@"d MMMM"];
        }
            break;
        case BYTimeStyleType_MMMM_yy:
        {
            [self.dateFormatter setDateFormat:@"MMMM yy"];
        }
            break;
        case BYTimeStyleType_hh_mm_tt:
        {
            [self.dateFormatter setDateFormat:@"hh:mm aa"];
        }
            break;
        case BYTimeStyleType_h_mm_ss_t:
        {
            [self.dateFormatter setDateFormat:@"h:mm:ss a"];
        }
            break;
        case BYTimeStyleType_H_mm_ss:
        {
            [self.dateFormatter setDateFormat:@"H:mm:ss"];
        }
            break;
        case BYTimeStyleType_M_d_yyyy_H_mm:
        {
            [self.dateFormatter setDateFormat:@"M/d/yyyy H:mm"];
        }
            break;
        case BYTimeStyleTypeHTML:
        {
            BYDateFormatterLoadHTMLVC *vc = [[BYDateFormatterLoadHTMLVC alloc] init];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
            break;
    }
    self.timeLab.text = [self.dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)layoutUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.timeLab];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self layoutGrid];
}

- (void)layoutGrid
{
    //由子视图决定父视图大小
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset(20);
        make.left.equalTo(self.view);
    }];
    
    CGFloat numPerRow = 3;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - 10*(numPerRow+1))/numPerRow;
    
    [self layoutGridWithCellWidth:itemWidth cellHeight:40 numPerRow:numPerRow totalNum:self.styleArray viewPadding:10 viewPaddingCell:10 superView:containerView];
    
    [self.view addSubview:self.ruleScro];
    
    [self.ruleScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView.mas_bottom).offset(20);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self layoutGridWithCellWidth:[UIScreen mainScreen].bounds.size.width-20 cellHeight:24 numPerRow:1 totalNum:self.ruleArray viewPadding:10 viewPaddingCel:0 superView:self.ruleScro];
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
                       totalNum:(NSArray *)dataArray
                    viewPadding:(CGFloat)viewPadding
                viewPaddingCell:(CGFloat)viewPaddingCell
                      superView:(UIView *)superView
{
    NSInteger totalNum = dataArray.count;
    __block UIButton *lastView = nil; //记录上一个view
    __block UIButton *lastRowView = nil; //记录上一行view
    __block NSInteger lastRowNo = 0; //记录上一行号
    
    NSMutableArray *cells = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalNum; i ++) {
        NSString *titStr = self.styleArray[i][@"title"];
        NSInteger tag = [self.styleArray[i][@"tag"] integerValue];
        UIButton *lab = [self createBtnWithTitle:titStr];
        lab.tag = tag;
        lab.backgroundColor = [UIColor orangeColor];
        [superView addSubview:lab];
        [cells addObject:lab];
    }
    
    //循环布局cells
    for (NSInteger i = 0; i < cells.count; i ++) {
        UIButton *lb = cells[i];
        
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
                    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (numPerRow-1)*viewPaddingCell - viewPadding*2)/numPerRow;
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

- (void)layoutGridWithCellWidth:(CGFloat)cellWidth
                     cellHeight:(CGFloat)cellHeight
                      numPerRow:(NSInteger)numPerRow
                       totalNum:(NSArray *)dataArray
                    viewPadding:(CGFloat)viewPadding
                 viewPaddingCel:(CGFloat)viewPaddingCell
                      superView:(UIView *)superView
{
    NSInteger totalNum = dataArray.count;
    __block UILabel *lastView = nil; //记录上一个view
    __block UILabel *lastRowView = nil; //记录上一行view
    __block NSInteger lastRowNo = 0; //记录上一行号
    
    NSMutableArray *cells = [NSMutableArray array];
    
    for (NSInteger i = 0; i < totalNum; i ++) {
        NSString *titStr = self.ruleArray[i];
        UILabel *lab = [self createLabWithTitle:titStr];
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
                    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - (numPerRow-1)*viewPaddingCell - viewPadding*2)/numPerRow;
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
            return index == totalNum - 1;
        }
        return index%numPerRow == numPerRow - 1;
    }
    return NO;
}

#pragma mark- Setter and getter
- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = [[UILabel alloc] init];
        _timeLab.backgroundColor = [UIColor whiteColor];
        _timeLab.font = [UIFont systemFontOfSize:14];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.textColor = [UIColor blackColor];
        _timeLab.text = [self.dateFormatter stringFromDate:[NSDate date]];
    }
    return _timeLab;
}

- (UIScrollView *)ruleScro {
    if (!_ruleScro) {
        _ruleScro = [[UIScrollView alloc] init];
        _ruleScro.backgroundColor = [UIColor whiteColor];
    }
    return _ruleScro;
}

- (UIButton *)createBtnWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showTime:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UILabel *)createLabWithTitle:(NSString *)title {
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:12];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor blackColor];
    lab.text = title;
    return lab;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}

- (NSArray *)styleArray {
    if (!_styleArray) {
        _styleArray = @[@{@"title":@"M/d/yy",@"tag":@(BYTimeStyleType_M_d_yy)},
                        @{@"title":@"d-MMM",@"tag":@(BYTimeStyleType_d_MMM)},
                        @{@"title":@"d-MMMM-yy",@"tag":@(BYTimeStyleType_d_MMMM_yy)},
                        @{@"title":@"d MMMM",@"tag":@(BYTimeStyleType_d_MMMM)},
                        @{@"title":@"MMMM yy",@"tag":@(BYTimeStyleType_MMMM_yy)},
                        @{@"title":@"hh:mm tt",@"tag":@(BYTimeStyleType_hh_mm_tt)},
                        @{@"title":@"h:mm:ss t",@"tag":@(BYTimeStyleType_h_mm_ss_t)},
                        @{@"title":@"H:mm:ss",@"tag":@(BYTimeStyleType_H_mm_ss)},
                        @{@"title":@"M/d/yyyy H:mm",@"tag":@(BYTimeStyleType_M_d_yyyy_H_mm)},
                        @{@"title":@"Go_HTML",@"tag":@(BYTimeStyleTypeHTML)}];
    }
    return _styleArray;
}

- (NSArray *)ruleArray {
    if (!_ruleArray) {
        _ruleArray = @[@"格式化参数如下:",
                       @"G: 公元时代，例如AD公元",
                       @"yy: 年的后2位",
                       @"yyyy: 完整年",
                       @"MM: 月，显示为1-12",
                       @"MMM: 月，显示为英文月份简写,如 Jan",
                       @"MMMM: 月，显示为英文月份全称，如 Janualy",
                       @"dd: 日，2位数表示，如02",
                       @"d: 日，1-2位显示，如 2",
                       @"EEE: 简写星期几，如Sun",
                       @"EEEE: 全写星期几，如Sunday",
                       @"aa: 上下午，AM/PM",
                       @"H: 时，24小时制，0-23",
                       @"K：时，12小时制，0-11",
                       @"m: 分，1-2位",
                       @"mm: 分，2位",
                       @"s: 秒，1-2位",
                       @"ss: 秒，2位",
                       @"S: 毫秒",
                       @"",
                       @"常用日期结构:",
                       @"yyyy-MM-dd HH:mm:ss.SSS",
                       @"yyyy-MM-dd HH:mm:ss",
                       @"yyyy-MM-dd",
                       @"MM dd yyyy"];
    }
    return _ruleArray;
}

@end
