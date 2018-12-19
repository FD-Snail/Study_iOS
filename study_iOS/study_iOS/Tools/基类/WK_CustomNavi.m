//
//  WK_CustomNavi.m
//  study_iOS
//
//  Created by wukeng on 2018/11/25.
//  Copyright © 2018 吴铿. All rights reserved.
//

#import "WK_CustomNavi.h"

@interface WK_CustomNavi ()

@end

@implementation WK_CustomNavi

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize{
    //appearance方法返回一个导航栏的外观对象
    //修改了这个外观对象，相当于修改了整个项目中的外观
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    //设置导航栏背景色
    [navigationBar setBarTintColor:UIColorRGBHex(123456)];
    //设置NavigationBarItem文字的颜色
    [navigationBar setTintColor:[UIColor whiteColor]];
    //设置标题栏颜色
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName : [UIFont systemFontOfSize:18]};
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //修改返回文字
    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //全部修改返回按钮,但是会失去右滑返回的手势
    if (viewController.navigationItem.leftBarButtonItem ==nil && self.viewControllers.count >=1) {
        
        viewController.navigationItem.leftBarButtonItem = [self creatBackButton];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(UIBarButtonItem *)creatBackButton
{
    return [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
}

-(void)popSelf
{
    [self popViewControllerAnimated:YES];
}

@end
