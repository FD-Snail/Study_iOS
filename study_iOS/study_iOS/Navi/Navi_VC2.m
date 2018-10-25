//
//  Navi_VC2.m
//  study_iOS
//
//  Created by wukeng on 2018/10/25.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "Navi_VC2.h"


@interface Navi_VC2 (){
    UITextField *searchBar;
}

@end

@implementation Navi_VC2

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addsearchBar];
    
    /** 自定义navigationBar高度 */
//    [self.navigationController setValue:[[WK_CustomBar alloc]init] forKeyPath:@"navigationBar"];

    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"修改前");
    [self printViewHierarchy:self.navigationController.navigationBar];
    
    //修改NavigaionBar的高度
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 100);
    
    NSLog(@"\n修改后");
    [self printViewHierarchy:self.navigationController.navigationBar];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    CGRect rect = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,44);
}

- (void)printViewHierarchy:(UIView *)superView
{
    static uint level = 0;
    for(uint i = 0; i < level; i++){
        printf("\t");
    }
    
    const char *className = NSStringFromClass([superView class]).UTF8String;
    const char *frame = NSStringFromCGRect(superView.frame).UTF8String;
    printf("%s:%s\n", className, frame);
    
    ++level;
    for(UIView *view in superView.subviews){
        [self printViewHierarchy:view];
    }
    --level;
}

- (void)addsearchBar{
    /** 添加搜索框 */
    UIView *View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    //    UIColor *color =  self.navigationController.navigationBar.barTintColor;
    [View setBackgroundColor:[UIColor redColor]];
    searchBar = [[UITextField alloc] init];
    searchBar.frame = CGRectMake(0, 0, 200, 35);
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.layer.cornerRadius = 18;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:1];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    searchBar.placeholder = @"  搜索内容";
    [View addSubview:searchBar];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = View;
}

@end




