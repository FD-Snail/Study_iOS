//
//  WK_Tabbal.m
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import "WK_Tabbal.h"

#import "WK_TabbarItem.h"

@interface WK_Tabbal()

@property (nonatomic, assign) NSInteger lastSelectIndex;//记录上次的点击index

@property (nonatomic, assign) NSInteger selectedIndex; //当前的点击index;

@end

@implementation WK_Tabbal

// 删除系统的tabbarbutton
- (void) layoutSubviews{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
        }
    }
}
// 创建tabbar
+ (instancetype)tabBarWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray selectedImageArray:(NSArray *)selectedImageArray{
    WK_Tabbal *tab = [[WK_Tabbal alloc] init];
    tab.titleArray = titleArray;
    tab.imageArray = imageArray;
    tab.selectedImageArray = selectedImageArray;
    [tab setupUI];
    return tab;
}

-  (void)setupUI{
    self.lastSelectIndex = 100;
    self.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < self.titleArray.count ; i++) {
        CGFloat itemwith = (SCREEN_WIDTH / self.titleArray.count);
        CGRect frame = CGRectMake(i*itemwith, 0, itemwith, 56);
        WK_TabbarItem *tabBaritem = [[WK_TabbarItem alloc] initWithFram:frame index:i];
        tabBaritem.tag = i;
        // 添加触摸事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTabbarItemAction:)];
        [tabBaritem addGestureRecognizer:tap];
        [self addSubview:tabBaritem];
        [self.itemArray addObject:tabBaritem];
    }
    self.selectedIndex = 0;
}

- (void)selectTabbarItemAction:(UITapGestureRecognizer *)sender{
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(selectedTabbarAtIndex:) object:@(sender.view.tag)];
    [self performSelector:@selector(selectedTabbarAtIndex:) withObject:@(sender.view.tag) afterDelay:0.15f];
}

- (void)selectedTabbarAtIndex:(NSNumber *)index{
    self.selectedIndex = [index integerValue];
    if ([self.tabbarDelegate respondsToSelector:@selector(selectedWK_TabbarItemWithIndex:)]) {
        [self.tabbarDelegate selectedWK_TabbarItemWithIndex:self.selectedIndex];
    }
}

// 重写selectedIndex 的set方法 每次赋值的时候都进来更改下tabbarItem的状态
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    NSLog(@"我进来设置tabbarItem了");
    _selectedIndex = selectedIndex ;
    //遍历itemArray 对其中的tabbarItem进行赋值
    [self.itemArray enumerateObjectsUsingBlock:^(WK_TabbarItem *tabBarItem, NSUInteger idx, BOOL * _Nonnull stop) {
        //记录选中状态
        bool selected = (idx == selectedIndex);
        //配置tabbarItem的内容信息
        [tabBarItem configTitle:self.titleArray[idx] normalImage:self.imageArray[idx] selectedImage:self.selectedImageArray[idx] index:idx selected:selected lastSelectIndex:self.lastSelectIndex];
        //对lastSeclectIndex进行赋值
        if (idx == self.itemArray.count - 1) {
            self.lastSelectIndex = selectedIndex;
        }
    }];
}
#pragma mark - 懒加载
- (NSMutableArray *)itemArray{
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    return  _itemArray;
}

- (NSArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}

- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSArray array];
    }
    return _imageArray;
}

- (NSArray *)selectedImageArray{
    if (!_selectedImageArray) {
        _selectedImageArray = [NSArray array];
    }
    return _selectedImageArray;
}
@end
