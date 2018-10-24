//
//  AppDelegate.h
//  study_iOS
//
//  Created by wukeng on 2018/10/24.
//  Copyright © 2018年 吴铿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

