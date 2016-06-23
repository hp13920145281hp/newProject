//
//  ScrollDetailViewController.m
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "ScrollDetailViewController.h"

@interface ScrollDetailViewController ()

@end

@implementation ScrollDetailViewController

#pragma mark ----懒加载
- (UIWebView *)webView
{
    if (!_webView)
    {
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //一个布尔值，它决定了是否用户触发的事件被该视图对象忽略和把该视图对象从事件响应队列中移除,为YES时，则事件可以正常的传递给该视图对象。
    self.webView.userInteractionEnabled = YES;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
