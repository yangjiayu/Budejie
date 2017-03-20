//
//  UIView+JYFrame.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/20.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "UIView+JYFrame.h"

@implementation UIView (JYFrame)

- (CGFloat)jy_width {
    return self.frame.size.width;
}

- (CGFloat)jy_height {
    return self.frame.size.height;
}

- (CGFloat)jy_origin_x {
    return self.frame.origin.x;
}

- (CGFloat)jy_origin_y {
    return self.frame.origin.y;
}

- (void)setJy_width:(CGFloat)jy_width {
    CGRect rect = self.frame;
    rect.size.width = jy_width;
    self.frame = rect;
}

- (void)setJy_height:(CGFloat)jy_height {
    CGRect rect = self.frame;
    rect.size.height = jy_height;
    self.frame = rect;
}

- (void)setJy_origin_x:(CGFloat)jy_origin_x {
    CGRect rect = self.frame;
    rect.origin.x = jy_origin_x;
    self.frame = rect;
}

- (void)setJy_origin_y:(CGFloat)jy_origin_y {
    CGRect rect = self.frame;
    rect.origin.y = jy_origin_y;
    self.frame = rect;
}

- (CGFloat)jy_center_x {
    return self.center.x;
}

- (CGFloat)jy_center_y {
    return self.center.y;
}

- (void)setJy_center_x:(CGFloat)jy_center_x {
    CGPoint point = self.center;
    point.x = jy_center_x;
    self.center = point;
}

- (void)setJy_center_y:(CGFloat)jy_center_y {
    CGPoint point = self.center;
    point.y = jy_center_y;
    self.center = point;
}

@end
