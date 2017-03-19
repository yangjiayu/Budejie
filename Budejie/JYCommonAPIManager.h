//
//  JYCommonAPIManager.h
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYBaseAPIManager.h"
#import <AFNetworking-RACExtensions/AFHTTPSessionManager+RACSupport.h>

@interface JYCommonAPIManager : JYBaseAPIManager

+ (instancetype)defaultManager;

- (RACSignal *)requestAds;

@end
