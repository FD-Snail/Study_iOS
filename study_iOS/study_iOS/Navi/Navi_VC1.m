//
//  Navi_VC1.m
//  study_iOS
//
//  Created by wukeng on 2018/10/25.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "Navi_VC1.h"
#import "Navi_VC2.h"

@interface Navi_VC1 ()

@end

@implementation Navi_VC1

- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置标题 */
    self.title = @"第一个push控制器";
    /** 设置导航栏颜色 */
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    
    /** 自定义返回键 */
    UIButton *popBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    [popBtn setTitle:@"自定义返回键" forState:UIControlStateNormal];
    [popBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [popBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popBtn];
    
    /** 自定义左侧按钮 */
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 sizeToFit];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitle:@"返回2" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn2Click) forControlEvents:UIControlEventTouchUpInside];
    [btn2 sizeToFit];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    /** item 添加到导航栏左边 */
    self.navigationItem.leftBarButtonItems = @[item1,item2];
    /** 添加右键 */
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:@"右键" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [btn3 sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn3];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    /** 跳转删除当前控制器 */
    UIButton *deleteSelf = [[UIButton alloc] initWithFrame:CGRectMake(50, 300, 300, 30)];
    [deleteSelf setTitle:@"点击进入下一个vc,当前vc会被销毁" forState:UIControlStateNormal];
    [deleteSelf setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [deleteSelf addTarget:self action:@selector(goNextWithDeleteSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteSelf];
    
}




- (void)goback{
    [self.navigationController popViewControllerAnimated:true];
}

- (void)btn2Click{
    [WK_Tools showToast:@"我点击了第二个item"];
}

- (void)rightBtnClicked{
    Navi_VC2 *vc = [[Navi_VC2 alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)goNextWithDeleteSelf{
    Navi_VC2 *vc = [[Navi_VC2 alloc] init];
    [self.rt_navigationController pushViewController:vc animated:vc complete:^(BOOL finished) {
        [self.rt_navigationController removeViewController:self];
    }];
}
@end
