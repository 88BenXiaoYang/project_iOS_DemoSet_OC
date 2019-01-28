//
//  BYContentInputViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/24.
//  Copyright © 2019 by. All rights reserved.
//

#import "BYContentInputViewController.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "BYContentInputView.h"
#import "BYInputVCCell.h"
#import "BYInputModel.h"

@interface BYContentInputViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *edittingBgView;
@property (nonatomic, strong) BYContentInputView *contentInputView;
@property (nonatomic, strong) NSMutableArray *inputList;

@end

@implementation BYContentInputViewController

#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self placeSubViews];
}

#pragma mark- Overwrite
#pragma mark- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inputList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BYInputVCCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BYInputVCCell class])];
    BYInputModel *model = self.inputList[indexPath.row];
    cell.inputModel = model;
    return cell;
}

#pragma mark- Notification methods
- (void)setupObserver {
    Ref_WeakSelf(self)
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *dic = note.userInfo;
        NSValue *keyboardFrameValue = [dic valueForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardFrame = keyboardFrameValue.CGRectValue;
        NSNumber *duration = [dic valueForKey:UIKeyboardAnimationDurationUserInfoKey];
        [UIView animateWithDuration:duration.floatValue animations:^{
            [weakself.contentInputView mas_updateConstraints:^(MASConstraintMaker *make) {
                if (@available(iOS 11.0, *)) {
                    make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-([UIScreen mainScreen].bounds.size.height-keyboardFrame.origin.y));
                } else {
                    make.bottom.mas_equalTo(-([UIScreen mainScreen].bounds.size.height-keyboardFrame.origin.y));
                }
            }];
            [self.view layoutIfNeeded];
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakself.contentInputView inputViewBecomeFirstResponder];
        [weakself showEdittingBgView];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [weakself.contentInputView inputViewResignFirstResponder];
        [self hiddenEdittingBgView];
        weakself.contentInputView.textString = @"";
        weakself.contentInputView.textView.placeholder = @"评论点什么~";
    }];
}

#pragma mark- Interface methods
#pragma mark- Event Response methods
- (void)giveupEdit {
    [self.view endEditing:YES];
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)prepare {
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupObserver];
}

- (void)placeSubViews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.contentInputView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.mas_equalTo(0);
        }
        make.bottom.equalTo(self.contentInputView.mas_top);
    }];
    
    [self.contentInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(54);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.mas_equalTo(0);
        }
    }];
}

- (void)showEdittingBgView {
    [self.view addSubview:self.edittingBgView];
    [self.view bringSubviewToFront:self.contentInputView];
    [UIView animateWithDuration:0.35 animations:^{
        [self.edittingBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }];
    
    UIView *subBgView = [[UIView alloc] init];
    subBgView.backgroundColor = [UIColor whiteColor];
    [self.edittingBgView addSubview:subBgView];
    [subBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.equalTo(self.contentInputView.mas_bottom);
    }];
}

- (void)hiddenEdittingBgView {
    [self.edittingBgView removeFromSuperview];
}

- (void)buildInputListDataByContent:(BYInputModel *)model {
    [self.inputList addObject:model];
    [self.tableView reloadData];
}

#pragma mark- Setter and getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 40;
        [_tableView registerClass:[BYInputVCCell class] forCellReuseIdentifier:NSStringFromClass([BYInputVCCell class])];
    }
    return _tableView;
}

- (UIView *)edittingBgView {
    if (!_edittingBgView) {
        _edittingBgView = [[UIView alloc] init];
        _edittingBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(giveupEdit)];
        tapGesture.numberOfTapsRequired = 1;
        [_edittingBgView addGestureRecognizer:tapGesture];
    }
    return _edittingBgView;
}

- (BYContentInputView *)contentInputView {
    if (!_contentInputView) {
        _contentInputView = [[BYContentInputView alloc] init];
        _contentInputView.backgroundColor = [UIColor whiteColor];
        _contentInputView.textView.placeholder = @"评论点什么~";
        _contentInputView.isChangeBool = YES;
        _contentInputView.textView.returnKeyType = UIReturnKeySend;
        Ref_WeakSelf(self)
        [_contentInputView setTextHeightChangeBlock:^(CGFloat textHeight) {
            [weakself.contentInputView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(textHeight + 17.0f);
            }];
        }];
        
        [_contentInputView setCompleteBlock:^(NSString *text){
            if (weakself.contentInputView.frame.size.height > 54) {
                [UIView animateWithDuration:.3f animations:^{
                    [weakself.contentInputView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(54.f);
                    }];
                    [weakself.view layoutIfNeeded];
                }];
            }
            
            BYInputModel *model = [[BYInputModel alloc] init];
            model.contentStr = text;
            [weakself buildInputListDataByContent:model];
            
            [weakself.view endEditing:YES];
            weakself.contentInputView.textString = @"";
            [weakself.contentInputView inputViewResignFirstResponder];
        }];
    }
    return _contentInputView;
}

- (NSMutableArray *)inputList {
    if (!_inputList) {
        _inputList = [NSMutableArray array];
    }
    return _inputList;
}

@end
