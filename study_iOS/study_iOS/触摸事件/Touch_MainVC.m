//
//  Touch_MainVC.m
//  study_iOS
//
//  Created by wukeng on 2018/11/1.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "Touch_MainVC.h"
#import "mainTableView_Cell.h"
//#import "Touch_Demo.h"

static NSString *const cellID = @"mainT_Cell";


@interface Touch_ListItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, assign) Class viewControllClass;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllClass:(Class)class;

@end

@interface Touch_MainVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation Touch_MainVC

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[[[Touch_ListItem alloc] initWithTitle:@"触摸事件"
                                                     subTitle:@"UIEvent:\niOS将触摸事件定义为第一个手指开始触摸屏幕到最后一个手指离开屏幕定义为一个触摸事件。用类UIEvent表示。\nUITouch:\n一个手指第一次点击屏，会形成一个UITouch对象，直到离开销毁。表示触碰。UITouch对象能表明了当前手指触碰的屏幕位置，状态。状态分为开始触碰、移动、离开。\n根据定义，UIEvent实际包括了多个UITouch对象。有几个手指触碰，就会有几个UITouch对象。"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"响应链"
                                                     subTitle:@"UIResponser包括了各种Touch message 的处理，比如开始，移动，停止等等。常见的UIResponser有 UIView及子类，UIViController,APPDelegate，UIApplication等等\n响应链是由UIResponser组成的，那么是按照哪种规则形成的\n1.程序启动:\n- UIApplication会生成一个单例，并会关联一个APPDelegate。APPDelegate作为整个响应链的根建立起来，而UIApplication会将自己与这个单例链接，即UIApplication的nextResponser(下一个事件处理者)为APPDelegate。\n2.创建UIWindow:\n- 程序启动后，任何的UIWindow被创建时，UIWindow内部都会把nextResponser设置为UIApplication单例。\n- UIWindow初始化rootViewController, rootViewController的nextResponser会设置为UIWindow\n3.UIViewController初始化\n- loadView, VC的view的nextResponser会被设置为VC.\n4.addSubView\n- addSubView操作过程中，如果子subView不是VC的View,那么subView的nextResponser会被设置为superView。如果是VC的View,那就是 subView -> subView.VC ->superView\n特别注意:\n- 如果在中途，subView.VC被释放，就会变成subView.nextResponser = superView"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"事件传递hitTest"
                                               subTitle:@"有了响应网为基础，事件的传递就比较简单，只需要选择其中一条响应链，但是选择那一条响应链来传递呢？为了弄清真个过程，我们先来查看一下从触摸硬件事件转化为UIEvent消息。\n1.首先用户触摸屏幕，系统的硬件进程会获取到这个点击事件，将事件简单处理封装后存到系统中，由于硬件检测进程和当前运行的APP是两个进程，所以进程两者之间传递事件用的是端口通信。硬件检测进程会将事件放入到APP检测的那个端口。\n2.其次，APP启动主线程RunLoop会注册一个端口事件，来检测触摸事件的发生。当时事件到达，系统会唤起当前APP主线程的Runloop。唤起原因就是端口触摸事件，主线程会分析这个事件。\n3.最后，系统判断该次触摸是否导致了一个新的事件, 也就是说是否是第一个手指开始触碰，如果是，系统会先从响应网中 寻找响应链。如果不是，说明该事件是当前正在进行中的事件产生的一个Touch message， 也就是说已经有保存好的响应链。"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"事件响应"
                                               subTitle:@"形成响应链之后，UIWindow会把事件目标锁定为hitTestView(响应链头的控件)，当手指状态发生变化， 会不停的发送UITouch Message 给这个hitTestView。 下面这几个方法会被调用。\n1.begin\n2.move\n3.end\n4.cancel,EstimatedPropertiesUpdate"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"手势处理"
                                                     subTitle:@"系统会将用户触摸屏幕的点事件 发送给手势，手势会根据具体的点击位置和序列，判断是否是某种特定行为。\n和UIResponser一样，手势也有这几个方法，点击的每个阶段手势都会响应不同的方法，手势会在以上四个方法中去对手势的State做更改，手势的State表明当前手势是识别还是失败等等。比如单击手势会在touchesBegan 时记录点击位置，然后在touchesEnded判断点击次数、时间、是否移动过，最后得出否识别该手势。这几个方法一般在自定义手势里面使用。\n1.手势的状态迁移只有在它们收到Touch message的时候，才能做状态变化处理代码。\n2.手势分为连续状态手势和不连续状态手势。连续手势有长按，慢滑等。不连续手势有单击，双击等等。\n3.当用户没有点击屏幕，所有手势都处于Possiable状态。当用户点击屏幕，手势会收到Touch Began Message， 手势的touchBegan方法会被调用。手势开始记录点击位置和时间。仍处于Possiable状态。如果用户按住不放，间隔超过一定时间，单击手势会变化为失败状态，并在下个一runloop变为possiable。如果时间大于长按手势设定时间，长按手势就会变化为Began状态，当用户移动手指，长按手势的touch move方法被调用，长按手势将自己状态设置为Change，并且也会回调处理方法。最后手指离开，系统调用长按手势touchEnd方法，手势状态回归为Recognized状态。"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"手势混合处理"
                                                     subTitle:@"如果一个View上既有单击，又有双击，用户点击该view两次， 默认情况下，单击被处理，双击不管用。因为默认情况下，一旦事件被某个手势处理，第二个手势会识别失败 幸运的是苹果提供了方法让我们修改这种默认行为，具体的方法如下\n- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;手势已经应分析出该事件可以响应，再对自己的状态进行更改之前，会询问代理的这个方法是否允许更改。默认为YES，如果你实现并设置为NO,那么手势会变为失败状态，这个可以用在手势只是别View的某几个区域的相应。\n- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;当两个手势都对该事件进行识别，但只有一个能响应，另外一个会失败。比如一个View上绑定两个单击事件。为了让两个手势都响应，我们可以实现此方法，让两个手势都响应。\n- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);\n- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer NS_AVAILABLE_IOS(7_0);这两个方法是iOS 7引入的，目的是让两个手势之间增加依赖，比如单击和双击，如果需要单击在双击失败的情况下识别，那么可以实现这两个方法。\n- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;\n-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press;这两个方法是判断手势在新的Touch和Press Began阶段是否关注该UITouch和UIPress对象，默认为YES，如果设置为NO,手势不会关注该Touch的任何状态变化。"
                                      viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"手势和事件响应"
                                                     subTitle:@"1.系统会通过hitTest的方法寻找响应链，完成之后会形成下图模型。\n2.有了模型之后就会发生图上的三个步骤\n- 第一步：系统会将所有的 Touch message 优先发送给 关联在响应链上的全部手势。手势根据Touch序列消息和手势基本规则更改自己的状态（有的可能失败，有的可能识别等等）。如果没有一个手势对Touch message 进行拦截（拦截:系统不会将Touch message 发送给响应链顶部响应者)，系统会进入第二步\n- 第二步：系统将Touch message 发送给响应链 顶部的 视图控件，顶部视图控件这个时候就会调用Touch相关的四个方法中的某一个。之后进入自定义Touch message转发\n- 第三步：自定义Touch message转发可以继承UIResponser的四个Touch函数做转发。"
                                            viewControllClass: [UIViewController class]],
                        [[Touch_ListItem alloc] initWithTitle:@"总结"
                                                     subTitle:@"事件分发过程分为：1.寻找响应链；2.事件消息分发\n响应网是事件响应的基础，响应链是事件响应的具体路径。\n事件消息分发优先发送给手势集合，手势内部会做冲突处理，过滤消息。不被过滤的消息会传递给响应链对象。"
                                            viewControllClass: [UIViewController class]]
                        ];
    }
    return _dataSource;
}

- (void)setupUI{
    self.title = @"触摸事件说明";
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerNib:[UINib nibWithNibName:@"mainTableView_Cell" bundle:nil] forCellReuseIdentifier:cellID];
    _tableView.estimatedRowHeight = 100.0f;
    /** 设置自动行高。在xib里进行约束让secondLable的高度约束撑起整个cell */
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
//    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    mainTableView_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[mainTableView_Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    Touch_ListItem *item = self.dataSource[indexPath.row];
    cell.mainLable.text = item.title;
    cell.secondLable.text = item.subTitle;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Touch_ListItem *item = self.dataSource[indexPath.row];
    UIViewController *viewController = [[item.viewControllClass alloc] init];
    viewController.title = @"触摸Demo";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end


@implementation Touch_ListItem

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle viewControllClass:(Class)class{
    self = [super init];
    if (self) {
        self.title = title;
        self.subTitle = subTitle;
        self.viewControllClass = class;
    }
    return self;
}

@end
