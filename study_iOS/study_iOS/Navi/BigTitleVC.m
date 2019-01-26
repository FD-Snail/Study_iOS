//
//  BigTitleVC.m
//  Navi
//
//  Created by wukeng on 2019/1/26.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "BigTitleVC.h"

@interface BigTitleVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *datasource;

@end

@implementation BigTitleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.datasource = [[NSMutableArray alloc] initWithArray:@[@(1),@(1),@(1),@(1),@(1),@(1),@(1),
                                                              @(1),@(1),@(1),@(1),@(1),@(1),@(1),
                                                              @(1),@(1),@(1),@(1),@(1),@(1),@(1),]];
    if (@available(iOS 11.0, *)) {
        UISearchController *search = [[UISearchController alloc] initWithSearchResultsController:nil];
        self.navigationItem.searchController = search;
        [self.navigationController.navigationBar setPrefersLargeTitles:true];
//        NSDictionary *attributes = @{NSForegroundColorAttributeName:UIColorRGB(arc4random() % 255, arc4random() % 255, arc4random() % 255)};
//        self.navigationController.navigationBar.largeTitleTextAttributes = attributes;
    } else {
        
    }
    
}

- (UITableView *)tableview{
    if (!_tableview) {
        self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
        self.tableview.delegate = self;
        self.tableview.dataSource = self;
    }
    return _tableview;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //如果没有取到,就初始化
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"";
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setPrefersLargeTitles:false];
}
@end
