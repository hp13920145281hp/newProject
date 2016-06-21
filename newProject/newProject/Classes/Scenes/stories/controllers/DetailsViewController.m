//
//  DetailsViewController.m
//  newProject
//
//  Created by hupan on 16/6/20.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()<UIScrollViewDelegate>


//头像
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;


//用户名
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;


//动态详情
@property (weak, nonatomic) IBOutlet UILabel *storiesLabel;

//添加好友按钮
@property (weak, nonatomic) IBOutlet UIButton *addFriendsBtn;


@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pageControl;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.headerImg.image = self.model.header;
    self.NameLabel.text = self.model.userName;
    self.storiesLabel.text = self.model.text;
    self.headerImg.layer.cornerRadius = 60;
    self.headerImg.layer.masksToBounds = YES;
    //设置轮播图
    [self setScrollView];
    //设置添加好友按钮
    [self setAddBtn];
}

//轮播图和分页
- (void)setScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, 414, 300)];
    _scrollView.contentSize = CGSizeMake(414 * _model.photoArr.count, 300);
    _scrollView.pagingEnabled = YES;
    for (int i = 0; i < _model.photoArr.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:_model.photoArr[i]];
        imgView.frame = CGRectMake(414 * i, 0, 414, 300);
        [_scrollView addSubview:imgView];
    }
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(150, 520, 100, 20)];
    _pageControl.numberOfPages = _model.photoArr.count;
    [self.view addSubview:_pageControl];
}


//滑动轮播图
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = _scrollView.contentOffset.x / 414;
}

//设置添加好友按钮
- (void)setAddBtn{
    
    if ([_model.userName isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"userName"]]) {
        [self.addFriendsBtn removeFromSuperview];
    }
}

//添加好友事件
- (IBAction)addFriendsAC:(UIButton *)sender {

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
