//
//  ScrollDetailViewController.h
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SceneryModel.h"
@interface SceneryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
- (void)bindModel:(SceneryModel *)model;
@end
