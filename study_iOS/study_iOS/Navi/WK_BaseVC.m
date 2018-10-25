//
//  WK_BaseVC.m
//  study_iOS
//
//  Created by wukeng on 2018/10/25.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "WK_BaseVC.h"

@interface WK_BaseVC ()

@end

@implementation WK_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    if (self.navigationController.viewControllers.count > 1) {
        [self setupLeftBarButton];
    }
}

- (void)setupUI{
    // 设置应用的背景色
    self.view.backgroundColor = [UIColor lightGrayColor];
    // 不允许 viewController 自动调整，我们自己布局；如果设置为YES，视图会自动下移 64 像素
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 自定义返回按钮
- (void)setupLeftBarButton {
    // 自定义 leftBarButtonItem ，UIImageRenderingModeAlwaysOriginal 防止图片被渲染
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(leftBarButtonClick)];
    // 防止返回手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - 返回按钮的点击事件
- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
