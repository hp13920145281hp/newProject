//
//  StoriesViewCell.m
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "StoriesViewCell.h"

@implementation StoriesViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(StoriesModel *)model{
    self.userName.text = model.userName;
    self.dynamicLabel.text = model.text;
    self.headerImg.image = model.header;
    switch (model.photoArr.count) {
        case 1:
            self.firstImg.image = model.photoArr[0];
            self.secondImg.image = nil;
            self.thirdImg.image = nil;
            self.fourthImg.image = nil;
            break;
        case 2:
            self.firstImg.image = model.photoArr[0];
            self.secondImg.image = model.photoArr[1];
            self.thirdImg.image = nil;
            self.fourthImg.image = nil;
            break;
            break;
        case 3:
            self.firstImg.image = model.photoArr[0];
            self.secondImg.image = model.photoArr[1];
            self.thirdImg.image = model.photoArr[2];
            self.fourthImg.image = nil;
            break;
        case 4:
            self.firstImg.image = model.photoArr[0];
            self.secondImg.image = model.photoArr[1];
            self.thirdImg.image = model.photoArr[2];
            self.fourthImg.image = model.photoArr[3];
            break;
        default:
            self.firstImg.image = nil ;
            self.secondImg.image = nil;
            self.thirdImg.image = nil;
            self.fourthImg.image = nil;
            break;
    }
}

- (void)layoutSubviews{
    _headerImg.layer.masksToBounds = YES;
    _headerImg.layer.cornerRadius = 5;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
