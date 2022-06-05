//
//  WK_TabbarItemCell.m
//  study_iOS
//
//  Created by 吴铿 on 2022/6/3.
//  Copyright © 2022 吴铿. All rights reserved.
//

#import "WK_TabbarItemCell.h"

@interface WK_TabbarItemCell()

@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation WK_TabbarItemCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        self.imageView.frame = CGRectMake(0, 0, 42.f, 42.f);
        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}

- (void)configItemImageString:(NSString *)imgString{
    [self.imageView setImage:[UIImage imageNamed:imgString]];
}
@end
