//
//  StoriesModel.h
//  四处逛逛
//
//  Created by hupan on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoriesModel : NSObject
//用户名
@property (copy, nonatomic)NSString *userName;
//动态信息
@property (copy, nonatomic)NSString *text;
//图片数组
@property (strong, nonatomic)NSMutableArray *photoArr;
//头像
@property (strong, nonatomic)UIImage *header;
//用户ID
@property (copy, nonatomic)NSString *userID;

@end
