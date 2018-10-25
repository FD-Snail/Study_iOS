//
//  WK_Tools.m
//  study_iOS
//
//  Created by wukeng on 2018/10/25.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "WK_Tools.h"
#import "Toast.h"

@implementation WK_Tools

+ (void)showToast:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow makeToast:string duration:2 position:CSToastPositionCenter];
    });
}

@end
