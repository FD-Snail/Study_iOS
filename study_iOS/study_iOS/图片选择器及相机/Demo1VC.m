//
//  DemoVC.m
//  study_iOS
//
//  Created by wukeng on 2018/10/27.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import "Demo1VC.h"
#import "HXPhotoPicker.h"

static const CGFloat kPhotoViewMargin = 12.0;

@interface Demo1VC ()<HXPhotoViewDelegate,UIImagePickerControllerDelegate>
/** 图片选择器的管理类 */
@property (nonatomic, strong) HXPhotoManager *manager;
/** 选择图片后的展示View */
@property (nonatomic, strong) HXPhotoView *photoView;
/** 删除按钮 */
@property (strong, nonatomic) UIButton *bottomView;
/** 图片选择器的数据管理类 */
@property (strong, nonatomic) HXDatePhotoToolManager *toolManager;
/** 照片选择后展示的ScorllView */
@property (nonatomic, strong) UIScrollView *scorllView;

@property (assign, nonatomic) BOOL needDeleteItem;

@property (assign, nonatomic) BOOL showHud;
@end

@implementation Demo1VC
    
- (UIButton *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomView setTitle:@"删除" forState:UIControlStateNormal];
        [_bottomView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_bottomView setBackgroundColor:[UIColor redColor]];
        _bottomView.frame = CGRectMake(0, self.view.hx_h - 50, self.view.hx_w, 50);
        _bottomView.alpha = 0;
    }
    return _bottomView;
}

- (HXDatePhotoToolManager *)toolManager{
    if (!_toolManager) {
        _toolManager = [[HXDatePhotoToolManager alloc] init];
    }
    return _toolManager;
}
- (HXPhotoManager *)manager{
    if (!_manager) {
        /** 初始化HXPhotoManager-可以选择照片和视频 */
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        /** 打开相机功能 */
        _manager.configuration.openCamera = true;
        /** 是否开启查看LivePhoto功能呢 */
        _manager.configuration.lookLivePhoto = true;
        _manager.configuration.photoMaxNum = 9;
        _manager.configuration.videoMaxNum = 1;
        _manager.configuration.maxNum = 9;
        _manager.configuration.videoMaxDuration = 500.f;
        _manager.configuration.saveSystemAblum = YES;
//        _manager.configuration.reverseDate = YES;
        _manager.configuration.showDateSectionHeader = NO;
        _manager.configuration.selectTogether = NO;
//        _manager.configuration.rowCount = 3;
//        _manager.configuration.movableCropBox = YES;
//        _manager.configuration.movableCropBoxEditSize = YES;
//        _manager.configuration.movableCropBoxCustomRatio = CGPointMake(1, 1);
        _manager.configuration.requestImageAfterFinishingSelection = YES;
        __weak typeof(self) weakSelf = self;
//        _manager.configuration.replaceCameraViewController = YES;
        _manager.configuration.albumShowMode = HXPhotoAlbumShowModePopup;
        /** 使用系统相册做例子 */
        _manager.configuration.shouldUseCamera = ^(UIViewController *viewController, HXPhotoConfigurationCameraType cameraType, HXPhotoManager *manager){
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)weakSelf;
            imagePickerController.allowsEditing = NO;
            NSString *requiredMediaTypeImage = ( NSString *)kUTTypeImage;
            NSString *requiredMediaTypeMovie = ( NSString *)kUTTypeMovie;
            NSArray *arrMediaTypes;
            if (cameraType == HXPhotoConfigurationCameraTypePhoto) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage,nil];
            }else if (cameraType == HXPhotoConfigurationCameraTypeVideo) {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeMovie,nil];
            }else {
                arrMediaTypes=[NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediaTypeMovie,nil];
            }
            [imagePickerController setMediaTypes:arrMediaTypes];
            // 设置录制视频的质量
            [imagePickerController setVideoQuality:UIImagePickerControllerQualityTypeHigh];
            //设置最长摄像时间
            [imagePickerController setVideoMaximumDuration:60.f];
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
            imagePickerController.modalPresentationStyle=UIModalPresentationOverCurrentContext;
            [viewController presentViewController:imagePickerController animated:YES completion:nil];
        };
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
- (void)didNavBtnClick {
    //    [HXPhotoTools deleteLocalSelectModelArrayWithManager:self.manager];
    
    if (self.manager.configuration.specialModeNeedHideVideoSelectBtn && !self.manager.configuration.selectTogether && self.manager.configuration.videoMaxNum == 1) {
        if (self.manager.afterSelectedVideoArray.count) {
            [self.view showImageHUDText:@"请先删除视频"];
            return;
        }
    }
    [self.photoView goPhotoViewController];
}
- (void)setupUI{
    _scorllView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scorllView.alwaysBounceVertical = YES;
    [self.view addSubview:_scorllView];
//    self.scorllView = scrollView;
    
    CGFloat width = _scorllView.frame.size.width;
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(kPhotoViewMargin, kPhotoViewMargin, width - kPhotoViewMargin * 2, 0);
    photoView.delegate = self;
    //    photoView.outerCamera = YES;
    photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
    photoView.previewShowDeleteButton = YES;
    //    photoView.hideDeleteButton = YES;
    photoView.showAddCell = YES;
    //    photoView.disableaInteractiveTransition = YES;
    [photoView.collectionView reloadData];
    photoView.backgroundColor = [UIColor whiteColor];
    [_scorllView addSubview:photoView];
    self.photoView = photoView;
    
    UIBarButtonItem *cameraItem = [[UIBarButtonItem alloc] initWithTitle:@"相册/相机" style:UIBarButtonItemStylePlain target:self action:@selector(didNavBtnClick)];
    
    self.navigationItem.rightBarButtonItems = @[cameraItem];
    
    [self.view addSubview:self.bottomView];
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    //    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    //    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
    //    HXWeakSelf
    //    [self.toolManager getSelectedImageDataList:allList success:^(NSArray<NSData *> *imageDataList) {
    //        NSSLog(@"%ld",imageDataList.count);
    //    } failed:^{
    //
    //    }];
    //    if (!self.showHud) {
    //        self.showHud = YES;
    //        [self.toolManager writeSelectModelListToTempPathWithList:allList success:^(NSArray<NSURL *> *allURL, NSArray<NSURL *> *photoURL, NSArray<NSURL *> *videoURL) {
    //            NSSLog(@"allUrl - %@\nimageUrls - %@\nvideoUrls - %@",allURL,photoURL,videoURL);
    //            NSMutableArray *array = [NSMutableArray array];
    //            for (NSURL *url in allURL) {
    //                [array addObject:url.absoluteString];
    //            }
    //            [[[UIAlertView alloc] initWithTitle:nil message:[array componentsJoinedByString:@"\n\n"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    ////            [weakSelf.view showImageHUDText:[array componentsJoinedByString:@"\n"]];
    //        } failed:^{
    //
    //        }];
    //    }
    
    // 获取图片
    //    [self.toolManager getSelectedImageList:allList requestType:HXDatePhotoToolManagerRequestTypeOriginal success:^(NSArray<UIImage *> *imageList) {
    //
    //    } failed:^{
    //
    //    }];
    
    //    [HXPhotoTools selectListWriteToTempPath:allList requestList:^(NSArray *imageRequestIds, NSArray *videoSessions) {
    //        NSSLog(@"requestIds - image : %@ \nsessions - video : %@",imageRequestIds,videoSessions);
    //    } completion:^(NSArray<NSURL *> *allUrl, NSArray<NSURL *> *imageUrls, NSArray<NSURL *> *videoUrls) {
    //        NSSLog(@"allUrl - %@\nimageUrls - %@\nvideoUrls - %@",allUrl,imageUrls,videoUrls);
    //    } error:^{
    //        NSSLog(@"失败");
    //    }];
}

