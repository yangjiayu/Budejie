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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchImage" ofType:@"png"]];
    [self.viewModel.requestAds execute:nil];
}

@end
