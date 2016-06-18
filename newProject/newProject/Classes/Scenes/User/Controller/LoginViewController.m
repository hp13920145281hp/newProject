//
//  LoginViewController.m
//  UICollectionView
//
//  Created by 朱博文 on 16/6/14.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "LoginViewController.h"
#import "registViewController.h"
#import <AFNetworking.h>
#import "User.h"
#import <Wilddog.h>
@interface LoginViewController ()
//登录账号
@property (weak, nonatomic) IBOutlet UITextField *loginNameLabel;
//登录密码
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordLabel;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//登录按钮事件
- (IBAction)loginAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    //添加弹窗提示
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if ([alert.message isEqualToString:@"登录成功"]) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [alert addAction:action];
    
    //判断输入框是否为空
    if ([_loginNameLabel.text isEqualToString:@""] || [_loginPasswordLabel.text isEqualToString:@""]) {
        alert.message = @"用户名或者密码不能为空";
        [weakSelf presentViewController:alert animated:YES completion:nil];
    }else{
        Wilddog *myRootRef  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com"];
        [myRootRef authUser:_loginNameLabel.text password:_loginPasswordLabel.text
        withCompletionBlock:^(NSError *error, WAuthData *authData) {
            
      if (error) {
          // 登录时发生错误
          NSLog(@"登录失败%@",error);
      } else {
          // 登录成功，返回authData数据
          NSLog(@"登录成功");
          [self.navigationController popViewControllerAnimated:YES];
      }
  }];
    }
}
//跳转至注册页面
- (IBAction)registerAction:(UIButton *)sender {
    registViewController *registVC = [[registViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
