//
//  ColorPickerView.h
//  Navi
//
//  Created by wukeng on 2019/1/21.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ColorPickerView;
typedef void(^ColorPickerViewColorChangedBlock)(ColorPickerView *colorPickerView, UIColor *currentColor);

@interface ColorPickerView : UIView

@property (nonatomic,strong,readonly) UIColor *currentColor;

- (void)colorPickerDidChangedBlock:(ColorPickerViewColorChangedBlock)block;

@end

NS_ASSUME_NONNULL_END