- (void)photoView:(HXPhotoView *)photoView imageChangeComplete:(NSArray<UIImage *> *)imageList {
    NSSLog(@"%@",imageList);
}

- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.scorllView.contentSize = CGSizeMake(self.scorllView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
    
}

- (void)photoView:(HXPhotoView *)photoView currentDeleteModel:(HXPhotoModel *)model currentIndex:(NSInteger)index {
    NSSLog(@"%@ --> index - %ld",model,index);
}

- (BOOL)photoViewShouldDeleteCurrentMoveItem:(HXPhotoView *)photoView gestureRecognizer:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    return self.needDeleteItem;
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerBegan:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.alpha = 0.5;
    }];
    NSSLog(@"长按手势开始了 - %ld",indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerChange:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.bottomView.hx_y) {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.alpha = 1;
        }];
    }else {
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomView.alpha = 0.5;
        }];
    }
    NSSLog(@"长按手势改变了 %@ - %ld",NSStringFromCGPoint(point), indexPath.item);
}
- (void)photoView:(HXPhotoView *)photoView gestureRecognizerEnded:(UILongPressGestureRecognizer *)longPgr indexPath:(NSIndexPath *)indexPath {
    CGPoint point = [longPgr locationInView:self.view];
    if (point.y >= self.bottomView.hx_y) {
        self.needDeleteItem = YES;
        [self.photoView deleteModelWithIndex:indexPath.item];
    }else {
        self.needDeleteItem = NO;
    }
    NSSLog(@"长按手势结束了 - %ld",indexPath.item);
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.alpha = 0;
    }];
}

@end
