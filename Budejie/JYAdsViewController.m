//
//  JYAdsViewController.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYAdsViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JYAdViewModel.h"
#import "JYTabViewController.h"

static NSInteger JYADSDefaultTimerSeconds = 3;

@interface JYAdsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) JYAdViewModel *viewModel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation JYAdsViewController

- (JYAdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JYAdViewModel alloc] init];
    }
    return _viewModel;
}
/*
 - (RACCommand *)timeCountingCommand {
 return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *number) {
 __block NSInteger seconds = [number integerValue];
 return [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
 seconds--;
 [subscriber sendNext:@(seconds)];
 [subscriber sendCompleted];
 return nil;
 }] delay:1.0] repeat] takeUntilBlock:^BOOL(id x) {
 return seconds < 0;
 }];
 }];
 }
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.viewModel.requestAds execute:nil];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCounting:) userInfo:nil repeats:YES];
    @weakify(self);
    self.button.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        JYTabViewController *tab = [[JYTabViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        [self.timer invalidate];
        return [RACSignal empty];
    }];
}

- (void)timerCounting: (NSTimer *)timer {
    if (JYADSDefaultTimerSeconds == 0) {
        JYTabViewController *tab = [[JYTabViewController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        [self.timer invalidate];
    }
    JYADSDefaultTimerSeconds--;
    [self.button setTitle:[NSString stringWithFormat:@"跳过(%zd)", JYADSDefaultTimerSeconds] forState:UIControlStateNormal];
}

@end
