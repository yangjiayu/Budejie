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

static NSInteger JYADSDefaultTimerSeconds = 3;

@interface JYAdsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) JYAdViewModel *viewModel;

@end

@implementation JYAdsViewController

- (JYAdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JYAdViewModel alloc] init];
    }
    return _viewModel;
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchImage" ofType:@"png"]];
    [self.viewModel.requestAds execute:nil];
    //RAC(self, button.titleLabel.text) = [[self timeCountingCommand] execute:@(JYADSDefaultTimerSeconds)];

}

@end
