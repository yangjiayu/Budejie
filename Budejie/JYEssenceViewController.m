//
//  JYEssenceViewController.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/20.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYEssenceViewController.h"
#import "JYAllViewController.h"
#import "JYPictureViewController.h"
#import "JYVideoViewController.h"
#import "JYTextViewController.h"
#import "JYVoiceViewController.h"
#import "JYTitleButton.h"

@interface JYEssenceViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) JYTitleButton *selectedButton;

@end

static inline NSArray *JYEssences() {
    return @[@"推荐", @"视频", @"文字", @"图片", @"声音"];
}

@implementation JYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self setTitleView];
}

- (void)setTitleView {
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    self.titleView.frame = CGRectMake(0, 64, self.view.jy_width, 35);
    [self.view addSubview:self.titleView];
    CGFloat titleButtonWidth = self.titleView.jy_width / JYEssences().count;
    CGFloat titleButtonHeight = self.titleView.jy_height;
    [JYEssences() enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [JYTitleButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(titleButtonWidth*idx, 0, titleButtonWidth, titleButtonHeight);
        [self.titleView addSubview:button];
        [button setTitle:obj forState:UIControlStateNormal];
        button.tag = idx;
        [button addTarget:self action:@selector(titelClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    JYTitleButton *firstSelectButton = self.titleView.subviews.firstObject;
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [firstSelectButton titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:self.lineView];
    [firstSelectButton.titleLabel sizeToFit];
    self.lineView.frame = CGRectMake(firstSelectButton.titleLabel.jy_origin_x, self.titleView.jy_height, firstSelectButton.titleLabel.jy_width, 2);
    self.lineView.jy_center_x = firstSelectButton.jy_center_x;
    [self titelClick:firstSelectButton];
    
}
-(void)titelClick:(JYTitleButton *)titleButton
{
    self.selectedButton.selected = NO;
    titleButton.selected = YES;
    self.selectedButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.jy_center_x = titleButton.jy_center_x;
    }];
}

- (void)setChildrenViewController {
    JYAllViewController *all = [[JYAllViewController alloc] init];
    JYTextViewController *textVC = [[JYTextViewController alloc] init];
    JYPictureViewController *pictureVC = [[JYPictureViewController alloc] init];
    JYVideoViewController *videoVC = [[JYVideoViewController alloc] init];
    JYVoiceViewController *voiceVC = [[JYVoiceViewController alloc] init];
    @weakify(self);
    [@[all, textVC, pictureVC, videoVC, voiceVC] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        [self addChildViewController:obj];
    }];
}

@end
