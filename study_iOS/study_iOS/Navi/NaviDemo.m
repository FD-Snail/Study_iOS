//
//  NaviDemo.m
//  study_iOS
//
//  Created by wukeng on 2019/1/26.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "NaviDemo.h"
#import "UIViewController+WK_NavigationBarTransiton_Public.h"
#import "ColorPickerView.h"
#import "BigTitleVC.h"

#define WKScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define WKScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface NaviDemo ()

@property (strong, nonatomic) ColorPickerView *colorPickerView;

@property (strong, nonatomic) ColorPickerView *shadowColorPickerView;

@property (strong, nonatomic) UISlider *alphaSlider;

@end

@implementation NaviDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view, typically from a nib.
    if (_num == 0) {
        self.title = @"RootVC";
        _num = 0;
    }
    else{
        self.title = [NSString stringWithFormat:@"第%i个pushVC",_num];
    }
    
    // 随机颜色
    NSInteger red = arc4random()%255;
    NSInteger green = arc4random()%255;
    NSInteger blue = arc4random()%255;
    
    [self wk_setNavigationBarBackgroundColor:[UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:1]];
    __weak typeof(self) weakSelf = self;
    [self.colorPickerView colorPickerDidChangedBlock:^(ColorPickerView * _Nonnull colorPickerView, UIColor * _Nonnull currentColor) {
        [weakSelf wk_setNavigationBarBackgroundColor:currentColor];
    }];
    
    [self.shadowColorPickerView colorPickerDidChangedBlock:^(ColorPickerView * _Nonnull colorPickerView, UIColor * _Nonnull currentColor) {
        [weakSelf wk_setNavigationBarShadowImageBackgroundColor:currentColor];
    }];
    
    self.alphaSlider.value = 1;
}


