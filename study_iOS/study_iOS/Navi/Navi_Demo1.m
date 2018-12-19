//
//  Navi_Demo1.m
//  study_iOS
//
//  Created by wukeng on 2018/11/25.
//  Copyright © 2018 吴铿. All rights reserved.
//

#import "Navi_Demo1.h"

@interface Navi_Demo1 ()

@end

@implementation Navi_Demo1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"navigation基础";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}

- (void)setupUI{
   UIButton *changeColorBtn = [self createBtnTitle:@"改变导航栏背景色"];
    [self.view addSubview:changeColorBtn];
}


- (UIButton *)createBtnTitle:(NSString *)title{
    UIButton *btn = [[UIButton alloc] init];
    [btn setFrame:CGRectMake(100, 200, 200, 50)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return btn;
    

}

- (void)changeNaviBarBackgroundColor{
    
}
@end
