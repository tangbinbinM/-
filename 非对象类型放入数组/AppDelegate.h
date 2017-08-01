//
//  AppDelegate.h
//  非对象类型放入数组
//
//  Created by yg on 2017/8/1.
//  Copyright © 2017年 TBB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

