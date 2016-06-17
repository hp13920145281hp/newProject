//
//  UserLocationManager.h
//  TravelDiary
//
//  Created by YDB MAC on 15/11/17.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@interface UserLocationManager : NSObject<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    CLLocation *cllocation;
    BMKGeoCodeSearch *_geoCode;
    
    BMKReverseGeoCodeOption *reverseGeoCodeOption;//逆地理编码
}
@property (strong,nonatomic) BMKLocationService *locService;


//城市名
@property (strong,nonatomic) NSString *cityName;

//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;

//用户位置
@property (strong,nonatomic) CLLocation *clloction;


//初始化单例
+ (UserLocationManager *)sharedInstance;

//初始化百度地图用户位置管理类
- (void)initBMKUserLocation;

//开始定位
-(void)startLocation;

//停止定位
-(void)stopLocation;
@end
