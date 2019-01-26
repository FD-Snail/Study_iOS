//
//  UIViewController+WK_NavigationBarTranstion.h
//  Navi
//
//  Created by wukeng on 2019/1/18.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WK_NavigationBarTranstion)


/**
 设置导航栏是否隐藏

 @param hidden 隐藏
 @param animated 动画
 */
- (void)wk_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated;


/**
 根据上一个导航栏透明度设置当前导航栏透明度

 @param alpha 透明度 0~1.0
 */
- (void)wk_setNavigationBarAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
