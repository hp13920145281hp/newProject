//
//  ScrollDetailViewController.h
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollDetailViewController : UIViewController
@property (nonatomic, copy)NSString *url;
//UIWebView用于在App中嵌入网页内容
@property (nonatomic, strong)UIWebView *webView;
@end
