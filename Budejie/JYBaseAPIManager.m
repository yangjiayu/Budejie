//
//  JYBaseAPIManager.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYBaseAPIManager.h"
#import <AFNetworking/UIKit+AFNetworking.h>
#import <Mantle/Mantle.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const JYInternalNetworkingErrorDomain   = @"JYInternalNetworkingErrorDomain";

@interface AFHTTPSessionManager (RASSupport_Internal)

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(id)parameters method:(NSString *)method;
- (RACSignal *)rac_POST:(NSString *)path parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block;

@end

@implementation JYBaseAPIManager

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if(self) {
        AFJSONResponseSerializer *responseSerializer = [[AFJSONResponseSerializer alloc] init];
        responseSerializer.acceptableContentTypes = [responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"text/html"]];
        self.responseSerializer = responseSerializer;
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

- (RACSignal *)rac_requestPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method
{

    return [[[super rac_requestPath:path parameters:parameters method:method] flattenMap:^RACStream *(RACTuple *value) {
        
        id responseObject = value.first;
        NSHTTPURLResponse *response = value.second;
#if DEBUG
        NSLog(@"[INFO] Received response (%@). status code: %@", response.URL, @(response.statusCode));
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"[VERBOSE] %@", [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
        }
#endif
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if([responseObject isKindOfClass:[NSDictionary class]]){
                NSError *error = nil; // TODO:
                if(error) {
                    [subscriber sendError:error];
                } else if(responseObject) {
                    [subscriber sendNext:responseObject];
                    [subscriber sendCompleted];
                } else {
                    [subscriber sendCompleted];
                }
            }else if([responseObject isKindOfClass:[NSArray class]]){
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
                
            }else{
                NSError *error = [[NSError alloc] initWithDomain:JYInternalNetworkingErrorDomain
                                                            code:SLInternalNetworkingErrorCodeNoDataReceived
                                                        userInfo:@{ NSLocalizedDescriptionKey : NSLocalizedString(@"Server Error", @"") }];
                [subscriber sendError:error];
            }
            return nil;
        }];
    }] doError:^(NSError *error) {
        NSLog(@"====================");
    }];
}

- (RACScheduler *)serializingScheduler
{
    if (!_serializingScheduler) {
        _serializingScheduler = [RACScheduler schedulerWithPriority:RACSchedulerPriorityDefault name:@"com.SerializingScheduler"];
    }
    return _serializingScheduler;
}

@end
