//
//  JYCommonAPIManager.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYCommonAPIManager.h"
#import <Mantle/Mantle.h>
#import "APIConst.h"

static inline RACSignal * JYParseJSONObjectsToModels(Class class, id object) {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSError *error = nil;
        id value;
        if ([object isKindOfClass:[NSArray class]]) {
            value = [MTLJSONAdapter modelsOfClass:class fromJSONArray:object error:&error];
        }else if ([object isKindOfClass:[NSDictionary class]]) {
            value = [MTLJSONAdapter modelOfClass:class fromJSONDictionary:object error:&error];
        }else {
            error = [NSError errorWithDomain:@"JYErrorDomain" code:SLInternalNetworkingErrorCodeUnkownJSONObjectType userInfo:@{NSLocalizedDescriptionKey: @"Unable to parse JSON object to models instance."}];
        }
        if(error) {
            [subscriber sendError:error];
        } else {
            [subscriber sendNext:value];
            [subscriber sendCompleted];
        }
        return nil;
    }];
}

static inline RACScheduler *MainScheduler() {
    return [RACScheduler mainThreadScheduler];
}

@implementation JYCommonAPIManager

+ (instancetype)defaultManager {
    static JYCommonAPIManager *commonManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonManager = [[JYCommonAPIManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return commonManager;
}

- (RACSignal *)requestAds {
    return [[[[self rac_GET:ADURL parameters:nil] deliverOn:self.serializingScheduler] flattenMap:^RACStream *(id value) {
        return JYParseJSONObjectsToModels(nil, value);
    }] deliverOn:MainScheduler()];
}
@end
