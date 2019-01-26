//
//  UIImage+WK_NavigationBarTransition.m
//  Navi
//
//  Created by wukeng on 2019/1/19.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "UIImage+WK_NavigationBarTransition.h"

@implementation UIImage (WK_NavigationBarTransition)

+ (UIImage *)wk_imageWithColor:(UIColor *)color frame:(CGRect)frame{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)wk_imageWithColor:(UIColor *)color{
    return [UIImage wk_imageWithColor:color frame:CGRectMake(0, 0, 1, 1)];
}

@end
