//
//  CustomTabBar.h
//  Douban_pro
//
//  Created by 朱博文 on 16/6/1.
//  Copyright © 2016年 boon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendButton.h"



@interface CustomTabBar : UITabBar

@property(nonatomic,strong)SendButton *sendBtn;

+ (instancetype)shareCustomTabBar;

@end
