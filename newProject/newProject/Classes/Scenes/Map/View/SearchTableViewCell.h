//
//  SearchTableViewCell.h
//  TravelDiary
//
//  Created by YDB MAC on 15/11/14.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
- (IBAction)buttonClick:(UIButton *)sender;
@property(nonatomic, strong)NSMutableArray *array;
//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;


@property (nonatomic,copy) void (^block) (NSString *str);

@end
