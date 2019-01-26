//
//  WKSwizzle.m
//  Navi
//
//  Created by wukeng on 2019/1/19.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "WKSwizzle.h"
#import <objc/runtime.h>

@implementation WKSwizzle

void WKSwizzleMethod(Class cls,SEL originalSelector,SEL swizzledSelector){
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(cls,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
