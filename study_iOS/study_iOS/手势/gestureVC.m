//
//  gestureVC.m
//  study_iOS
//
//  Created by wukeng on 2019/5/14.
//  Copyright © 2019 吴铿. All rights reserved.
//

#import "gestureVC.h"

@interface gestureVC ()<UIGestureRecognizerDelegate>

@property (nonatomic,strong) UIImageView *imageV;

@property (nonatomic,strong) UILabel *showLabel;

@end

@implementation gestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.jpg"]];
    [self.imageV setFrame:CGRectMake((SCREEN_WIDTH - 300) / 2, (SCREEN_HEIGHT - 300) / 2, 300, 300)];
    self.imageV.layer.cornerRadius = 150;
    self.imageV.layer.masksToBounds = true;
    self.imageV.userInteractionEnabled = true;
    [self.view addSubview:self.imageV];
    
    self.showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 60)];
    [self.showLabel setTextAlignment:NSTextAlignmentCenter];
    [self.showLabel setText:@"显示用"];
    [self.view addSubview:self.showLabel];
    
    [self addtapGesture];
    [self addLongPressGesture];
    [self addpinGesture];
    [self addrotateGesture];
//    [self addPanGesture];
    [self addSwipeGesture];
}

/** 点击手势 */
- (void)addtapGesture{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.delegate = self;
    [self.imageV addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
//    NSSLog(@"我点击了图片");
    CGPoint point = [tap locationInView:self.imageV];
    NSString *showStr = [NSString stringWithFormat:@"点击的坐标是(%.0f,%.0f)",point.x,point.y];
    [self.showLabel setText:showStr];
}

/** 长按手势 */
- (void)addLongPressGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressAction:)];
    longPress.minimumPressDuration = 1;
    longPress.allowableMovement = 40;
    longPress.delegate = self;
    [self.imageV addGestureRecognizer:longPress];
}

- (void)longpressAction:(UILongPressGestureRecognizer *)longpress{
    CGPoint point = [longpress locationInView:self.imageV];
    NSString *showStr = [NSString stringWithFormat:@"长按后的坐标是(%.0f,%.0f)",point.x,point.y];
    [self.showLabel setText:showStr];
}

/** 捏合手势 */
- (void)addpinGesture{
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [self.imageV addGestureRecognizer:pin];
}

- (void)pinAction:(UIPinchGestureRecognizer *)pin{
    self.imageV.transform = CGAffineTransformScale(self.imageV.transform, pin.scale, pin.scale);
    pin.scale = 1;
}

/** 旋转 */
- (void)addrotateGesture{
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateAction:)];
    rotate.delegate = self;
    [self.imageV addGestureRecognizer:rotate];
}

- (void)rotateAction:(UIRotationGestureRecognizer *)rotation{
    //旋转角度
    //旋转的角度也一个累加的过程
    NSSLog(@"旋转角度 %f",rotation.rotation);
    
    // 设置图片的旋转
    self.imageV.transform = CGAffineTransformRotate(self.imageV.transform, rotation.rotation);
    
    // 清除 "旋转角度" 的累加
    rotation.rotation = 0;
   
}

/** 拖动 */
- (void)addPanGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self.imageV addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan{
    //拖拽的距离(距离是一个累加)
    CGPoint trans = [pan translationInView:pan.view];
    NSLog(@"%@",NSStringFromCGPoint(trans));
    
    //设置图片移动
    CGPoint center =  self.imageV.center;
    center.x += trans.x;
    center.y += trans.y;
    self.imageV.center = center;
    
    //清除累加的距离
    [pan setTranslation:CGPointZero inView:pan.view];
}

/** 轻扫 */
- (void)addSwipeGesture{
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAciton:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    swipe.numberOfTouchesRequired = 1;
    [self.imageV addGestureRecognizer:swipe];
}

- (void)swipeAciton:(UISwipeGestureRecognizer *)swipe{
//    UISwipeGestureRecognizerDirection direction = swipe.direction;
    NSSLog(@"%lu",(unsigned long)swipe.direction);
    [self.showLabel setText:[NSString stringWithFormat:@"我向左轻扫了"]];
}
#pragma mark - 多手势共存的手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
