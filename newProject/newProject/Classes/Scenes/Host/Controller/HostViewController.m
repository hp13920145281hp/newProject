//
//  HostViewController.m
//  四处逛逛
//
//  Created by SuperCodi on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "HostViewController.h"
#import "ScrollModel.h"
#import "SceneryModel.h"
#import "UIImageView+WebCache.h"
#import "SceneryCell.h"
#import "ScrollDetailViewController.h"
#import "feedbackViewController.h"
#import "AddressViewController.h"
#import "StoriesTableViewController.h"
#import "destinationViewController.h"
#import "SceneryDetailViewController.h"
#import <AFNetworking.h>

//滚动图
#define scrollURL @"http://open.qyer.com/qyer/recommands/entry?app_installtime=1435837675&client_id=qyer_ios&client_secret=cd254439208ab658ddf9&count=20&page=1&track_app_channel=App%2520Store&track_app_version=6.3&track_device_info=iPhone7%2C2&track_deviceid=94600906-5BB7-43E7-9E16-C479A03EE469&track_os=ios%25208.3&v=1"
#define kFJUrl @"http://api.photochina.china.cn/phone/category_4_%d_10.html"//风景风光
#define kFJDetailUrl @"http://api.photochina.china.cn/phone/articles_4_%@.html"

#define kGJUrl @"http://api.photochina.china.cn/phone/category_6_%d_10.html"//古风古景
#define kGJDetailUrl @"http://api.photochina.china.cn/phone/articles_6_%@.html"

@interface HostViewController ()<UISearchBarDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
//下面(风景风光/古风古景)tableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

//风景数据数组
@property (nonatomic, strong)NSMutableArray *sceneryArray;

//放标题
@property (nonatomic, strong)NSMutableArray *scrollTitleArr;
//放webView
@property (nonatomic, strong)NSMutableArray *webUrlArr;
//放图片url
@property (nonatomic, strong)NSMutableArray *photoUrlArr;

@property (nonatomic, assign)int currentPage1,currentPage2;

@property (nonatomic, strong)NSArray *arr;
@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏搜索框和按钮
    [self navgationAction];

    //滚动视图数据添加
    [self scrollData];
    //pageCOn
    [self page];
   
    [self loadScenData];
    
}

#pragma mark ----------------------轮播图数据
-(void)scrollData{
    //初始化数组
    self.scrollTitleArr = [NSMutableArray array];
    self.webUrlArr = [NSMutableArray array];
    self.photoUrlArr = [NSMutableArray array];
    
    NSURL *scrollUrl = [NSURL URLWithString:scrollURL];
    //创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:scrollUrl];
    //发起请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
       //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSDictionary *dict = dic[@"data"];
        NSMutableArray *subject = dict[@"subject"];
        for (NSDictionary *dict1 in subject) {
            [self.photoUrlArr addObject:dict1[@"photo"]];
            [self.scrollTitleArr addObject:dict1[@"title"]];
            ScrollModel *model = [[ScrollModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            [self.webUrlArr addObject:model];
        }
#pragma mark ---------- 给图片添加轻拍手势
        //获取网络图片,添加到视图
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.photoUrlArr[0]]];
        //用户交互
        self.imageView.userInteractionEnabled = YES;
        // 创建一个轻拍手势 同时绑定了一个事件
        UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollAction)];
        // 设置轻拍次数
        aTapGR.numberOfTapsRequired = 1;
        // 添加手势
        [self.imageView addGestureRecognizer:aTapGR];
        
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.photoUrlArr[1]]];
        //用户交互
        self.imageView2.userInteractionEnabled = YES;
        // 创建一个轻拍手势 同时绑定了一个事件
        UITapGestureRecognizer *aTapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollAction1)];
        // 设置轻拍次数
        aTapGR1.numberOfTapsRequired = 1;
        // 添加手势
        [self.imageView2 addGestureRecognizer:aTapGR1];
        
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:self.photoUrlArr[2]]];
//        NSLog(@"%@",self.photoUrlArr);
        //用户交互
        self.imageView3.userInteractionEnabled = YES;
        // 创建一个轻拍手势 同时绑定了一个事件
        UITapGestureRecognizer *aTapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollAction2)];
        // 设置轻拍次数
        aTapGR2.numberOfTapsRequired = 1;
        // 添加手势
        [self.imageView3 addGestureRecognizer:aTapGR2];
    }];
}
//第一张图的
-(void)scrollAction{
    ScrollDetailViewController *scrollDetailVC = [[ScrollDetailViewController alloc]init];
        ScrollModel *model = self.webUrlArr[0];
        scrollDetailVC.url = model.url;
  [self.navigationController pushViewController:scrollDetailVC animated:YES];
}
//第二张图的
-(void)scrollAction1{
    ScrollDetailViewController *scrollDetailVC = [[ScrollDetailViewController alloc]init];
    ScrollModel *model = self.webUrlArr[1];
    scrollDetailVC.url = model.url;
    [self.navigationController pushViewController:scrollDetailVC animated:YES];
}
//第三张图的
-(void)scrollAction2{
    ScrollDetailViewController *scrollDetailVC = [[ScrollDetailViewController alloc]init];
    ScrollModel *model = self.webUrlArr[2];
    scrollDetailVC.url = model.url;
    [self.navigationController pushViewController:scrollDetailVC animated:YES];
}
#pragma mark ------------------------------请求风景数据
-(void)loadScenData{
    self.sceneryArray = [NSMutableArray array];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.currentPage1 = 0;
    self.currentPage2 = 0;
    if (_seg.selectedSegmentIndex == 0) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:kFJUrl,++_currentPage1]]] options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"items"];
        
        for (NSDictionary *dict in array) {
            
            SceneryModel *model = [SceneryModel new];
            
            [model setValuesForKeysWithDictionary:dict];
            NSDictionary *dictImg =dict[@"img"];
            model.picUrl = dictImg[@"picUrl"];
            [_sceneryArray addObject: model];
            [_tableView reloadData];
        }
    }else{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:kGJUrl,++_currentPage1]]] options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"items"];
        
        for (NSDictionary *dict in array) {
            
            SceneryModel *model = [SceneryModel new];
            
            [model setValuesForKeysWithDictionary:dict];
            NSDictionary *dictImg =dict[@"img"];
            model.picUrl = dictImg[@"picUrl"];
            [_sceneryArray addObject: model];
            [_tableView reloadData];
        }
    }
}
//风景风光和古风古景的切换实现
- (IBAction)segmentedAction:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0) {
        [self loadScenData];
    }else{
        [self loadScenData];
    }
}

