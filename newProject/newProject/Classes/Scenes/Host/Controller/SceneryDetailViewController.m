//
//  SceneryDetailViewController.m
//  四处逛逛
//
//  Created by SuperCodi on 16/6/16.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "SceneryDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import <UMSocial.h>
#import <UMSocialSnsService.h>
//appkey      5764fd72e0f55a2bf00030e5
@interface SceneryDetailViewController ()<UIScrollViewDelegate,UMSocialUIDelegate>

//中间的ScrollView
@property (nonatomic, strong)UIImageView *imageView;
//上面的imageView
@property (nonatomic, strong)UIScrollView *scrollView;
////景区详情的lable
//@property (nonatomic, strong)UILabel *titleLable;
//显示详情的lable
@property (nonatomic, strong)UILabel *detailLable;
//盛放图片的数组
@property (nonatomic, strong)NSMutableArray *imagearray;
//用来盛放详情的字符转
@property (nonatomic, strong)NSString *descriptions;
@end

@implementation SceneryDetailViewController

- (void)viewDidLoad {
    self.title = @"景点详情";
    
    //添加分享按钮
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStylePlain) target:self action:@selector(shareAC:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    
    //视图上先加上一个视图,防止加上的滚动视图上下摆动
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:view1];
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    [super viewDidLoad];
    [self requestData];
    [self descriptionsview];
}

//分享按钮点击事件
- (void)shareAC:(UIBarButtonItem *)shareBto{
    //如果分享需要回调,那么就必须把 delegate 设置为 self,并实现系统回调方法
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"5764fd72e0f55a2bf00030e5" shareText:@"" shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_descriptions]]] shareToSnsNames:@[UMShareToSina] delegate:self];
}

//添加lable,显示详情
-(void)descriptionsview{
    //详情
    UITextView *descriptionsview = [[UITextView alloc]initWithFrame:CGRectMake(15, self.view.frame.size.height/3+100, 384, 250)];
    //隐藏掉UITextView的滚动条
    descriptionsview.showsVerticalScrollIndicator = NO;
//    设置字体大小
    descriptionsview.font = [UIFont systemFontOfSize:17];
    descriptionsview.text = [NSString stringWithFormat:@"\t%@",_descriptions];
    [self.view addSubview:descriptionsview];
}
-(void)descriptionsLable{
    

}

//请求数据
-(void)requestData{
    self.imagearray = [NSMutableArray array];
    if (_detailUrl == nil) {
        return;
    }
    //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_detailUrl]] options:NSJSONReadingAllowFragments error:nil];
    _descriptions = dic[@"description"];
    NSArray *array = dic[@"img"];
    for (NSDictionary *dict1 in array) {
        [self.imagearray addObject:dict1[@"picUrl"]];
    }
    [self loadScrollView];
    [self loadImageView];
    [self loadImageButton];
}

//显示小图的imageView
-(void)loadImageView{
    for(int i = 0; i < self.imagearray.count; i++)
    {
        //初始化一个UIImageView
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imagearray[i]] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
        //把UIImageView添加到UIScrollView中 ，subView是一个数组，存的是View的所有子视图
        [self.scrollView addSubview:self.imageView];
    }
    //确保数据拿到之后 才去设置UIScrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame) * self.imagearray.count, self.view.frame.size.height/3);
}
//显示图片的ScrollView
-(void)loadScrollView{
    //初始化UIScrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3)];
    
    self.scrollView.backgroundColor = [UIColor cyanColor];
    //是否整屏翻动
    self.scrollView.pagingEnabled = YES;
    //边缘弹动效果
    self.scrollView.bounces = NO;
    //添加到self.view上
    [self.view addSubview:self.scrollView];
    //指定代理人
    self.scrollView.delegate = self;
}
//下方小图的点击事件
- (void)loadImageButton{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/3, self.view.frame.size.width, 100)];
    scroll.backgroundColor = [UIColor whiteColor];
//滚动图为横向显示
    [scroll setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:scroll];
    //设置按钮图片的宽
    CGFloat w = 100;
    for (int i = 0; i< self.imagearray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        button.frame = CGRectMake(i*w+10*i, 10, w, 80);
        
        [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        [button sd_setImageWithURL:self.imagearray[i] forState:(UIControlStateNormal)];
        [scroll addSubview:button];
        //给按钮添加点击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    scroll.contentSize = CGSizeMake((w+10)*self.imagearray.count+10, 80);
}

//点击小图,上方的大图跳转到相应的位置
- (void)buttonClick:(UIButton *)sender{
    [self.scrollView setContentOffset:CGPointMake(self.view.frame.size.width *[sender.titleLabel.text intValue], 0)];
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
