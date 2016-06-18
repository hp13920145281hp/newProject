//
//  CityListTableViewController.h
//  newProject
//
//  Created by SuperCodi on 16/6/18.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MyBlock)(NSString *string);

@interface CityListTableViewController : UITableViewController


//城市首字母
@property (nonatomic, strong)NSMutableArray *keyArray;
//城市字典
@property (nonatomic, strong)NSMutableDictionary *citieDictionary;
//城市数据
@property (nonatomic, strong)NSMutableArray *cityDateArray;

@property (nonatomic, copy)MyBlock block;

@end