- (void)setupUI{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton *push = [[UIButton alloc] init];
    [push setTitle:@"push" forState:UIControlStateNormal];
    [push setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    push.frame = CGRectMake(30, 100,(WKScreenWidth - 60 - 30) / 4.0,30);
    push.backgroundColor = [UIColor lightGrayColor];
    [push addTarget:self action:@selector(pushVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [push.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:push];
    
    UIButton *pop = [[UIButton alloc] init];
    [pop setTitle:@"pop" forState:UIControlStateNormal];
    [pop setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pop.frame = CGRectMake(CGRectGetMaxX(push.frame) + 10, 100,(WKScreenWidth - 60 - 30) / 4.0,30);
    pop.backgroundColor = [UIColor lightGrayColor];
    [pop addTarget:self action:@selector(popVCAction:) forControlEvents:UIControlEventTouchUpInside];
    [pop.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:pop];
    
    UIButton *popRoot = [[UIButton alloc] init];
    [popRoot setTitle:@"popRoot" forState:UIControlStateNormal];
    [popRoot setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    popRoot.frame = CGRectMake(CGRectGetMaxX(pop.frame) + 10, 100,(WKScreenWidth - 60 - 30) / 4.0,30);
    popRoot.backgroundColor = [UIColor lightGrayColor];
    [popRoot addTarget:self action:@selector(popRootAction:) forControlEvents:UIControlEventTouchUpInside];
    [popRoot.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:popRoot];
    
    UIButton *pushEmpty = [[UIButton alloc] init];
    [pushEmpty setTitle:@"iOS11新特性" forState:UIControlStateNormal];
    [pushEmpty setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    pushEmpty.frame = CGRectMake(CGRectGetMaxX(popRoot.frame) + 10, 100,(WKScreenWidth - 60 - 30) / 4.0,30);
    pushEmpty.backgroundColor = [UIColor lightGrayColor];
    [pushEmpty addTarget:self action:@selector(pushBigTitleVC:) forControlEvents:UIControlEventTouchUpInside];
    [pushEmpty.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:pushEmpty];
    
    UIButton *show = [[UIButton alloc] init];
    [show setTitle:@"show" forState:UIControlStateNormal];
    [show setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    show.frame = CGRectMake(30, 10 + CGRectGetMaxY(push.frame),(WKScreenWidth - 60 - 30) / 4.0,30);
    show.backgroundColor = [UIColor lightGrayColor];
    [show addTarget:self action:@selector(showBar:) forControlEvents:UIControlEventTouchUpInside];
    [show.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:show];
    
    UIButton *hide = [[UIButton alloc] init];
    [hide setTitle:@"hide" forState:UIControlStateNormal];
    [hide setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    hide.frame = CGRectMake(10 + CGRectGetMaxX(show.frame), 10 + CGRectGetMaxY(push.frame),(WKScreenWidth - 60 - 30) / 4.0,30);
    hide.backgroundColor = [UIColor lightGrayColor];
    [hide addTarget:self action:@selector(hideBar:) forControlEvents:UIControlEventTouchUpInside];
    [hide.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:hide];
    
    UIButton *aniShow = [[UIButton alloc] init];
    [aniShow setTitle:@"ani Show" forState:UIControlStateNormal];
    [aniShow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    aniShow.frame = CGRectMake(10 + CGRectGetMaxX(hide.frame), 10 + CGRectGetMaxY(push.frame),(WKScreenWidth - 60 - 30) / 4.0,30);
    aniShow.backgroundColor = [UIColor lightGrayColor];
    [aniShow addTarget:self action:@selector(showAnimationBar:) forControlEvents:UIControlEventTouchUpInside];
    [aniShow.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:aniShow];
    
    UIButton *aniHide = [[UIButton alloc] init];
    [aniHide setTitle:@"ani Hide" forState:UIControlStateNormal];
    [aniHide setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    aniHide.frame = CGRectMake(10 + CGRectGetMaxX(aniShow.frame), 10 + CGRectGetMaxY(push.frame),(WKScreenWidth - 60 - 30) / 4.0,30);
    aniHide.backgroundColor = [UIColor lightGrayColor];
    [aniHide addTarget:self action:@selector(hideAnimationBar:) forControlEvents:UIControlEventTouchUpInside];
    [aniHide.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:aniHide];
    
    UILabel *barColorL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(aniHide.frame) + 2, 40, 20)];
    [barColorL setText:@"Bar颜色"];
    [barColorL setTextColor:[UIColor blackColor]];
    [barColorL setFont:[UIFont systemFontOfSize:10]];
    [barColorL setCenter:CGPointMake(WKScreenWidth / 2, CGRectGetMaxY(aniHide.frame) + 12)];
    [self.view addSubview:barColorL];
    
    self.colorPickerView = [[ColorPickerView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(barColorL.frame) + 2, WKScreenWidth - 60, 100)];
    [self.view addSubview:self.colorPickerView];
    
    UILabel *barAlphaL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.colorPickerView.frame) + 2, 60, 20)];
    [barAlphaL setText:@"Bar透明度"];
    [barAlphaL setTextColor:[UIColor blackColor]];
    [barAlphaL setFont:[UIFont systemFontOfSize:10]];
    [barAlphaL setCenter:CGPointMake(WKScreenWidth / 2, CGRectGetMaxY(self.colorPickerView.frame) + 12)];
    [self.view addSubview:barAlphaL];
    
    self.alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(barAlphaL.frame) + 2, WKScreenWidth - 60, 30)];
    [self.view addSubview:self.alphaSlider];
    [self.alphaSlider addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];
    
    UIButton *ImageShow = [[UIButton alloc] init];
    [ImageShow setTitle:@"Show bar image" forState:UIControlStateNormal];
    [ImageShow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    ImageShow.frame = CGRectMake(30, 10 + CGRectGetMaxY(self.alphaSlider.frame),(WKScreenWidth - 60 - 10) / 2.0,30);
    ImageShow.backgroundColor = [UIColor lightGrayColor];
    [ImageShow addTarget:self action:@selector(showBarImage:) forControlEvents:UIControlEventTouchUpInside];
    [ImageShow.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:ImageShow];
    
    UIButton *ImageHide = [[UIButton alloc] init];
    [ImageHide setTitle:@"Hide bar image" forState:UIControlStateNormal];
    [ImageHide setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    ImageHide.frame = CGRectMake(10 + CGRectGetMaxX(ImageShow.frame), 10 + CGRectGetMaxY(self.alphaSlider.frame),(WKScreenWidth - 60 - 10) / 2.0,30);
    ImageHide.backgroundColor = [UIColor lightGrayColor];
    [ImageHide addTarget:self action:@selector(hideBarImage:) forControlEvents:UIControlEventTouchUpInside];
    [ImageHide.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:ImageHide];
    
    UIButton *shadowImgShow = [[UIButton alloc] init];
    [shadowImgShow setTitle:@"Show shadow image" forState:UIControlStateNormal];
    [shadowImgShow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    shadowImgShow.frame = CGRectMake(30, 10 + CGRectGetMaxY(ImageShow.frame),(WKScreenWidth - 60 - 10) / 2.0,30);
    shadowImgShow.backgroundColor = [UIColor lightGrayColor];
    [shadowImgShow addTarget:self action:@selector(showShadowImage:) forControlEvents:UIControlEventTouchUpInside];
    [shadowImgShow.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:shadowImgShow];
    
    UIButton *shadowImgHide = [[UIButton alloc] init];
    [shadowImgHide setTitle:@"Hide shadow image" forState:UIControlStateNormal];
    [shadowImgHide setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    shadowImgHide.frame = CGRectMake(10 + CGRectGetMaxX(ImageShow.frame), 10 + CGRectGetMaxY(ImageShow.frame),(WKScreenWidth - 60 - 10) / 2.0,30);
    shadowImgHide.backgroundColor = [UIColor lightGrayColor];
    [shadowImgHide addTarget:self action:@selector(hideShadowImage:) forControlEvents:UIControlEventTouchUpInside];
    [shadowImgHide.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:shadowImgHide];
    
    UILabel *barShadowColorL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shadowImgHide.frame) + 2, WKScreenWidth, 20)];
    [barShadowColorL setText:@"BarShadowImage颜色"];
    [barShadowColorL setTextColor:[UIColor blackColor]];
    [barShadowColorL setFont:[UIFont systemFontOfSize:10]];
    [barShadowColorL setCenter:CGPointMake(WKScreenWidth / 2, CGRectGetMaxY(shadowImgHide.frame) + 12)];
    [barShadowColorL setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:barShadowColorL];
    
    self.shadowColorPickerView = [[ColorPickerView alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(barShadowColorL.frame) + 2, WKScreenWidth - 60, 100)];
    [self.view addSubview:self.shadowColorPickerView];
}





- (void)pushVCAction:(id)sender {
    //    [self performSegueWithIdentifier:@"ShowViewControllerId" sender:nil];
    NaviDemo *vc = [[NaviDemo alloc] init];
    vc.num = self.num + 1;
    [self.navigationController pushViewController:vc animated:true];
}


- (void)popVCAction:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)popRootAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:true];
}

- (void)pushBigTitleVC:(UIButton *)sender{
    BigTitleVC *vc = [[BigTitleVC alloc] init];
    vc.title = @"iOS11新特性";
    [self.navigationController pushViewController:vc animated:true];
}

- (void)showBar:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:false animated:false];
    //    self.hideBar = NO;
}

- (void)hideBar:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)showAnimationBar:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:false animated:true];
    //    self.hideBar = NO;
}

- (void)hideAnimationBar:(UIButton *)sender{
    [self.navigationController setNavigationBarHidden:true animated:true];
}

- (void)showBarImage:(UIButton *)button{
    UIImage *bgImage = [UIImage imageNamed:@"bgicon.png"];
    // UIImageResizingModeTile 平铺模式
    bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    [self wk_setNavigationBarBackgroundImage:bgImage];
}

- (void)hideBarImage:(UIButton *)button{
    [self wk_setNavigationBarBackgroundImage:nil];
}

- (void)showShadowImage:(UIButton *)button{
    [self wk_setNavigationBarShadowImage:[UIImage imageNamed:@"shadowImage.png"]];
}

- (void)hideShadowImage:(UIButton *)button{
    [self wk_setNavigationBarShadowImage:[UIImage imageNamed:@"shadowImage.png"]];
}

- (void)sliderValueChange:(UISlider *)slider{
    [self wk_setNavigationBarAlpha:slider.value];
}



@end
