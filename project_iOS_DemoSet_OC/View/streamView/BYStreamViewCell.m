//
//  BYStreamViewCell.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2018/12/26.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYStreamViewCell.h"
#import "Masonry.h"
#import "BYTools.h"

@interface BYStreamViewCell ()

@property (nonatomic, strong) NSArray *itemsArray;
@property (nonatomic, assign) CGFloat screenWidth;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation BYStreamViewCell

#pragma mark- Live circle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    self.itemsArray = @[@"啊啊啊啊", @"不不不不不", @"吃吃吃吃吃吃", @"大的点点滴滴", @"呃呃呃呃", @"发反反复复", @"刚刚刚刚刚", @"哈哈哈哈", @"啦啦啦啦啦", @"就斤斤计较", @"快快快快快快快", @"啦啦啦啦啦啦啦", @"密密麻麻吗", @"袅袅娜娜", @"哦哦哦", @"胖胖胖", @"亲亲亲亲亲", @"人人人人人人"];
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)placeSubViews {
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"哈哈哈哈哈哈哈";
    [titleLab sizeToFit];
    [self.contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];
    UILabel *tmpLab = titleLab;
    if (self.itemsArray.count > 0) {
        CGFloat marginH = 8;
        CGFloat tmpW = marginH;
        NSString *itemContent = [self.itemsArray firstObject];
        CGSize titleSize = [itemContent sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:10]}];
        titleSize.width += 16;
        tmpW += titleSize.width;
        tmpW += marginH;
        CGFloat itemW = 0;
        if (tmpW >= self.screenWidth) {
            CGFloat dValue = tmpW - self.screenWidth;
            itemW = titleSize.width - dValue;
            tmpW = marginH;
        } else {
            itemW = titleSize.width;
        }
        UILabel *firstItemLab = [self createItemLab];
        firstItemLab.text = itemContent;
        [self.contentView addSubview:firstItemLab];
        [firstItemLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tmpLab.mas_bottom).offset(10);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(itemW, 15));
        }];
        tmpLab = firstItemLab;
        
        for (NSInteger i = 1; i < self.itemsArray.count; i ++) {
            itemContent = self.itemsArray[i];
            CGSize titleSize = [itemContent sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:10]}];
            titleSize.width += 16;
            CGFloat itemW = 0;
            
            if (tmpW == marginH) {
                tmpW += titleSize.width;
                tmpW += marginH;
                if (tmpW >= self.screenWidth) {
                    CGFloat dValue = tmpW - self.screenWidth;
                    itemW = titleSize.width - dValue;
                    tmpW = marginH;
                } else {
                    itemW = titleSize.width;
                }
                UILabel *itemLab = [self createItemLab];
                itemLab.text = itemContent;
                [self.contentView addSubview:itemLab];
                [itemLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(tmpLab.mas_bottom).offset(5);
                    make.left.mas_equalTo(marginH);
                    make.size.mas_equalTo(CGSizeMake(itemW, 15));
                }];
                tmpLab = itemLab;
            } else {
                tmpW += titleSize.width;
                tmpW += marginH;
                if (tmpW >= self.screenWidth) {
                    CGFloat tmpItemW = titleSize.width + 2 * marginH;
                    if (tmpItemW >= self.screenWidth) {
                        CGFloat dValue = tmpItemW - self.screenWidth;
                        itemW = titleSize.width - dValue;
                        tmpW = marginH;
                    } else {
                        itemW = titleSize.width;
                        tmpW = marginH;
                        tmpW += titleSize.width;
                        tmpW += marginH;
                    }
                    UILabel *itemLab = [self createItemLab];
                    itemLab.text = itemContent;
                    [self.contentView addSubview:itemLab];
                    [itemLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(tmpLab.mas_bottom).offset(5);
                        make.left.mas_equalTo(marginH);
                        make.size.mas_equalTo(CGSizeMake(itemW, 15));
                    }];
                    tmpLab = itemLab;
                } else {
                    itemW = titleSize.width;
                    UILabel *itemLab = [self createItemLab];
                    itemLab.text = itemContent;
                    [self.contentView addSubview:itemLab];
                    [itemLab mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(tmpLab.mas_right).offset(marginH);
                        make.centerY.equalTo(tmpLab);
                        make.size.mas_equalTo(CGSizeMake(itemW, 15));
                    }];
                    tmpLab = itemLab;
                }
            }
        }
    }
    
    [tmpLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
    }];
}

#pragma mark- Setter and getter
- (UILabel *)createItemLab {
    UILabel *itemLab = [[UILabel alloc] init];
    itemLab.layer.cornerRadius = 2;
    itemLab.layer.masksToBounds = YES;
    itemLab.textAlignment = NSTextAlignmentCenter;
    itemLab.textColor = [[BYTools shareTools] colorWithRGBHex:0x6C93F5];
    itemLab.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0xE5EEFF];
    itemLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
    return itemLab;
}

@end
