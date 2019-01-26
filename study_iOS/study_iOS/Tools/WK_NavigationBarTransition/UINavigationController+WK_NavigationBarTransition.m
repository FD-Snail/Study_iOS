//
//  UINavigationController+WK_NavigationBarTransition.m
//  Navi
//
//  Created by wukeng on 2019/1/19.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "UINavigationController+WK_NavigationBarTransition.h"
#import "UIViewController+WK_NavigationBarTranstion.h"
#import "UIImage+WK_NavigationBarTransition.h"
#import "UIViewController+WK_NavigationBarTransiton_Public.h"
#import "WKSwizzle.h"
#import <objc/runtime.h>

@interface UINavigationController()
/** 是否关闭本库 */
@property (readonly) BOOL closeWKNavigationBar;

@end

@implementation UINavigationController (WK_NavigationBarTransition)


+ (void)load{
    WKSwizzleMethod(self, @selector(viewDidLoad), @selector(wk_naviC_viewDidLoad));
    
    WKSwizzleMethod(self, @selector(viewWillLayoutSubviews), @selector(wk_naviC_viewWillLayoutSubviews));
    
    WKSwizzleMethod(self, @selector(setNavigationBarHidden:), @selector(wk_setNavigationBarHidden:));
    
    WKSwizzleMethod(self, @selector(setNavigationBarHidden:animated:), @selector(wk_setNavigationBarHidden:animated:));
    
    WKSwizzleMethod(self, @selector(pushViewController:animated:), @selector(wk_pushViewControl:animated:));
}

- (UIView *)getNavigationBarBackgroundView {
    static NSString *decodedString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        decodedString = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:@"X2JhY2tncm91bmRWaWV3" options:NSDataBase64DecodingIgnoreUnknownCharacters] encoding:NSUTF8StringEncoding];
    });
    
    return [self.navigationBar valueForKey:decodedString];
}

- (void)wk_naviC_viewDidLoad{
    [self wk_naviC_viewDidLoad];
    /** 没关闭 */
    if (!self.closeWKNavigationBar) {
        /** 设置navigationBar为透明，但是如果navigationBar.translucent = false,那么下面这句话就不起作用，navigationBar就会变成不透明的白色，所以不要设置navigationBar.translucent = false */
        [self.navigationBar setBackgroundImage:[UIImage wk_imageWithColor:[UIColor clearColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}


- (void)wk_naviC_viewWillLayoutSubviews{
    [self wk_naviC_viewWillLayoutSubviews];
    // 这里为了修复一个bug，当UIViewController的edgesForExtendedLayout赋值为非UIRectEdgeTop时(UIRectEdgeAll是包括了UIRectEdgeTop)，在UIViewController的viewWillLayoutSubviews获取到的导航栏高度不正常，缺少了状态栏高度。
    // 但当代码执行到UINavigationController的viewWillLayoutSubviews时，获取到的导航栏高度为正常高度。
    // 所以这里手动调用一下UIViewController的viewWillLayoutSubviews方法，来重新获取导航栏高度。
    if (self.viewControllers.count == 1) {
        /** 只需要在导航栏的第一个viewWillLayoutSubviews时执行一次就行，后续push的控制器都能获取到正常高度 */
        if ((self.topViewController.edgesForExtendedLayout & 0x1) != UIRectEdgeTop) {
            [self.topViewController viewWillLayoutSubviews];
        }
    }
}

- (void)wk_setNavigationBarHidden:(BOOL)hidden{
    /** 没有关闭本库 */
    if (!self.closeWKNavigationBar) {
        UIViewController *vc = [self.viewControllers lastObject];
        /** 先隐藏/显示barBgView */
        [vc wk_setNavigationBarHidden:hidden animated:NO];
    }
    /** 在隐藏/显示navigationBar */
    [self wk_setNavigationBarHidden:hidden];
}

- (void)wk_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated{
    /** 没有关闭本库 */
    if (!self.closeWKNavigationBar) {
        UIViewController *vc = [self.viewControllers lastObject];
        /** 先隐藏/显示barBgView */
        [vc wk_setNavigationBarHidden:hidden animated:NO];
    }
    /** 在隐藏/显示navigationBar */
    [self wk_setNavigationBarHidden:hidden animated:animated];
}

- (void)wk_pushViewControl:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 0) {
        [self wk_pushViewControl:viewController animated:animated];
        return;
    }
    
    /** 没有关闭本库 */
    if (!self.closeWKNavigationBar) {
        UIViewController *fromVC = [self.viewControllers lastObject];
        /** push时如果下一个页面没有设置背景色和透明度，那么会自动沿用当前页面的颜色和透明度 */
        /** 保存当前页面的bar颜色 */
        UIColor *bgColor = fromVC.wk_navigationBarBackgroundColor;
        [viewController wk_setNavigationBarBackgroundColor:bgColor];
        /** 保存当前页面的Bar图片 */
        UIImage *bgimage = fromVC.wk_navigationBarBackgroundImage;
        [viewController wk_setNavigationBarBackgroundImage:bgimage];
        /** 保存当前页面的透明度 */
        CGFloat alpha = fromVC.wk_navigationBarAlpha;
        [viewController wk_setNavigationBarAlpha:alpha];
        /** 保存shadowImage */
        UIImage *shadowImage = fromVC.wk_shadowImage;
        [viewController wk_setNavigationBarShadowImage:shadowImage];
        /** 保存shadowBackgroundColor */
        UIColor *shadowImageColor = fromVC.wk_shadowImageColor;
        [viewController wk_setNavigationBarShadowImageBackgroundColor:shadowImageColor];
    }
    /** 保存完成开始push */
    [self wk_pushViewControl:viewController animated:animated];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (void)closeWKNavigationBarFunction:(BOOL)close {
    [self openWKNavigationBarFunction:!close];
}
#pragma clang diagnostic pop

- (void)openWKNavigationBarFunction:(BOOL)open{
    BOOL close = !open;
    self.closeWKNavigationBar = close;
    if (close) {
        [self.navigationBar setBackgroundImage:nil forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:nil];
    }
    else{
        [self.navigationBar setBackgroundImage:[UIImage wk_imageWithColor:[UIColor clearColor]] forBarPosition:0 barMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}

- (void)setCloseWKNavigationBar:(BOOL)closeWKNavigationBar{
    objc_setAssociatedObject(self, @selector(closeWKNavigationBar), @(closeWKNavigationBar), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)closeWKNavigationBar{
    NSNumber *closed = objc_getAssociatedObject(self, _cmd);
    if (nil == closed) {
        return true;
    }
    else{
        return [closed boolValue];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-implementations"
- (BOOL)isCloseCFYNavigationBar {
    return ![self isOpenedWKNavigationBar];
}
#pragma clang diagnostic pop

- (BOOL)isOpenedWKNavigationBar{
    NSNumber *closed = objc_getAssociatedObject(self, @selector(closeWKNavigationBar));
    if (nil == closed) {
        return false;
    }
    else{
        return ![closed boolValue];
    }
}
@end
