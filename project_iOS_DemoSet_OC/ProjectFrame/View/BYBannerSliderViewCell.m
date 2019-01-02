//
//  BYBannerSliderViewCell.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2018/12/30.
//  Copyright © 2018 by. All rights reserved.
//

#import "BYBannerSliderViewCell.h"
#import "BYBannerSlideView.h"

@interface BYBannerSliderViewCell ()

@property (nonatomic, strong) BYBannerSlideView *bannerSlideView;

@end

@implementation BYBannerSliderViewCell

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
+ (CGFloat)heightOfCell
{
    return 196;
}

- (void)prepare
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)placeSubViews
{
    [self.contentView addSubview:self.bannerSlideView];
}

#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
#pragma mark- Setter and getter
//slide style
- (BYBannerSlideView *)bannerSlideView
{
    if (!_bannerSlideView) {
        _bannerSlideView = [[BYBannerSlideView alloc] initWithFrame:CGRectMake(0, 15, [UIScreen mainScreen].bounds.size.width, 166)];
    }
    return _bannerSlideView;
}

@end
