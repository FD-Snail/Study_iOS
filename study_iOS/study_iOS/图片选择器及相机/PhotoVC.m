//
//  PhotoVC.m
//  study_iOS
//
//  Created by wukeng on 2019/2/11.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "PhotoVC.h"
#import "UIView+blackBackView.h"

@interface PhotoVC()



@end

@implementation PhotoVC

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *gifBtn = [[UIButton alloc] init];
    [gifBtn setTitle:@"加载gif" forState:UIControlStateNormal];
    [gifBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    gifBtn.frame = CGRectMake(80,150,100,30);
    gifBtn.backgroundColor = [UIColor whiteColor];
    [gifBtn addTarget:self action:@selector(gifBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gifBtn];
}
- (void)gifBtnClick{
    
}

@end
