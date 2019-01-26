//
//  ViewController.m
//  study_iOS
//
//  Created by wukeng on 2018/10/24.
//  Copyright © 2018年 吴铿. All rights reserved.
//


#define cellID @"mainT_Cell"

#import "ViewController.h"
#import "mainTableView_Cell.h"
#import "Touch_MainVC.h"
#import "FMDBVC.h"
#import "NaviDemo.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    /** 设置navi */
    self.title = @"iOS经验总结";
    _dataSource = @[@"Navigation",@"图片选择器和相机",@"触摸事件",@"FMDB",@"转场动画"];
    _secondDataSource = @[@"1.系统的navi\n2.自定义navi，各种运用",
                          @"基于HXPhotoPicker框架的图片选择器。\n1.首先你要Plist里面允许相机及相册。\n2.查看/选择GIF图片，照片和视频同时多选。\n3.3DTouch预览照片。\n4长按拖动改变顺序。\n5.自定义相机拍照/录制视频。\n6.自定义转场动画、查看/选择LivePhoto iOS9.1以上才能用、支持浏览网络图片、支持自定义裁剪、支持传入本地图片、支持在线下载iCloud上的资源",
                          @"iOS系统将事件相应过程拆分成两部分：\n1.寻找响应链\n2.事件响应。先将事件通过某种规则来分发，找到处理事件的控件。其次是将事件传递分发,响应。",
                          @"FMDB简介:\nFMDB是iOS平台的SQLite数据库框架\nFMDB以OC的方式封装了SQLite的C语言API\n2.FMDB的优点\n使用起来更加面向对象，省去了很多麻烦、冗余的C语言代码\n对比苹果自带的Core Data框架，更加轻量级和灵活\n提供了多线程安全的数据库操作方法，有效地防止数据混乱",
                          @"各种转场动画"];
    [self.view addSubview:self.tableView];
    
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerNib:[UINib nibWithNibName:@"mainTableView_Cell" bundle:nil] forCellReuseIdentifier:cellID];
        _tableView.estimatedRowHeight = 100.0f;
        /** 设置自动行高。在xib里进行约束让secondLable的高度约束撑起整个cell */
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [[UIView alloc] init];
        /** 设置tableViewCell的分割线 */
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]){
            //top, left, bottom, right
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 30, 0, 30)];
        }
    }
    return _tableView;
}


#pragma mark - 表格代理-数据源
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    mainTableView_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[mainTableView_Cell alloc] init];
    }
    /** 设置cell的点击式样 */
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.mainLable setText:_dataSource[indexPath.row]];
    [cell.secondLable setText:_secondDataSource[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NaviDemo *demo = [[NaviDemo alloc] init];
        [self.navigationController pushViewController:demo animated:true];
    }
    else if(indexPath.row == 1){
//        Photo_MainVC *photo = [[Photo_MainVC alloc] init];
//        [self.rt_navigationController pushViewController:photo animated:true];
    }
    else if(indexPath.row == 2){
        Touch_MainVC *touch = [[Touch_MainVC alloc] init];
        [self.navigationController pushViewController:touch animated:true];
    }
}
//
//- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
//    <#code#>
//}
//
//- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
//    <#code#>
//}
//
//- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    <#code#>
//}
//
//- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
//    <#code#>
//}
//
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator { 
//    <#code#>
//}
//
//- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
//    <#code#>
//}
//
//- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
//    <#code#>
//}
//
//- (void)setNeedsFocusUpdate {
//    <#code#>
//}
//
//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//    <#code#>
//}
//
//- (void)updateFocusIfNeeded { 
//    <#code#>
//}



@end
