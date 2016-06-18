//
//  StoriesModel.m
//  四处逛逛
//
//  Created by hupan on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "StoriesModel.h"

@implementation StoriesModel


- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"headerImg"]) {
        NSData *data = [[NSData alloc] initWithBase64Encoding:value];
        _header = [UIImage imageWithData:data];
    }
    if ([key isEqualToString:@"imgs"]){
        _photoArr = [NSMutableArray array];
        for (int i = 0; i < [value count]; i++) {
            NSData *data1 = [[NSData alloc] initWithBase64Encoding:value[i]];
            UIImage *img = [UIImage imageWithData:data1];
            [_photoArr addObject:img];
        }
    }
}



@end
