//
//  ScrollModel.h
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollModel : NSObject
//标题
@property (nonatomic, copy)NSString *title;
//webView
@property (nonatomic, copy)NSString *url;
//图片url
@property (nonatomic, copy)NSString *photo;
@end
