//
//  UIViewController+WK_NavigationBarTranstion.m
//  Navi
//
//  Created by wukeng on 2019/1/18.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "UIViewController+WK_NavigationBarTranstion.h"
#import "WK_NavigationBar.h"
#import "WKSwizzle.h"
#import "UIImage+WK_NavigationBarTransition.h"
#import "UIViewController+WK_NavigationBarTransiton_Public.h"
#import "UINavigationController+WK_NavigationBarTransition.h"

#import <objc/runtime.h>

#define _WKWeakSelf __weak typeof(self) weakSelf = self;
#define WKScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define WKScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface UIViewController()

/**
 wk_naviBarBgView就是核心，改变navigationBar颜色其实是改变wk_naviBarBgView的背景色
 */
@property (nonatomic,strong) WK_NavigationBar *wk_naviBarBgView;

/**
 用来判断View是否加载
 */
@property (nonatomic,assign) BOOL wk_viewAppeared;

/**
 保存navigationBar背景色
 */
@property (nonatomic,strong) UIColor *wk_navigationBarBackgroundColor;

/**
 保存navigationBar背景图片
 */
@property (nonatomic,strong) UIImage *wk_navigationBarBackgroundImage;

/**
 保存navigationBar透明度
 */
@property (nonatomic,assign) CGFloat wk_navigationBarAlpha;

/**
 保存navigationBar颜色透明度,用户用代码方式赋值来的
 */
@property (nonatomic, strong) NSNumber *wk_navigationBarAlpha_code;

/**
 保存navigationBar颜色透明度,继承自上一个导航栏来的
 */
@property (nonatomic, assign) NSNumber *wk_navigationBarAlpha_nav;

/**
 shadowImage
 */
@property (nonatomic, strong) UIImage *wk_shadowImage;

/**
 shadowImageColor
 */
@property (nonatomic, strong) UIColor *wk_shadowImageColor;

@end

@implementation UIViewController (WK_NavigationBarTranstion)

+ (void)load{
    WKSwizzleMethod(self, @selector(viewDidLoad), @selector(wk_viewDidLoad));
    
    WKSwizzleMethod(self, @selector(viewWillLayoutSubviews), @selector(wk_viewWillLayoutSubviews));
    
    WKSwizzleMethod(self, @selector(viewDidAppear:), @selector(wk_viewDidAppear:));
    
    WKSwizzleMethod(self, @selector(viewDidDisappear:), @selector(wk_viewDidDisappear:));
}

/**
 在viewDidLoad中添加cfy_navBarBgView
 */
- (void)wk_viewDidLoad {
    [self wk_viewDidLoad];
    // 如果存在navigationController则添加cfy_navBarBgView
    // 没有关闭使用本库的功能
    if ([self canAddCustomNavBar]) {
        [self wk_addNaviBarBgView];
    }
}


- (void)wk_viewDidAppear:(BOOL)animated{
    [self wk_viewDidAppear:animated];
    self.wk_viewAppeared = true;
}

- (void)wk_viewDidDisappear:(BOOL)animated{
    [self wk_viewDidDisappear:true];
    self.wk_viewAppeared = false;
}


/**
 在viewWillLayoutSubviews中对wk_naviBarBgView进行处理，使wk_naviBarBgView能在不同环境正确显示
 */
- (void)wk_viewWillLayoutSubviews{
    [self wk_viewWillLayoutSubviews];
    /** 当前控制器不允许添加navigationBar时，移除navigationBar */
    if (![self canAddCustomNavBar]) {
        if (self.wk_naviBarBgView) {
            [self.wk_naviBarBgView removeFromSuperview];
        }
        return;
    }
    
    /**
     self.navigationController.navigationBar隐藏了，做一些处理。
     如果在navigationBar隐藏时，旋转屏幕，这时如果不处理后并return，而是走下面的代码，那么并不能正确的获取到cfy_navBarBgView的frame。
     所以在这里直接将cfy_navBarBgView的宽度设置成屏幕看度，其他不变保持cfy_navBarBgView在隐藏前的状态，这样在从竖屏切换到横屏显示时不会出现一些视觉上的bug
     
     */
    if (self.navigationController.navigationBar.hidden) {
        CGRect rect = self.wk_naviBarBgView.frame;
        self.wk_naviBarBgView.frame = CGRectMake(0, rect.origin.y, WKScreenWidth, rect.size.height);
        return;
    }
    
    /** 获取navigationBar的backgroundView */
    UIView *backgroundView = [self.navigationController getNavigationBarBackgroundView];
    /** 如果没有则return */
    if (!backgroundView) {
        return;
    }
    
    /** 获取navigationBar的backgroundView在self.view中的位置，这个位置也就是wk_naviBarBgView所在的位置 */
    CGRect rect = [self wk_getNavigationBarBackgroundViewRect];
    
    self.wk_naviBarBgView.frame = rect;
    
    /** 设置当前view的clipsToBounds = No,原因是，self.view.top可能是从navigationBar.bottom开始，如果clipsToBounds = Yes,则wk_naviBarBgView无法显示 */
    self.view.clipsToBounds = false;
    /** 将wk_naviBarBgView移到self.view最上层，防止被其他view遮盖 */
    [self.view bringSubviewToFront:self.wk_naviBarBgView];
}

