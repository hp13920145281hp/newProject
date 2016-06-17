//
//  StoriesViewCell.h
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoriesModel.h"

@interface StoriesViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *view;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *userName;


//动态显示
@property (weak, nonatomic) IBOutlet UILabel *dynamicLabel;


//第一张图片
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;

//第二张图片
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;

//第三张图片
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;


//第四张图片
@property (weak, nonatomic) IBOutlet UIImageView *fourthImg;


@property (strong, nonatomic)StoriesModel *model;

@end
