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
    self.userName.text = model.name;
    self.dynamicLabel.text = model.text;
    switch (model.photoArr.count) {
        case 1:
            self.firstImg = model.photoArr[0];
            break;
        case 2:
            self.firstImg = model.photoArr[0];
            self.secondImg = model.photoArr[1];
            break;
        case 3:
            self.firstImg = model.photoArr[0];
            self.secondImg = model.photoArr[1];
            self.thirdImg = model.photoArr[2];
            break;
        case 4:
            self.firstImg = model.photoArr[0];
            self.secondImg = model.photoArr[1];
            self.thirdImg = model.photoArr[2];
            self.fourthImg = model.photoArr[3];
            break;
        default:
            break;
    }

}

- (void)layoutSubviews{
    _view.layer.cornerRadius = 5;
    _view.layer.masksToBounds = YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
