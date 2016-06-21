//
//  DynamicViewController.h
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicViewController : UIViewController

//传值
@property (copy, nonatomic)NSString *uesrName;
//用户头像
@property (copy, nonatomic)NSString *headerImg;

@property (copy, nonatomic)NSString *userID;

@end
