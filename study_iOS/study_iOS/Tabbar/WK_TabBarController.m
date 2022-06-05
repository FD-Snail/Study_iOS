//
//  WK_TabBarController.m
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import "WK_TabBarController.h"
#import "WK_Tabbal.h"
#import "WK_FirstVC.h"
#import "WK_SecondVC.h"
#import "WK_ThreeVC.h"
#import "WK_FourVC.h"
#import "WK_FiveVC.h"


@interface WK_TabBarController ()<WK_TabbarDelegate>

@property (nonatomic, strong) WK_Tabbal *wk_TabBar;

@property (nonatomic, strong) NSMutableArray *controllersArray;
@end

@implementation WK_TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.controllersArray = [NSMutableArray array];
    [self creatTabChildControllers];
}

/**
 *创建Tabbar 及对应的控制器
 */
- (void)creatTabChildControllers{
    
    NSArray *childVCArray = @[[WK_FiveVC new],[WK_SecondVC new],[WK_ThreeVC new],[WK_FourVC new],[WK_FiveVC new]];
    NSArray *titleArray = @[@"首页", @"发现", @"知识", @"商城", @"我的"];
    NSArray *imageArray = @[@"tabbar_home_normal", @"tabbar_find_normal", @"tabbar_knowledge_normal", @"tabbar_mall_normal", @"tabbar_mine_normal"];
    NSArray *selectedImageArray = @[@"tabbar_home_selectedBg", @"tabbar_find_selected", @"tabbar_knowledge_selected", @"tabbar_mall_selected", @"tabbar_mine_selected"];
    [self creatTabBarWithChildVCArray:childVCArray titleArray:titleArray imageArray:imageArray selectedImageArray:selectedImageArray];
}

//添加子模块
- (void)creatTabBarWithChildVCArray:(NSArray *)childVCArray
                         titleArray:(NSArray *)titleArray
                         imageArray:(NSArray *)imageArray
                 selectedImageArray:(NSArray *)selectedImageArray{
    for (UIViewController *vc in childVCArray) {
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.controllersArray addObject:navigationController];
    }
    
    self.wk_TabBar = [WK_Tabbal tabBarWithTitleArray:titleArray imageArray:imageArray selectedImageArray:selectedImageArray];
    [self setValue:self.wk_TabBar forKey:@"tabBar"];
    self.viewControllers = self.controllersArray;
}

// 重新tabbar的高度
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect frame = self.tabBar.frame;
    if (frame.size.height != 56) {
        frame.size.height = 56;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
}

#pragma mark - 代理
- (void)selectedWK_TabbarItemWithIndex:(NSInteger)index{
    self.selectedIndex = index;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
