//
//  UserLocationManager.m
//  TravelDiary
//
//  Created by YDB MAC on 15/11/17.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "UserLocationManager.h"

@implementation UserLocationManager
+ (UserLocationManager *)sharedInstance
{
    static UserLocationManager *_instance = nil;
    
    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }
    
    return _instance;
}
-(id)init
{
    if (self == [super init])
    {
        [self initBMKUserLocation];
    }
    return self;
}

#pragma 初始化百度地图用户位置管理类
/**
 *  初始化百度地图用户位置管理类
 */
- (void)initBMKUserLocation
{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _geoCode = [[BMKGeoCodeSearch alloc] init];
    _geoCode.delegate = self;

//    [self startLocation];
    
}
#pragma 打开定位服务
/**
 *  打开定位服务
 */
-(void)startLocation
{
    [_locService startUserLocationService];
}
#pragma 关闭定位服务

/**
 *  关闭定位服务
 */
-(void)stopLocation
{
    [_locService stopUserLocationService];
}
#pragma BMKLocationServiceDelegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{

    cllocation = userLocation.location;
    _clloction = cllocation;
    _userLatitude = cllocation.coordinate.latitude;
    _userLongitude = cllocation.coordinate.longitude;
    
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    // 将获得的经纬度的数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [_geoCode reverseGeoCode:option];
  
    [self stopLocation];
//(如果需要实时定位不用停止定位服务)

}
#pragma mark 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        _cityName = [NSString stringWithFormat:@"%@", result.addressDetail.city];
        
           [[NSNotificationCenter defaultCenter] postNotificationName:@"location" object:_cityName];
    }else{
        
    }
}

/**
 *在停止定位后，会调用此函数
 */

- (void)didStopLocatingUser
{
 
    
}
/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */

- (void)didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}
@end
