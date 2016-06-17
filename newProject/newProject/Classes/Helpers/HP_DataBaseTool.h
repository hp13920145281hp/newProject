//
//  HP_DataBaseTool.h
//  
//
//  Created by hupan on 16/4/22.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"


//SQLite操作的工具类
@interface HP_DataBaseTool : NSObject


//单例第二步:提供一个方法获取到自身对象
+ (instancetype)sharedDataBase;


//打开数据库
- (void)openDB;

//关闭数据库
- (void)closeDB;

//创建表
- (void)createTable;

//添加Person
- (void)insertUser:(User *)user;

//删除Person
- (void)deleteUserById:(NSInteger)pid;

//修改Person
- (void)updateUserWithName:(NSString *)name ByPid:(NSInteger)pid;

//查询所有的用户信息
- (NSArray *)selectAllUser;

@end
