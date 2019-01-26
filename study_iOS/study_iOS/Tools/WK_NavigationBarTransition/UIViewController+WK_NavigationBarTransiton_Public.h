//
//  UIViewController+WK_NavigationBarTransiton_Public.h
//  Navi
//
//  Created by wukeng on 2019/1/18.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WK_NavigationBarTransiton_Public)
/** 保存bar背景色 */
@property (nonatomic, readonly) UIColor *wk_navigationBarBackgroundColor;
/** 保存bar背景图 */
@property (nonatomic, readonly) UIImage *wk_navigationBarBackgroundImage;
/** 保存bar透明度 */
@property (nonatomic, readonly) CGFloat wk_navigationBarAlpha;
/** 保存bar阴影图 */
@property (nonatomic, readonly) UIImage *wk_shadowImage;
/** 保存bar阴影色 */
@property (nonatomic, readonly) UIColor *wk_shadowImageColor;

/**
 设置Bar背景色

 @param color 背景色
 */
- (void)wk_setNavigationBarBackgroundColor:(UIColor *)color;

/**
 设置Bar背景图

 @param image 背景图
 */
- (void)wk_setNavigationBarBackgroundImage:(UIImage *_Nullable)image;

/**
 设置导航栏透明度

 @param alpha 透明度，0~1.0
 */
- (void)wk_setNavigationBarAlpha:(CGFloat)alpha;

/**
 设置导航后底部线条颜色

 @param color 线条颜色，color为nil时，使用默认颜色RGBA(0,0,0,0.2)
 */
- (void)wk_setNavigationBarShadowImageBackgroundColor:(UIColor *_Nullable)color;

/**
 设置导航栏底部线条图片

 @param image 图片为nil时线条使用纯色
 */
- (void)wk_setNavigationBarShadowImage:(UIImage * _Nullable)image;

@end

@interface UINavigationController(WK_NavigationBarTransiton_Public)

/**
 关闭库的功能
 
 @param close 是否关闭
 */
- (void)closeWKNavigationBarFunction:(BOOL)close DEPRECATED_MSG_ATTRIBUTE("use openWKNavigationBarFunction: instead");

/**
 是否关闭
 */
@property (readonly) BOOL isCloseWKNavigationBar DEPRECATED_MSG_ATTRIBUTE("use isOpenedWKNavigationBar instead");

/**
 打开库的功能
 
 @param open 是否打开
 */
- (void)openWKNavigationBarFunction:(BOOL)open;

/**
 是否打开
 */
@property (readonly) BOOL isOpenedWKNavigationBar;

@end

NS_ASSUME_NONNULL_END
