//
//  HomeCollectionViewCell.m
//  TravelDiary
//
//  Created by YDB MAC on 15/11/12.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()




@end
@implementation HomeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        _iconImage = [[UIImageView alloc]init];
        [self.contentView addSubview:_iconImage];
        [self.contentView addSubview:_titleLabel];
        
    }

    return self;
    

}


-(void)layoutSubviews{
    
    _iconImage.frame = CGRectMake(10,10, self.frame.size.width-20, self.frame.size.width-20);
    _iconImage.layer.masksToBounds = YES;
    _iconImage.layer.cornerRadius = 20;
    
    
    _titleLabel.frame = CGRectMake(CGRectGetMinX(_iconImage.frame), CGRectGetMaxY(_iconImage.frame), CGRectGetWidth(_iconImage.frame), 20);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    
    
    

   

}
@end
