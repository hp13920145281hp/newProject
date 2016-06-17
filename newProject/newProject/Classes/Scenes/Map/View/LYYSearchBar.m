//
//  LYYSearchBar.m
//  LYYWeibo
//
//  Created by lanou3g on 15/10/12.
//  Copyright (c) 2015年 李岩岩. All rights reserved.
//

#import "LYYSearchBar.h"
//#import "UIImage+LYY.h"

@interface LYYSearchBar ()

@end

@implementation LYYSearchBar

+ (instancetype)searchBar{
    return [[self alloc]init];
    
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
//        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background@2x"];
        //左边的放大镜图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //字体
        self.font = [UIFont systemFontOfSize:13];
        //右边的清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        //设置左边图标大小
        self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);
        //设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"搜索目的地（例如:北京）" attributes:attrs];
        
        //设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        //自动设置搜索的状态
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

@end
