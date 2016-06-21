//
//  RootViewController.m
//  喜闻乐见
//
//  Created by 朱博文 on 16/6/13.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "RootViewController.h"
#import "HostViewController.h"
#import "MapViewController.h"
#import "StoriesTableViewController.h"
#import "User1ViewController.h"
#import "CustomTabBar.h"
#import "UIImage+imageContentWithColor.h"

@interface RootViewController ()



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatChildViewControllers];
    [self setCustomTabBar];
    
    //设置主题颜色
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.935 green:1.000 blue:0.982 alpha:0.9]]];
}
- (void)addOneChildViewController:(UIViewController *)viewController NormalImage:(NSString *)normalImg SelectImage:(NSString *)selectImg{
    //给子视图控制器的TabBarItem 赋值
    UIImage *image1 = [UIImage imageNamed:normalImg];
    //设置渲染模式
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = image1;
    
    UIImage *image = [UIImage imageNamed:selectImg];
    //设置渲染模式
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    viewController.tabBarItem.selectedImage = image;
    //把子视图控制器添加上去
    [self addChildViewController:viewController];
}
- (void)creatChildViewControllers{
    //主页面
    HostViewController *activityVC = [[HostViewController alloc]initWithNibName:@"HostViewController" bundle:nil];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:activityVC] NormalImage:@"主页(4)" SelectImage:@"主页"];
    
    //地图
    MapViewController *messageVC = [[MapViewController alloc]init];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:messageVC] NormalImage:@"地图 (3)" SelectImage:@"地图"];
    
    //见闻
    StoriesTableViewController *searchVC = [[StoriesTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:searchVC] NormalImage:@"发布" SelectImage:@"发布 (1)"];
    
    //个人
    User1ViewController *userVC = [[User1ViewController alloc]init];
    [self addOneChildViewController:[[UINavigationController alloc]initWithRootViewController:userVC] NormalImage:@"个人 (2)" SelectImage:@"个人 (1)"];
}
//获取自定义tabBar
- (void)setCustomTabBar{
    [self setValue:[CustomTabBar shareCustomTabBar] forKey:@"tabBar"];
    [[CustomTabBar shareCustomTabBar].sendBtn addTarget:self action:@selector(touchAC) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchAC{
    NSLog(@"999");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
