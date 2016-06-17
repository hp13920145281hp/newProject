//
//  CityDetailViewController.m
//  TravelDiary
//
//  Created by lanou3g on 15/11/14.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "CityDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "CityDetail.h"
#import "CityDetailCell.h"
#import <UIImageView+WebCache.h>

const CGFloat topViewH = 350;

@interface CityDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *picURL;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *opendate;
@property (nonatomic, copy) NSString *intro;

@property (nonatomic, strong) UIImageView *topView;
@end

@implementation CityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self loadData];
    [self loadTableView];
    
    
    
}

- (void)loadTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CityDetailCell" bundle:nil] forCellReuseIdentifier:@"CityDetailCell"];
   //设置可以拉去滚动的区域
  self.tableView.contentInset = UIEdgeInsetsMake(topViewH*0.8, 0, 0, 0);
    
    UIImageView *topView = [[UIImageView alloc]init];
    
    topView.frame = CGRectMake(0, -300, self.view.frame.size.width, topViewH);
    
    [topView sd_setImageWithURL:[NSURL URLWithString:self.picURL] placeholderImage:nil];
    
    [self.tableView insertSubview:topView atIndex:0];
    self.topView = topView;
    
}
- (void)loadData{
 
    //1.创建请求管理对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:self.urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dic = dict[@"content"];
            self.picURL = dic[@"coverPic"];
            self.address = dic[@"address"];
            self.opendate = dic[@"openTime"];
            self.intro = dic[@"intro"];
            
        }
        [self loadTableView];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
#pragma mark tableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0 || indexPath.row == 1) {
        return 70;
    }else{
        return 70+[self stringHeighWithString:self.intro fontSize:18 contentSize:CGSizeMake(self.view.frame.size.width , 1000)];
    }
}
- (CGFloat)stringHeighWithString:(NSString *)str fontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    //第一个参数，代表最大的范围
    //第二个参数，代表的是 是否考虑字体，是否考虑字号
    //第三个参数，代表的是使用什么字体什么字号
    //第四个参数，用不到，所以基本上是nil
    CGRect stringRect = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    return stringRect.size.height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityDetailCell *cell= [tableView dequeueReusableCellWithIdentifier:@"CityDetailCell"];
    
    
    if (indexPath.row == 0) {
        
        cell.titleLabel.text = @"地址";
        cell.iconImageView.image = [UIImage imageNamed:@"iconfont-dingwei"];
        cell.detailLabel.text = self.address;
        cell.jiantou.image = [UIImage imageNamed:@"iconfont-sanjiaoyou"];
        
        
        
    }
    if (indexPath.row == 1) {
        cell.titleLabel.text = @"开放时间";
        cell.iconImageView.image = [UIImage imageNamed:@"iconfont-shijian"];
        cell.detailLabel.text = self.opendate;
        
        
    }
    if (indexPath.row == 2) {
        cell.titleLabel.text = @"详情";
        cell.iconImageView.image = [UIImage imageNamed:@"iconfont-fuwuxiangqing"];
        cell.detailLabel.numberOfLines = 0;
        cell.detailLabel.font = [UIFont systemFontOfSize:18.0];
        cell.detailLabel.text = self.intro;
        
        
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