//pageControl
-(void)page{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(rotate) userInfo:nil repeats:YES];
}

-(void)rotate{
    if (_scrollView.contentOffset.x < self.scrollView.frame.size.width * 2) {
        _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + self.scrollView.frame.size.width, 0);
    }else{
        _scrollView.contentOffset = CGPointMake(0, 0);
    }
    _pageControl.currentPage = _scrollView.contentOffset.x / self.scrollView.frame.size.width;
}

//tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sceneryArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SceneryCell";
    SceneryCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"SceneryCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    SceneryModel *model = self.sceneryArray[indexPath.row];
    cell.selectedBackgroundView = [[UIView alloc]init];
    [cell bindModel:model];
    return cell;
}
#pragma mark ----------------------点击进入详情页,并且将详情页接口传过去
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SceneryDetailViewController *scenceryDetailVC = [[SceneryDetailViewController alloc]init];
    SceneryModel *model = self.sceneryArray[indexPath.row];
    if (_seg.selectedSegmentIndex == 0) {
        if (self.sceneryArray.count == 0) {
            return;
        }
        //拼接详情页面的接口地址
        scenceryDetailVC.detailUrl = [NSString stringWithFormat:kFJDetailUrl,model.id];
        NSLog(@"%@",model.id);
    }else{
        scenceryDetailVC.detailUrl = [NSString stringWithFormat:kFJDetailUrl,model.id];
    }
    [self.navigationController pushViewController:scenceryDetailVC animated:YES];
}

#pragma mark =-----------------------------导航栏搜索框和按钮
-(void)navgationAction{
    //添加导航栏按钮
    UIButton *titleButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [titleButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    //位置和尺寸
    titleButton.frame = CGRectMake(0, 0,100, 40);
    [titleButton setTitle:@"全国" forState:UIControlStateNormal];
    //图标
    [titleButton setImage:[UIImage imageNamed:@"全国按钮"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:titleButton];
    //添加搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    searchBar.placeholder = @"请搜索您喜欢的旅游景点";
    searchBar.frame = CGRectMake(0, 0, 250, 30);
    [titleView addSubview:searchBar];
    self.navigationItem.titleView = titleView;
}
//目的地
- (IBAction)destinationAction:(UIButton *)sender {
    destinationViewController *destinationVC = [[destinationViewController alloc]init];
    [self.navigationController pushViewController:destinationVC animated:YES];
}
//发现
- (IBAction)findAction:(UIButton *)sender {
    StoriesTableViewController *storiesVC = [[StoriesTableViewController alloc]init];
    [self.navigationController pushViewController:storiesVC animated:YES];
}
//反馈
- (IBAction)feedback:(UIButton *)sender {
    feedbackViewController *feedbackVC = [[feedbackViewController alloc]init];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}
//位置
- (IBAction)locationAction:(UIButton *)sender {
    AddressViewController *addressVC =[[AddressViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
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
