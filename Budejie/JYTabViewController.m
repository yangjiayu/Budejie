//
//  JYTabViewController.m
//  Budejie
//
//  Created by 杨家瑜 on 2017/3/20.
//  Copyright © 2017年 杨家瑜. All rights reserved.
//

#import "JYTabViewController.h"
#import "JYEssenceViewController.h"
#import "JYNavigationViewController.h"
#import "JYNewViewController.h"
#import "JYSettingViewController.h"
#import "JYAttentionViewController.h"


@interface JYTabViewController ()

@end

@implementation JYTabViewController

+ (void)initialize {
    UITabBarItem *titleItem = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *normalDict = [NSMutableDictionary dictionary];
    normalDict[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [titleItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [titleItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setChildViewController];
    [self setTabbar];
}

- (void)setTabbar {
    JYNavigationViewController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精选";
    nav.tabBarItem.image = [[UIImage imageNamed:@"essence"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:@"essence_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    JYNavigationViewController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [[UIImage imageNamed:@"new"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem.selectedImage = [[UIImage imageNamed:@"new_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    JYNavigationViewController *nav2 = self.childViewControllers[2];
    nav2.tabBarItem.title = @"关注";
    nav2.tabBarItem.image = [[UIImage imageNamed:@"attention"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav2.tabBarItem.selectedImage = [[UIImage imageNamed:@"attention_select"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    JYNavigationViewController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"我";
    nav3.tabBarItem.image = [[UIImage imageNamed:@"setting"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav3.tabBarItem.selectedImage = [[UIImage imageNamed:@"setting_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)setChildViewController {
    JYEssenceViewController *essence = [[JYEssenceViewController alloc] init];
    JYNewViewController *new = [[JYNewViewController alloc] init];
    JYAttentionViewController *attention = [[JYAttentionViewController alloc] init];
    JYSettingViewController *setting = [[JYSettingViewController alloc] init];
    @weakify(self);
    [@[essence, new, attention, setting] enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        [self addChildViewController:[self addRootViewController:obj]];
    }];
}

- (UIViewController *)addRootViewController: (UIViewController *)viewController {
    return [[JYNavigationViewController alloc] initWithRootViewController:viewController];
}


@end
