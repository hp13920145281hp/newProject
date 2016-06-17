//
//  SceneryCell.m
//  TravelDiary
//
//  Created by lanou3g on 15/11/13.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "SceneryCell.h"
#import <UIImageView+WebCache.h>
@implementation SceneryCell

//给cell赋值
- (void)bindModel:(SceneryModel *)model{
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@",model.title];
    self.dataLabel.text = [NSString stringWithFormat:@"%@(发布)",model.date];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected s tate
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        
//        [self initLayout];
//    }
//    return self;
//}
//- (void)initLayout
//{
//    self.titleLabel.layer.borderWidth = 1;
//    self.titleLabel.layer.borderColor = [UIColor grayColor].CGColor;
//    NSLog(@"=====================%@",_model.picUrl);
//    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:_model.picUrl] placeholderImage:[UIImage imageNamed:@"packImageView"]];
//    
//    self.titleLabel.text = [NSString stringWithFormat:@"  %@",_model.title];
//    self.dataLabel.text = [NSString stringWithFormat:@"%@(发布)",_model.date];
//}

@end
