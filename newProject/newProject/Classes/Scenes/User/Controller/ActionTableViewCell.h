//
//  ActionTableViewCell.h
//  UICollectionView
//
//  Created by 朱博文 on 16/6/14.
//  Copyright © 2016年 boon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *celljiaoImg;

@end
