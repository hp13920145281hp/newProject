//
//  AppDelegate.m
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <FMDB.h>
#import "UserLocationManager.h"
#import <UMSocialSinaSSOHandler.h>
#import <UMSocial.h>

@interface AppDelegate ()
//地图管理对象
@property(nonatomic,strong)BMKMapManager * mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RootViewController *rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = rootVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //地图相关
    [self baiduMap];
    
    //设置友盟相关
    [self setUm];
    
    
    return YES;
}
- (void)setUm{
    //设置友盟的APPKEY
    [UMSocialData setAppKey:@"5764fd72e0f55a2bf00030e5"];
    
    //设置新浪微博相关内容
    //把在新浪微博注册的应用的 APPKEY, redirectURL 替换为下面的参数,并且在 INFO 中添加对应的 wb+APPKEY
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954" secret:@"04b48b094faeb16683c32669824ebdad" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

//系统回调方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == false) {
        //做其他操作,或者调用其他 SDK
    }
    return result;
}

static AppDelegate *appdelegate = nil;
//实现单例方法
+ (instancetype)shareAppDelegate{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appdelegate = [[AppDelegate alloc] init];
    });
    return appdelegate;
}


//百度地图相关
- (void)baiduMap{
    
    //启动百度_mapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    BOOL ret = [_mapManager start:@"VYNCtSOnxjs0Pg29vV2r1raSrEpxV2Gn" generalDelegate:nil];
    
    if (!ret) {
        NSLog(@"地图打开失败");
    }else{
        NSLog(@"成功了");
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
