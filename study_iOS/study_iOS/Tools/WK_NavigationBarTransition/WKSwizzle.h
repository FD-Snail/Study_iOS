//
//  WKSwizzle.h
//  Navi
//
//  Created by wukeng on 2019/1/19.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void WKSwizzleMethod(Class cls,SEL originalSelector,SEL swizzledSelector);

NS_ASSUME_NONNULL_BEGIN

@interface WKSwizzle : NSObject

@end

NS_ASSUME_NONNULL_END
