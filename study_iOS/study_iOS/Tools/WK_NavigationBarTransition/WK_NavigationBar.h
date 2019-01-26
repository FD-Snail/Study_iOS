//
//  WK_NavigationBar.h
//  Navi
//
//  Created by wukeng on 2019/1/18.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WK_NavigationBar : UIView

/**
 shadowImage图片
 可以没有，没有时使用背景色
 */
@property (nonatomic,strong) UIImage *wk_shadowImage;

/**
 shadowImage的颜色
 wk_shadowImage为null时才显示颜色
 */
@property (nonatomic,strong) UIColor *wk_shadowImageColor;

/**
 保存navigationbar的颜色
 */
@property (nonatomic,strong) UIColor *wk_navigationBarBackgroundColor;

/**
 保存navigationBar图片
 */
@property (nonatomic,strong) UIImage *wk_navigationBarBackgroundImage;

@end

NS_ASSUME_NONNULL_END
