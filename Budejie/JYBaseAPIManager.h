//
//  JYBaseAPIManager.h
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPSessionManager+RACSupport.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SLInternalNetworkingErrorCode) {
    SLInternalNetworkingErrorCodeNoDataReceived = 40001,
    SLInternalNetworkingErrorCodeUnkownJSONObjectType = 40002
};

@interface JYBaseAPIManager : AFHTTPSessionManager

@property (nonatomic, strong) RACScheduler *serializingScheduler;

@end
