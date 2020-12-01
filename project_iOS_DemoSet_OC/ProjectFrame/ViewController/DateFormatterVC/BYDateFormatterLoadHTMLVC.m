//
//  BYDateFormatterLoadHTMLVC.m
//  project_iOS_DemoSet_OC
//
//  Created by 卞雍 on 2020/12/1.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYDateFormatterLoadHTMLVC.h"
#import "Masonry.h"
#import <WebKit/WebKit.h>

@interface BYDateFormatterLoadHTMLVC ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation BYDateFormatterLoadHTMLVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    [self loadHTML];
}

- (void)layoutUI {
    self.navigationController.title = @"dateformatter_HTML";
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)loadHTML {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"dateformatter" ofType:@"html"];
    NSURL *pathURL = [NSURL fileURLWithPath:filePath];
    [self.webView loadRequest:[NSURLRequest requestWithURL:pathURL]];
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
    }
    return _webView;
}

@end
