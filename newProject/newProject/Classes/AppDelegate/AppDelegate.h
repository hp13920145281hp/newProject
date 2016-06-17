//
//  AppDelegate.h
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FMDatabase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据库
@property (strong, nonatomic)FMDatabase *db;

//AppDelegate 的单例
+ (instancetype)shareAppDelegate;

@end

