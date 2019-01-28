//
//  BYContentInputView.m
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/24.
//  Copyright © 2019 by. All rights reserved.
//

#import "BYContentInputView.h"
#import "NSString+Tools.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "BYTools.h"

static const NSInteger kMaxTextLength = 2000;

@interface BYContentInputView () <UITextViewDelegate>

@property (nonatomic, assign) CGFloat textMaxHeight;
@property (nonatomic, assign) CGFloat textHeight;

@end

@implementation BYContentInputView

#pragma mark- Live circle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textMaxHeight = 90.0f;
        [self setupUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- Overwrite
- (void)inputViewBecomeFirstResponder {
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-7);
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-9);
    }];
}

- (void)inputViewResignFirstResponder {
    self.textView.textColor = [[BYTools shareTools] colorWithRGBHex:0xA9ABAB];
    
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-7);
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-9);
    }];
}

#pragma mark- Delegate
- (void)textViewDidChange:(UITextView *)textView {
    NSString *content = textView.text;
    if (content.length > kMaxTextLength) {
        textView.text =  [content substringToIndex:kMaxTextLength];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.textView.textColor = [[BYTools shareTools] colorWithRGBHex:0x333333];
    if ([text isEqualToString:@"\n"]) {
        if ([[self.textView.text tool_stringByTrimmingCharacters] length]!=0) {
            BLOCK_EXEC(self.completeBlock,textView.text);
        }
        return NO;
    }
    //    if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] || ![[textView textInputMode] primaryLanguage] || [self stringContainsEmoji:text]) {
    //        return NO;
    //    }
    return YES;
}

#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
#pragma mark- Net request
#pragma mark- Private methods
- (void)setupUI {
    self.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0xfafafa];
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0xc9cacb];
    [self addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_ONE_PX);
    }];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0xc9cacb];
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_ONE_PX);
    }];
    
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(7);
        make.bottom.mas_equalTo(-7);
        make.left.mas_equalTo(9);
        make.right.mas_equalTo(-9);
    }];
}

- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    
                                    //                                    if (0x2100 <= high && high <= 0x27BF){
                                    //                                        returnValue = YES;
                                    //                                    }
                                }
                            }];
    
    return returnValue;
}

- (void)setTextString:(NSString *)textString {
    _textString = textString;
    self.textView.text = _textString;
    [self textDidChange];
}

- (void)textDidChange {
    if (!self.isChangeBool) {
        return;
    }
    NSInteger height = ceilf([self.textView sizeThatFits:CGSizeMake(self.textView.bounds.size.width, MAXFLOAT)].height);
    if (self.textHeight != height) { // 高度不一样，就改变了高度
        // 最大高度，可以滚动
        self.textView.scrollEnabled = height > self.textMaxHeight && self.textMaxHeight > 0;
        self.textHeight = height;
        if (self.textView.scrollEnabled == NO) {
            BLOCK_EXEC(self.textHeightChangeBlock,height);
            [self.superview layoutIfNeeded];
        }
    }
}

#pragma mark- Setter and getter
- (SAMTextView *)textView {
    if (!_textView) {
        _textView = [[SAMTextView alloc] init];
        _textView.layer.cornerRadius = 3;
        _textView.layer.masksToBounds = YES;
        _textView.backgroundColor = [[BYTools shareTools] colorWithRGBHex:0xF3F4F6];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [[BYTools shareTools] colorWithRGBHex:0x333333];
        _textView.returnKeyType = UIReturnKeySend;
        _textView.textContainerInset = UIEdgeInsetsMake(12, 8, 8, 8);
        _textView.delegate = self;
    }
    return _textView;
}

@end
