//
//  StoriesModel.h
//  四处逛逛
//
//  Created by hupan on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoriesModel : NSObject
//用户名
@property (copy, nonatomic)NSString *name;
//动态信息
@property (copy, nonatomic)NSString *text;
//图片
@property (strong, nonatomic)NSArray *photoArr;


@end
