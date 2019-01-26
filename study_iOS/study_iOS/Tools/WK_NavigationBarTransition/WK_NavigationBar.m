//
//  WK_NavigationBar.m
//  Navi
//
//  Created by wukeng on 2019/1/18.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "WK_NavigationBar.h"

@interface WK_NavigationBar()

@property (nonatomic,strong) UIImageView *wk_shadowImageView;

@property (nonatomic,strong) UIImageView *wk_backgroundImageView;

@end

@implementation WK_NavigationBar

/** 给两个属性起个别名 */
@synthesize wk_navigationBarBackgroundColor = _wk_navigationBarBackgroundColor;
@synthesize wk_shadowImageColor = _wk_shadowImageColor;

- (void)layoutSubviews{
    [super layoutSubviews];
    self.wk_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight]);
    self.wk_backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)getImageViewHeight {
    CGFloat height = 0.5;
    if (self.wk_shadowImage) {
        height = self.wk_shadowImage.size.height;
    }
    return height;
}

#pragma mark - getter/setter

/**
 阴影View的getter方法

 @return 阴影View
 */
- (UIImageView *)wk_shadowImageView{
    if (_wk_shadowImageView == nil) {
        CGFloat height = 0.5;
        UIImage *image = nil;
        if (self.wk_shadowImage) {
            image = self.wk_shadowImage;
            height = self.wk_shadowImage.size.height;
        }
        else if([UINavigationBar appearance].shadowImage){
            image = [UINavigationBar appearance].shadowImage;
            _wk_shadowImage = image;
            height = [UINavigationBar appearance].shadowImage.size.height;
        }
        _wk_shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), height)];
        _wk_shadowImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        if (image) {
            [_wk_shadowImageView setImage:image];
        }
        [self addSubview:_wk_shadowImageView];
    }
    return _wk_shadowImageView;
}

/**
 背景View-getter方法

 @return 背景View
 */
- (UIImageView *)wk_backgroundImageView{
    if (_wk_backgroundImageView == nil) {
        if (_wk_backgroundImageView == nil) {
            _wk_backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            _wk_backgroundImageView.backgroundColor = [UIColor clearColor];
            if (self.wk_navigationBarBackgroundImage) {
                [_wk_backgroundImageView setImage:self.wk_navigationBarBackgroundImage];
            }
        }
        [self addSubview:_wk_backgroundImageView];
    }
    return _wk_backgroundImageView;
}

/**
 阴影图片 - setter方法

 @param wk_shadowImage 阴影图片
 */
- (void)setWk_shadowImage:(UIImage *)wk_shadowImage{
    _wk_shadowImage = wk_shadowImage;
    [_wk_shadowImageView setImage:wk_shadowImage];
    CGFloat height = wk_shadowImage.size.height;
    if (!wk_shadowImage) {
        height = 0.5;
    }
    self.wk_shadowImageView.backgroundColor = self.wk_shadowImageColor;
    self.wk_shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), height);
}

- (UIColor *)wk_shadowImageColor{
    if (_wk_shadowImageColor == nil) {
        _wk_shadowImageColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return _wk_shadowImageColor;
}

- (void)setWk_shadowImageColor:(UIColor *)wk_shadowImageColor{
    if (!wk_shadowImageColor) {
        wk_shadowImageColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    _wk_shadowImageColor = wk_shadowImageColor;
    self.wk_shadowImageView.backgroundColor = wk_shadowImageColor;
    self.wk_shadowImageView.frame =  CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), [self getImageViewHeight]);
}

- (UIColor *)wk_navigationBarBackgroundColor{
    if (_wk_navigationBarBackgroundColor == nil) {
        _wk_navigationBarBackgroundColor = [UIColor whiteColor];
    }
    return _wk_navigationBarBackgroundColor;
}

- (void)setWk_navigationBarBackgroundColor:(UIColor *)wk_navigationBarBackgroundColor{
    if (!wk_navigationBarBackgroundColor) {
        wk_navigationBarBackgroundColor = [UINavigationBar appearance].barTintColor ?:[UIColor whiteColor];
    }
    _wk_navigationBarBackgroundColor = wk_navigationBarBackgroundColor;
    self.backgroundColor = wk_navigationBarBackgroundColor;
}

- (void)setWk_navigationBarBackgroundImage:(UIImage *)wk_navigationBarBackgroundImage{
    _wk_navigationBarBackgroundImage = wk_navigationBarBackgroundImage;
    self.wk_backgroundImageView.image = wk_navigationBarBackgroundImage;
}
@end
