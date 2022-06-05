//
//  WK_TabbarItem.h
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WK_TabbarItem : UIView

- (instancetype)initWithFram:(CGRect)frame index:(NSInteger)index;

//点击图标后的一系列操作。
- (void)configTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage index:(NSInteger)index selected:(BOOL)selected lastSelectIndex:(NSInteger )lastSelectIndex;



@end

NS_ASSUME_NONNULL_END
