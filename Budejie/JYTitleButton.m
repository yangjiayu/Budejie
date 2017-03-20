//
//  JYTitleButton.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/20.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYTitleButton.h"

@implementation JYTitleButton

-(void)setHighlighted:(BOOL)highlighted{}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor ] forState:UIControlStateSelected];
    }
    return self;
}
@end
