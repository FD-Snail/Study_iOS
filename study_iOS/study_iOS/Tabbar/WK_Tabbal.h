//
//  WK_Tabbal.h
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WK_TabbarDelegate <NSObject>

/** 选中tabbar */
- (void)selectedWK_TabbarItemWithIndex:(NSInteger)index;

@end

@interface WK_Tabbal : UITabBar

@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic ,strong) NSArray *titleArray;
@property (nonatomic ,strong) NSArray *imageArray;
@property (nonatomic ,strong) NSArray *selectedImageArray;
@property (nonatomic ,weak) id <WK_TabbarDelegate> tabbarDelegate;

/** 实例 */
+(instancetype)tabBarWithTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray selectedImageArray:(NSArray *)selectedImageArray;

@end

NS_ASSUME_NONNULL_END
