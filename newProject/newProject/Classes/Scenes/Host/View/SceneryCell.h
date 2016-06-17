//
//  SceneryCell.h
//  TravelDiary
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneryModel.h"
@interface SceneryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (void)bindModel:(SceneryModel *)model;
@end
