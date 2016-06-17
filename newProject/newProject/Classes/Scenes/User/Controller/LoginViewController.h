//
//  LoginViewController.h
//  UICollectionView
//
//  Created by 朱博文 on 16/6/14.
//  Copyright © 2016年 boon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)(BOOL isLogin);

@interface LoginViewController : UIViewController
//判断是否已经登录
@property(copy,nonatomic)CompletionBlock block;

@end
