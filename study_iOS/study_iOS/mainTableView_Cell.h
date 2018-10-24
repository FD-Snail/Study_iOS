//
//  mainTableView_Cell.h
//  study_iOS
//
//  Created by wukeng on 2018/10/24.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface mainTableView_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mainLable;
@property (weak, nonatomic) IBOutlet UILabel *secondLable;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@end

NS_ASSUME_NONNULL_END
