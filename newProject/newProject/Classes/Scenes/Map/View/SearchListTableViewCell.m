//
//  SearchListTableViewCell.m
//  TravelDiary
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "SearchListTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation SearchListTableViewCell

- (void)awakeFromNib {
    
  

}
-(void)setModel:(BMKPoiInfo *)model{

    _model = model;
    _nameLabel.text = _model.name;
    _addressLabel.text = _model.address;
    _phonLabel.text = _model.phone;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.map.baidu.com/panorama?width=512&height=256&location=%f,%f&fov=180&ak=iHGsgUK7quL7Qi3yhdMk095S",model.pt.longitude,model.pt.latitude]]placeholderImage:[UIImage imageNamed:@"zanwu"]];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
    
}

@end
