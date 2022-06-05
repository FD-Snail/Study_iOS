//
//  WK_TabbarItem.m
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import "WK_TabbarItem.h"
#import "WK_TabbarItemCell.h"

@interface WK_TabbarItem ()<UICollectionViewDelegate ,UICollectionViewDataSource>
/** tabbar的文字显示 */
@property (nonatomic ,strong) UILabel *titleLabel;
/** tabbar 图片 */
@property (nonatomic ,strong) UIImageView *imageView;
/*
 *  index=0时，即首页tababr 选中时的背景图片
 *  效果图细节：背景原图片没有变化，只是背景图片上的火箭🚀和logo 两个切换动画，
 *  所以: 隔离开背景部分和动画部分
 */
@property (nonatomic, strong) UIImageView *homeTabSelectedBgView;

/*
 *  动画部分
 *  第二种方案，用的是collectionView, 通过滑动到某个item进行动画
 *  结果：完美实现功能
 */
@property (nonatomic, strong) UICollectionView *collectionView;
/*
 *  flag，用以点击首页tabbar时 如果是火箭状态，则进行切换logo动画，且界面滑到顶部
 */
@property (nonatomic, assign) BOOL flag;


@end

@implementation WK_TabbarItem
/** 初始化 */
- (instancetype)initWithFram:(CGRect)frame index:(NSInteger)index{
    self = [super initWithFrame:frame];
    if (self) {
        [self.imageView setFrame:CGRectMake(self.bounds.size.width/2 - 14, 7, 28, 28)];
        [self.titleLabel setFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 2, self.bounds.size.width, 14)];
        self.homeTabSelectedBgView.frame = CGRectMake(self.bounds.size.width / 2 - 21, 7, 42, 42);
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.homeTabSelectedBgView];
        
        // 当为首页tab时，加上以下内容：添加一个collectView，用作火箭上下的动画。
        if (index == 0) {
           
            [self.homeTabSelectedBgView addSubview:self.collectionView];
            self.collectionView.frame = CGRectMake(0, 0, 42, 42);
            self.collectionView.center = CGPointMake(self.homeTabSelectedBgView.frame.size.width / 2, self.homeTabSelectedBgView.frame.size.height/2);
            [self.collectionView registerClass:[WK_TabbarItemCell class] forCellWithReuseIdentifier:NSStringFromClass([WK_TabbarItemCell class])];
        }
    }
    return self;
}


#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  2;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WK_TabbarItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WK_TabbarItemCell class]) forIndexPath:indexPath];
    NSString *imageStr = (indexPath.item == 0) ? @"tabbar_home_selecetedLogo" : @"tabbar_home_selecetedPush";
    [cell configItemImageString:imageStr];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - 配置item内容
- (void)configTitle:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage index:(NSInteger)index selected:(BOOL)selected lastSelectIndex:(NSInteger)lastSelectIndex{
    self.titleLabel.text = title;
    // 首页内容
    if (index == 0) {
        if (selected) {
            //点击首页图标
            [self.homeTabSelectedBgView setImage:[UIImage imageNamed:@"tabbar_home_selecetedBg"]];
            self.homeTabSelectedBgView.hidden = false;
            self.imageView.hidden = self.titleLabel.hidden = true;
            if (lastSelectIndex == index) {
                //本身就在首页时点击首页tabbar的配置情况
                if (self.flag) {
                    [self pushHomeTabAnimationDown];
                    //发通知告知表格弹到最上面
                }
                else{
                    [self animationWithHomeTab];
                }
            }
        }
        //不是点击首页的配置情况
        else{
            [self.imageView setImage:[UIImage imageNamed:normalImage]];
            self.homeTabSelectedBgView.hidden = true;
            self.imageView.hidden = self.titleLabel.hidden = false;
        }
    }
    //其他几个tabbarItem的配置内容
    else{
        self.homeTabSelectedBgView.hidden = true;
        self.imageView.hidden = self.titleLabel.hidden = false;
        //被点击（选中）
        if (selected) {
            [self.imageView setImage:[UIImage imageNamed:selectedImage]];
            self.titleLabel.textColor = [self colorFromHexRGB:@"18A2FF"];
            //如果本次点击和上次同一个tab 则无反应，否则执行放大缩小动画
            if (lastSelectIndex != index) {
                //执行动画
                [self animationWtihNormalTab];
            }
        }
        else{
            [self.imageView setImage:[UIImage imageNamed:normalImage]];
            [self.titleLabel setTextColor:[self colorFromHexRGB:@"575d66"]];
        }
    }
}



#pragma mark - tabbarItem的动画
//点击放大缩小的动画
- (void)animationWithHomeTab{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration  = 0.2f;
    animation.fromValue = [NSNumber numberWithFloat:0.5f];
    animation.toValue   = [NSNumber numberWithFloat:1.f];
    [self.homeTabSelectedBgView.layer addAnimation:animation forKey:nil];
}
- (void)animationWtihNormalTab{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration  = 0.25f;
    animation.fromValue = [NSNumber numberWithFloat:0.5f];
    animation.toValue   = [NSNumber numberWithFloat:1.f];
    [self.imageView.layer  addAnimation:animation forKey:nil];
    [self.titleLabel.layer addAnimation:animation forKey:nil];
}

//首页tabbar火箭的动画
-(void)pushHomeTabAnimationUp{
    self.flag = true;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:true];
}

-(void)pushHomeTabAnimationDown{
    self.flag = false;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:true];
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10];
        _titleLabel.textColor = [self colorFromHexRGB:@"575D66"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = true;
    }
    return _imageView;
}

- (UIImageView *)homeTabSelectedBgView{
    if (!_homeTabSelectedBgView) {
        _homeTabSelectedBgView = [[UIImageView alloc] init];
        _homeTabSelectedBgView.userInteractionEnabled = true;
        _homeTabSelectedBgView.hidden = true;
    }
    return _homeTabSelectedBgView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout  *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        flowlayout.itemSize = CGSizeMake(42.f, 42.f);
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 0;
        flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0 );
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = true;
        _collectionView.scrollEnabled = false;
        
    }
    return _collectionView;
}

#pragma mark - 16进制颜色
- (UIColor *) colorFromHexRGB:(NSString *) inColorString {
    //删除字符串中的空格
    NSString *cString = [[inColorString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if ([cString length] != 6&&[cString length] != 8) return [UIColor blackColor];
    
    if([cString length] == 8){
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        range.location = 6;
        NSString *aString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b, a;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:((float) a / 255.0f)];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
