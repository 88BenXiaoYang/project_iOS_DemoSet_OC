//
//  BYThreadHandleViewController.m
//  project_iOS_DemoSet_OC
//
//  Created by by on 2020/9/10.
//  Copyright © 2020 by. All rights reserved.
//

#import "BYThreadHandleViewController.h"

@interface BYThread : NSThread
@end

@implementation BYThread

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end

@interface BYThreadHandleViewController ()

@property (nonatomic, strong) BYThread *thread;
@property (nonatomic, assign, getter = isStopped) BOOL stopped;

@end

@implementation BYThreadHandleViewController

#pragma mark- Live circle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self startThread];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [self stop];
}

#pragma mark- Overwrite
#pragma mark- Delegate
#pragma mark- Notification methods
#pragma mark- Interface methods
#pragma mark- Event Response methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.thread) return;
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

#pragma mark- Net request
#pragma mark- Private methods
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bt = [[UIButton alloc] init];
    bt.frame = CGRectMake(50, 150, 60, 40);
    bt.layer.cornerRadius = 5;
    bt.layer.masksToBounds = YES;
    bt.layer.borderWidth = 1;
    bt.layer.borderColor = [UIColor orangeColor].CGColor;
    [bt setTitle:@"stop" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bt];
}

- (void)startThread {
    __weak typeof(self) weakSelf = self;
    self.stopped = NO;
    self.thread = [[BYThread alloc] initWithBlock:^{
        // 往RunLoop里面添加mode
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
        while (weakSelf && !weakSelf.isStopped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
    }];
    [self.thread start];
}

- (void)test {
    NSLog(@"%s", __func__);
}

- (void)stop {
    if (!self.thread) return;
    
    [self performSelector:@selector(stopThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

- (void)stopThread {
    self.stopped = YES;
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s %@", __func__, [NSThread currentThread]);
    self.thread = nil;
}

#pragma mark- Setter and getter

@end
