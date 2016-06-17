//
//  HP_DataBaseTool.m
//
//
//  Created by hupan on 16/4/22.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "HP_DataBaseTool.h"
#import <sqlite3.h>

//单例第一步:声明一个静态的自身类型的对象
static HP_DataBaseTool *database = nil;

@implementation HP_DataBaseTool

//创建数据库对象
static sqlite3 *db = nil;

//单例第二步的实现
+ (instancetype)sharedDataBase{
    @synchronized(self) {
        if (nil == database) {
            database = [[self alloc]init];
        }
    }
    return database;
}

//打开数据库
- (void)openDB{
   //拿到document文件夹路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //这里的文件路径的后缀名必须是.sqlite
    NSString *sqlPath = [docPath stringByAppendingString:@"/data.sqlite"];
    NSLog(@"%@", sqlPath);
    //调用框架的方法进行数据库文件打开
    //两个参数,第一个是文件的路径,是char*格式
    //第二个参数是数据库对象的地址
    int result = sqlite3_open(sqlPath.UTF8String, &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败%d", result);
    }
}

//关闭数据库
- (void)closeDB{
    if (nil == db) {
        NSLog(@"数据库已经关闭,无需重复操作");
        return;
    }
   int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"数据库关闭成功");
        db = nil;
    }else{
        NSLog(@"数据库关闭失败%d", result);
    }
}

//创建表
- (void)createTable{
    //1 拼接SQL语句(加IF NOT EXISTS)
    NSString *strSQL = @"CREATE TABLE IF NOT EXISTS hp_user (pid INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE, name TEXT, password TEXT, sign TEXT, gender TEXT);";
    //2 执行SQ语句
   int result = sqlite3_exec(db, strSQL.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表语句执行成功");
    }else{
        NSLog(@"创建表语句执行失败%d", result);
    }
}

//添加Person
- (void)insertUser:(User *)user{
    //1 准备SQL语句
    NSString *strSQL = @"INSERT INTO hp_user(name, password) values(?,?);";
    //2 伴随指针 用于绑定数据和获取数据
    sqlite3_stmt *stmt = NULL;
    //3 预执行SQL语句
    int result = sqlite3_prepare(db, strSQL.UTF8String, -1, &stmt, NULL);
    //如果预执行没有问题
    if (result == SQLITE_OK) {
        //4 绑定参数
        //第一个参数:绑定的伴随指针,第二个参数:要绑定到第几个参数,第三个参数:绑定的内容, 第四个:绑定的长度限制 第五个:回调对象
        sqlite3_bind_text(stmt, 1, user.name.UTF8String, -1, NULL);
        sqlite3_bind_text(stmt, 2, user.password.UTF8String, -1, NULL);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
    }
    //释放伴随指针
    sqlite3_finalize(stmt); 
}

//删除Person
- (void)deleteUserById:(NSInteger)pid{
    //1.SQL语句
    NSString *strSQL = @"DELETE FROM hp_user WHERE pid = ?";
    //2.伴随指针
    sqlite3_stmt *stmt = NULL;
    //3.预执行
    int result = sqlite3_prepare(db, strSQL.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_int64(stmt, 1, pid);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"删除成功");
        }else{
            NSLog(@"删除失败");
        }
    }
    sqlite3_finalize(stmt);
}

//修改Person
- (void)updateUserWithName:(NSString *)name ByPid:(NSInteger)pid{
    //1.拼接SQL语句
    NSString *strSQL = @"UPDATE hp_user SET name = ? WHERE pid = ?";
    //2.伴随指针
    sqlite3_stmt *stmt = NULL;
    //3.预执行语句
    int result = sqlite3_prepare(db, strSQL.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, name.UTF8String, -1, NULL);
        sqlite3_bind_int64(stmt, 2, pid);
        if (sqlite3_step(stmt) == SQLITE_DONE) {
            NSLog(@"修改成功");
        }else{
            NSLog(@"修改失败");
        }
    }
    sqlite3_finalize(stmt);
    
}

//查询所有的用户信息
- (NSArray *)selectAllUser{
    NSMutableArray *arr = [NSMutableArray array];
    //1 拼接SQL语句
    NSString *strSQL = @"SELECT *FROM hp_user;";
    //2 创建伴随指针
    sqlite3_stmt *stmt = NULL;
    //3 预执行SQL语句
    int result = sqlite3_prepare(db, strSQL.UTF8String, -1, &stmt, NULL);
    //如果预执行没有问题
    if (result == SQLITE_OK) {
        //如果需要绑定参数,在这里进行参数绑定
        //......
        //......
        //循环读取预执行结果里的每一条数据,放到最终结果的数组中
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            User *u = [[User alloc] init];
            int pid = sqlite3_column_int(stmt, 0);
            u.pid = pid;
            NSString *name = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            u.name = name;
            NSString *password = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            u.password = password;
            NSString *sign = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            u.sign = sign;
            NSString *gender = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 4)];
            u.gender = gender;
            //将person对象添加到数组中
            [arr addObject:u];
        }
    }
    //释放游标
    sqlite3_finalize(stmt);
    return arr;
}


@end
