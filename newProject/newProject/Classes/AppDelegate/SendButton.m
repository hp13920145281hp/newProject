
//
//  SendButton.m
//  Douban_pro
//
//  Created by 朱博文 on 16/6/1.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "SendButton.h"

@implementation SendButton
//创建按钮的类方法
+(instancetype)creatButton{
    SendButton *button = [SendButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setImage:[UIImage imageNamed:@"拍照按钮 (2)"]  forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"拍照按钮 (1)"] forState:UIControlStateHighlighted];
    return button;
}
@end
