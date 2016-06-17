//
//  SceneryModel.h
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SceneryModel : NSObject

//图片的id(跳转到详情页拼接接口用)
@property (nonatomic, copy) NSString *id;
//图片的标题
@property (nonatomic, copy) NSString *title;
//图片的路径
@property (nonatomic, copy) NSString *picUrl;
//图片的发布时间
@property (nonatomic, copy) NSString *date;
@end