#pragma mark - 公有方法

/**
 设置导航栏背景色

 @param color 背景色
 */
- (void)wk_setNavigationBarBackgroundColor:(UIColor *)color{
    self.wk_navigationBarBackgroundColor = color;
    if ([self canAddCustomNavBar]) {
        self.wk_naviBarBgView.wk_navigationBarBackgroundColor = color;
    }
}


/**
 设置导航栏背景图

 @param image 背景图
 */
- (void)wk_setNavigationBarBackgroundImage:(UIImage *)image{
    self.wk_navigationBarBackgroundImage = image;
    if ([self canAddCustomNavBar]) {
        self.wk_naviBarBgView.wk_navigationBarBackgroundImage = image;
    }
}

/**
 设置导航栏透明度

 @param alpha 透明度
 */
- (void)wk_setNavigationBarAlpha:(CGFloat)alpha{
    self.wk_navigationBarAlpha_code = @(alpha);
    if ([self canAddCustomNavBar]) {
        self.wk_naviBarBgView.alpha = alpha;
    }
}

/**
 根据上个导航栏透明度设置当前导航栏透明度（库内使用）

 @param alpha 透明度
 */
- (void)wk_setNavigationBarAlphaFromLastNaviBar:(CGFloat)alpha{
    self.wk_navigationBarAlpha_nav = @(alpha);
}

/**
 设置导航栏底部线条颜色

 @param color 线条颜色
 */
- (void)wk_setNavigationBarShadowImageBackgroundColor:(UIColor *)color{
    self.wk_shadowImageColor = color;
    if ([self canAddCustomNavBar]) {
        self.wk_naviBarBgView.wk_shadowImageColor = color;
    }
}

- (void)wk_setNavigationBarShadowImage:(UIImage *)image{
    self.wk_shadowImage = image;
    if ([self canAddCustomNavBar]) {
        self.wk_naviBarBgView.wk_shadowImage = image;
    }
}

#pragma mark - 私有方法

/**
 设置导航栏是否隐藏

 @param hidden 隐藏
 @param animated 动画
 */
- (void)wk_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated{
    if ([self canAddCustomNavBar]) {
        /** 这里只在wk_naviBarBgView隐藏时使用了动画，原因是wk_naviBarBgView显示时系统自动加上了动画（神奇） */
        if (hidden && self.wk_viewAppeared && animated && !self.navigationController.navigationBar.hidden) {
            /** 在wk_naviBarBgView隐藏，并且View已经Appeared，并且有动画，并且navigationBar没有隐藏就进行动画 */
            CGRect rect = self.wk_naviBarBgView.frame;
            [UIView animateWithDuration:0.2 animations:^{
                self.wk_naviBarBgView.frame = CGRectMake(0, rect.origin.y - rect.size.height, rect.size.width, rect.size.height);
            } completion:^(BOOL finished) {
                self.wk_naviBarBgView.hidden = hidden;
            }];
        }
        else{
            self.wk_naviBarBgView.hidden = hidden;
        }
    }
}

- (WK_NavigationBar *)wk_addNaviBarBgView{
    if (![self canAddCustomNavBar]) {
        return nil;
    }
    if (!self.isViewLoaded) {
        return nil;
    }
    /** 获取NavigationBar的BackgroundView在当前view中的位置 */
    CGRect rect = [self wk_getNavigationBarBackgroundViewRect];
    /** 初始化 */
    WK_NavigationBar *naviBarBgView = [[WK_NavigationBar alloc] initWithFrame:rect];
    [self.view addSubview:naviBarBgView];
    /** 设置背景颜色 */
    naviBarBgView.wk_navigationBarBackgroundColor = self.wk_navigationBarBackgroundColor;
    
    /** 设置图片 */
    naviBarBgView.wk_navigationBarBackgroundImage = self.wk_navigationBarBackgroundImage;
    
    /** 设置透明度 */
    naviBarBgView.alpha = self.wk_navigationBarAlpha;
    
    if (self.wk_shadowImage) {
        naviBarBgView.wk_shadowImage = self.wk_shadowImage;
    }
    if (self.wk_shadowImageColor) {
        naviBarBgView.wk_shadowImageColor = self.wk_shadowImageColor;
    }
    /** 是否隐藏 */
    naviBarBgView.hidden = self.navigationController.navigationBar.isHidden;
    /** 保存 */
    [self setWk_naviBarBgView:naviBarBgView];
    return naviBarBgView;
}

