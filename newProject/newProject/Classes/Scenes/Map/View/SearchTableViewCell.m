//
//  SearchTableViewCell.m
//  TravelDiary
//
//  Created by YDB MAC on 15/11/14.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "SearchTableViewCell.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "UserLocationManager.h"
@implementation SearchTableViewCell

- (void)awakeFromNib {
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    
}


-(void)setArray:(NSMutableArray *)array
{
    _array = array;
    
    for (int i =0; i<7; i++)
    {
        UIButton *btn = [self.contentView viewWithTag:(100+i)];
        if (i == 0) {
            NSArray *array = _array[i];
            
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn setBackgroundImage:[UIImage imageNamed:array[0]] forState:(UIControlStateNormal)];
            [btn setTitle:array[1] forState:UIControlStateNormal];
        }
        else{
            [btn setTitle:_array[i] forState:UIControlStateNormal];
            
        }
    }

}

- (IBAction)buttonClick:(UIButton *)sender {
    
    if (_block) {
        _block(sender.titleLabel.text);
    }
   

}
@end
