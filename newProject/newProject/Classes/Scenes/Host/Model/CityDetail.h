//
//  CityDetail.h
//  TravelDiary
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 YDB MAC. All rights reserved.
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
