//
//  UIImage+imageContentWithColor.m
//  Douban_pro
//
//  Created by hupan on 16/6/1.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "UIImage+imageContentWithColor.h"

@implementation UIImage (imageContentWithColor)


+ (UIImage *)imageWithColor:(UIColor *)color{
    //给定绘图的大小
    CGRect rect = CGRectMake(0, 0, 1, 1);
    
    //绘图
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1);
    //设置填充颜色
    [color setFill];
    //设置填充范围
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
