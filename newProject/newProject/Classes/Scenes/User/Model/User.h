//
//  Person.h
//  四处逛逛
//
//  Created by 朱博文 on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(assign,nonatomic)NSInteger pid;
@property(copy,nonatomic)NSString *name;
@property(copy,nonatomic)NSString *password;
@property(copy,nonatomic)NSString *sign;
@property(copy,nonatomic)NSString *gender;
@end
