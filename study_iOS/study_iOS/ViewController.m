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



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>



@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[@"FMDB",@"转场动画"];
    _secondDataSource = @[@"FMDB简介:\nFMDB是iOS平台的SQLite数据库框架\nFMDB以OC的方式封装了SQLite的C语言API\n2.FMDB的优点\n使用起来更加面向对象，省去了很多麻烦、冗余的C语言代码\n对比苹果自带的Core Data框架，更加轻量级和灵活\n提供了多线程安全的数据库操作方法，有效地防止数据混乱",
                          @""];
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
