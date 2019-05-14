//
//  UIView+blackBackView.m
//  study_iOS
//
//  Created by wukeng on 2019/2/15.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "UIView+blackBackView.h"

@implementation UIView (blackBackView)


- (void)layerWillDraw:(CALayer *)layer{
    NSSLog(@"我被加载了");
}

- (void)layoutSubviews{
    NSSLog(@"LayoutSubViews");
}

@end