/**
 获取navigationBar.backgroundView在self.view中的位置

 @return backgroundView的frame
 */
- (CGRect)wk_getNavigationBarBackgroundViewRect{
    UIView *backgroundView = [self.navigationController getNavigationBarBackgroundView];
    if (!backgroundView) {
        return CGRectZero;
    }
    
    CGRect rect = [backgroundView.superview convertRect:backgroundView.frame toView:self.view];
    if (rect.origin.y > 0) {
        rect.size.height = rect.origin.y + rect.size.height;
        rect.origin.y = 0;
    }
    if (@available(iOS 11.0, *)) {
        if (self.navigationController.navigationBar.prefersLargeTitles == true) {
            
        }
    } else {
        return rect;
    }
    return rect;
}

/**
 允许使用自定义的NaviBar

 @return 是否允许
 */
- (BOOL)canAddCustomNavBar{
    /** 前面的控制器是Navi */
//    if (![self.parentViewController isKindOfClass:[UINavigationController class]]) {
//        return false;
//    }
    /** 自己有Navi控制器 */
    if (!self.navigationController) {
        return false;
    }
    /** 没有navigationBar */
    if (!self.navigationController.navigationBar) {
        return false;
    }
    if (!self.navigationController.isOpenedWKNavigationBar) {
        return NO;
    }
    return true;
}

#pragma mark - setter/getter方法

/**
 自定义NavigationBar的getter方法

 @return 自定义NavigationBar
 */
- (WK_NavigationBar *)wk_naviBarBgView{
    WK_NavigationBar *naviBarBgView = objc_getAssociatedObject(self, _cmd);
    if (naviBarBgView == nil) {
        return [self wk_addNaviBarBgView];
    }
    else{
        CGRect frame = naviBarBgView.frame;
        if (frame.origin.x < 0) {
            /*
             * 出现frame.origin.x < 0的情况，只有在页面刚push出来并且navigationBar隐藏的时候。
             * 这个时候将rect.origin.y上移rect.size.height,使wk_naviBarBgView也隐藏
             * 目的是防止在navigationBar.hidden = NO时出现显示错误
             */
            frame.origin.x = 0;
            frame.origin.y = 0 - frame.size.height;
            naviBarBgView.frame = frame;
        }
    }
    return naviBarBgView;
};

- (void)setWk_naviBarBgView:(WK_NavigationBar *)wk_naviBarBgView{
    objc_setAssociatedObject(self, @selector(wk_naviBarBgView), wk_naviBarBgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)wk_viewAppeared{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setWk_viewAppeared:(BOOL)wk_viewAppeared{
    objc_setAssociatedObject(self, @selector(wk_viewAppeared), @(wk_viewAppeared), OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)wk_navigationBarBackgroundColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_navigationBarBackgroundColor:(UIColor *)wk_navigationBarBackgroundColor{
    objc_setAssociatedObject(self, @selector(wk_navigationBarBackgroundColor), wk_navigationBarBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)wk_navigationBarBackgroundImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_navigationBarBackgroundImage:(UIImage *)wk_navigationBarBackgroundImage{
    objc_setAssociatedObject(self, @selector(wk_navigationBarBackgroundImage), wk_navigationBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)wk_navigationBarAlpha{
    if (self.wk_navigationBarAlpha_code) {
        return self.wk_navigationBarAlpha_code.floatValue;
    }
    if (self.wk_navigationBarAlpha_nav) {
        return self.wk_navigationBarAlpha_nav.floatValue;
    }
    return 1;
}
- (void)setWk_navigationBarAlpha:(CGFloat)wk_navigationBarAlpha{
    self.wk_navigationBarAlpha_code = @(wk_navigationBarAlpha);
}

- (UIImage *)wk_shadowImage{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_shadowImage:(UIImage *)wk_shadowImage{
    objc_setAssociatedObject(self, @selector(wk_shadowImage), wk_shadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)wk_shadowImageColor{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_shadowImageColor:(UIColor *)wk_shadowImageColor{
    objc_setAssociatedObject(self, @selector(wk_shadowImageColor), wk_shadowImageColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)wk_navigationBarAlpha_code{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_navigationBarAlpha_code:(NSNumber *)wk_navigationBarAlpha_code{
    objc_setAssociatedObject(self, @selector(wk_navigationBarAlpha_code), wk_navigationBarAlpha_code, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)wk_navigationBarAlpha_nav{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWk_navigationBarAlpha_nav:(NSNumber *)wk_navigationBarAlpha_nav{
    objc_setAssociatedObject(self, @selector(wk_navigationBarAlpha_nav), wk_navigationBarAlpha_nav, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
