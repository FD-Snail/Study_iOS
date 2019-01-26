//
//  UIImage+WK_NavigationBarTransition.h
//  Navi
//
//  Created by wukeng on 2019/1/19.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (WK_NavigationBarTransition)

+ (UIImage *)wk_imageWithColor:(UIColor *)color frame:(CGRect)frame;

+ (UIImage *)wk_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
