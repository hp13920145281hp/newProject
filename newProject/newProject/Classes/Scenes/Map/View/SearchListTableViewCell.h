//
//  SearchListTableViewCell.h
//  TravelDiary
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface SearchListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property(nonatomic, strong)BMKPoiInfo *model;
@end
