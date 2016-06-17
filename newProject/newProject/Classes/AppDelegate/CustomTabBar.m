//
//  CustomTabBar.m
//  Douban_pro
//
//  Created by 朱博文 on 16/6/1.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "CustomTabBar.h"


@implementation CustomTabBar

static CustomTabBar *customtabBar = nil;

+ (instancetype)shareCustomTabBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        customtabBar = [[CustomTabBar alloc] init];
    });
    return customtabBar;
}

//重写初始化方法,把sendBtn 加上去
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.sendBtn = [SendButton creatButton];
        [self addSubview:_sendBtn];
        
    }
    return self;
}

//重新给子视图布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //获取 tabber 的宽
    CGFloat barWidth = self.frame.size.width;
    //获取 tabber 的高
    CGFloat barHeight = self.frame.size.height;
    
    //确定按钮的frame
    CGFloat buttonY = 1;
    CGFloat buttonW = barWidth/ 5;
    CGFloat buttonH = barHeight;
    
    //按钮的索引
    NSInteger index = 0;
    
    self.sendBtn.frame = CGRectMake(barWidth / 2 - buttonW/2, -25 , buttonW, buttonW);
    
    for (UIView *view in self.subviews) {
        NSString *className = NSStringFromClass([view class]);
        //判断是否为"UITabBarButton",如果是的话,设定它的frame.
        if ([className isEqualToString:@"UITabBarButton"]) {
            CGFloat buttonX = index * buttonW;
            
            if (index >= 2) {
                buttonX = buttonW + buttonX;
            }
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            //确定第一个按钮之后,索引+1,继续确定第二个按钮的frame.
            index++;
        }
    }
}





@end
