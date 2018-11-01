//
//  Photo_MainVC.m
//  study_iOS
//
//  Created by wukeng on 2018/10/27.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "Photo_MainVC.h"
#import "Demo1VC.h"
static NSString *const kCellIdentifier = @"cell_identifier";

@interface ListItem : NSObject
    
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) Class viewControllClass;
    
- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllClass:(Class)class;

@end

@interface Photo_MainVC ()<UITableViewDelegate,UITableViewDataSource>
    
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation Photo_MainVC
    
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[[[ListItem alloc] initWithTitle:@"Demo1"
                                         subTitle:@"使用照片选择器功能并且选好后自动布局"
                                viewControllClass: [Demo1VC class]],
                  [[ListItem alloc] initWithTitle:@"Demo2"
                                         subTitle:@"附带网络照片功能"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo3"
                                         subTitle:@"单选样式支持裁剪"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo4"
                                         subTitle:@"同个界面多个选择器"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo5"
                                         subTitle:@"拍照/选择照片完之后跳界面"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo6"
                                         subTitle:@"传入本地image/video并展示"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo7"
                                         subTitle:@"将已选模型(图片和视频)写入临时目录  一键写入^_^"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo8"
                                         subTitle:@"cell上添加photoView(附带3DTouch预览)"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo9"
                                         subTitle:@"保存草稿功能"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo10"
                                         subTitle:@"xib上使用HXPhotoView"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo11"
                                         subTitle:@"混合添加资源"
                                viewControllClass: [UIViewController class]],
                  [[ListItem alloc] initWithTitle:@"Demo12"
                                         subTitle:@"嵌套其他第三方图片/视频编辑库"
                                viewControllClass: [UIViewController class]]
                  
                  ];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

/**  */
- (void)setupUI{
    self.title = @"demo1 ~ 12";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 70;
    [self.view addSubview:tableView];
    
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    ListItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.subTitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListItem *item = self.dataSource[indexPath.row];
    UIViewController *viewController = [[item.viewControllClass alloc] init];
    viewController.title = item.title;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end


@implementation ListItem

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllClass:(Class)class
    {
        self = [super init];
        if (self) {
            self.title = title;
            self.subTitle = subTitle;
            self.viewControllClass = class;
        }
        return self;
    }

@end
