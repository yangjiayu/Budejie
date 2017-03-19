//
//  JYAdViewModel.h
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/19.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYAdViewModel : NSObject

@property (nonatomic, copy) NSString *adsButtonTitle;

- (RACCommand *)requestAds;

@end
