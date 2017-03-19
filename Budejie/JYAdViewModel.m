//
//  JYAdViewModel.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYAdViewModel.h"
#import "JYCommonAPIManager.h"

static NSInteger JYADSDefaultTimerSeconds = 3;

@interface JYAdViewModel()
@property (nonatomic, strong) RACCommand *requestAdsCommand;

@end

@implementation JYAdViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (RACCommand *)requestAds {
    if (_requestAdsCommand) {
        return _requestAdsCommand;
    }
    _requestAdsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [[[[JYCommonAPIManager defaultManager] requestAds] doNext:^(id x) {
            NSLog(@"x--%@", x);
        }] materialize];
    }];
    return _requestAdsCommand;
}

@end
