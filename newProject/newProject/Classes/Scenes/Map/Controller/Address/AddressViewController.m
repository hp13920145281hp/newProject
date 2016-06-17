//
//  AddressViewController.m
//  四处逛逛
//
//  Created by ws on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//



#define kWindth ([UIScreen mainScreen].bounds.size.width)
#define kHeight ([UIScreen mainScreen].bounds.size.height)

#import "AddressViewController.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件


@interface AddressViewController ()<BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>

@property(nonatomic,strong)BMKMapView * mapView;//地图显示视图

@property(nonatomic,strong)BMKGeoCodeSearch * geoCode;

@property(nonatomic,strong)BMKLocationService * locService;
@property(nonatomic, strong)NSString *locationStr;//存储反编码的地理位置

@property(nonatomic,strong)UIButton * followBtn;//跟随指针按钮
@property(nonatomic,strong)UIButton * compassBtn;//罗盘指针按钮





@end

@implementation AddressViewController

- (void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    _locService.delegate = self;
    _geoCode.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kWindth, kHeight)];
    self.view = _mapView;
    _mapView.mapType = BMKMapTypeStandard;

    [self setPointerBotton];
    
    [self createMapView];
 
}


- (void)setPointerBotton{
    
#pragma mark 跟随指针Button
    _followBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _followBtn.frame = CGRectMake(20, kHeight - 155, kWindth / 2 - 40, 30);
    [_followBtn setTitle:@"跟随状态" forState:(UIControlStateNormal)];
    _followBtn.layer.masksToBounds = YES;
    _followBtn.layer.cornerRadius = 10;
    _followBtn.layer.borderWidth = 1;
    _followBtn.layer.borderColor = [UIColor blueColor].CGColor;
    _followBtn.backgroundColor = [UIColor whiteColor];
    
    [_followBtn addTarget:self action:@selector(followAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_mapView addSubview:_followBtn];
    
#pragma mark 罗盘指针Button

    
    _compassBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _compassBtn.frame = CGRectMake(CGRectGetMaxX(_followBtn.frame)+40, kHeight - 155, kWindth / 2 - 40, 30);
    [_compassBtn setTitle:@"罗盘状态" forState:(UIControlStateNormal)];
    _compassBtn.layer.masksToBounds = YES;
    _compassBtn.layer.cornerRadius = 10;
    _compassBtn.layer.borderWidth = 1;
    _compassBtn.layer.borderColor = [UIColor blueColor].CGColor;
    _compassBtn.backgroundColor = [UIColor whiteColor];
    
    [_compassBtn addTarget:self action:@selector(compassAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_mapView addSubview:_compassBtn];

}


- (void)createMapView{
    
    _geoCode = [[BMKGeoCodeSearch alloc]init];
    _geoCode.delegate = self;
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
    _mapView.zoomLevel = 17;
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    //设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    
    [_followBtn setEnabled:YES];
    [_followBtn setAlpha:1.0];
    
    [_compassBtn setEnabled:YES];
    [_compassBtn setAlpha:1.0];
    
}

//跟随指针事件
- (void)followAction:(UIButton *)sender{
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    NSLog(@"跟随测试的");
}

//罗盘指针事件
- (void)compassAction:(UIButton *)sender{
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;

    NSLog(@"罗盘测试的");
}


- (void)viewWillDisappear:(BOOL)animated{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _locService.delegate = nil;
    _geoCode.delegate = nil;
}

- (void)zoomMap:(id)sender{
    _mapView.zoomLevel = _mapView.zoomLevel++;
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    [_mapView updateLocationData:userLocation];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    // 将获得的经纬度的数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [_geoCode reverseGeoCode:option];
    userLocation.title = _locationStr;
    [_mapView updateLocationData:userLocation];
    
}


#pragma mark 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        _locationStr = [NSString stringWithFormat:@"%@ - %@", result.address, result.addressDetail.streetNumber];
    }else{
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
