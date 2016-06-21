//
//  CityHotSeneryModel.h
//  四处逛逛
//
//  Created by SuperCodi on 16/6/16.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityDetail : NSObject


//景区名
@property (nonatomic, copy) NSString *scenicName;
//地址
@property (nonatomic, copy) NSString *address;
//经度
@property (nonatomic, copy) NSString *longitude;
//纬度
@property (nonatomic, copy) NSString *latitude;
//图片
@property (nonatomic, copy) NSString *coverPic;
//开放时间
@property (nonatomic, copy) NSString *openTime;
//详细信息
@property (nonatomic, copy) NSString *intro;
//分享内容
@property (nonatomic, copy) NSString *shareIntro;


@end
