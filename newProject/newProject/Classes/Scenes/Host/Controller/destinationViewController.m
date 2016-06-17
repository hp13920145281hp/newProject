//
//  destinationViewController.m
//  四处逛逛
//
//  Created by SuperCodi on 16/6/16.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "destinationViewController.h"
#import "CityNAmeModel.h"
#import "CityNameCell.h"
#import "CityHotSeneryTableViewCell.h"
#import "CityHotSeneryModel.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking.h>
#import "CityDetailViewController.h"

#define kCityNameUrl @"http://apiphp.yaochufa.com/portal/dest/provinceList?version=4.4.0&imei=00000000-586f-a266-a828-d02c62cce401&system=ios&deviceToken=00000000-586f-a266-a828-d02c62cce401&regId=040f3d14659&channel=yingyongbao%20"//城市请求

#define kCityHotUrl @"http://apiphp.yaochufa.com/portal/dest/scenicCity?areaCode=%d&system=ios&listType=province&channel=AppStore&version=4.4.0&imei=853B8C69-003C-488D-BFF8-1A21640D8184%%20"

#define kCityDetailUrl @"http://apiphp.yaochufa.com/portal/scenic/ScenicDetail430?version=4.4.0&id=%@&system=ios&channel=AppStore&imei=853B8C69-003C-488D-BFF8-1A21640D8184"

@interface destinationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property (weak, nonatomic) IBOutlet UILabel *cityLable;
@property (weak, nonatomic) IBOutlet UITableView *imageTableView;

//放城市名字的数组
@property (nonatomic, strong)NSMutableArray *cityNameArray;
//放热门景区图片的数组
@property (nonatomic, strong)NSMutableArray *cityHotSecenaryArray;

@end

static NSString *indexPathRow = @"0";

@implementation destinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"目的地";
    
    //显示城市名称
    [self cityName];
    
    
    
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [self.cityTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark ----------------------城市热门景区显示
-(void)hotSecenary:(NSString *)areaCode{
    _imageTableView.delegate = self;
    _imageTableView.dataSource = self;
    _cityHotSecenaryArray = [NSMutableArray array];
    [self.imageTableView registerNib:[UINib nibWithNibName:@"CityHotSeneryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    //获取网络数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://apiphp.yaochufa.com/portal/dest/scenicCity?areaCode=%@&system=ios&listType=province&channel=AppStore&version=4.4.0&imei=853B8C69-003C-488D-BFF8-1A21640D8184%%20", areaCode]];
    NSLog(@"%@", url);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dict = dic[@"content"];
    NSArray *array = dict[@"hotScenic"];
    for (NSDictionary *dict1 in array) {
        CityHotSeneryModel *model = [CityHotSeneryModel new];
        [model setValuesForKeysWithDictionary:dict1];
        [self.cityHotSecenaryArray addObject:model];
    }
    
}
#pragma mark ----------------------城市名字显示
-(void)cityName{
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    [self.cityTableView registerNib:[UINib nibWithNibName:@"CityNameCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _cityNameArray = [NSMutableArray array];
    //获取网络数据
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:kCityNameUrl]] options:NSJSONReadingAllowFragments error:nil];
    NSArray *array = dic[@"content"];
    for (NSDictionary *dict in array) {
        CityNAmeModel *model = [CityNAmeModel new];
        [model setValuesForKeysWithDictionary:dict];
        [self.cityNameArray addObject:model];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.cityTableView) {
    return self.cityNameArray.count;
    }else{
    return self.cityHotSecenaryArray.count;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cityTableView) {
    return 50;
    }else{
    return 230;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.cityTableView) {
        CityNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (indexPath.row == 0) {
            cell.selected = YES;
            CityNAmeModel *city = self.cityNameArray[indexPath.row];
            indexPathRow = city.areaCode;
            self.cityLable.text = [NSString stringWithFormat:@"  %@景点",city.name];
            //点击刷新出相应的景点
            [self hotSecenary:city.areaCode];
        }
        CityNAmeModel *model = self.cityNameArray[indexPath.row];
        cell.cityName.text = model.name;
        cell.cityName.textColor = [UIColor colorWithRed:0.2784 green:0.5137 blue:0.7765 alpha:1.0];
        return cell;
    }else{
        CityHotSeneryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        CityHotSeneryModel *model = self.cityHotSecenaryArray[indexPath.row];
        cell.nameLable.text = model.scenicName;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.mudiPic] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
        return cell;
        }
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cityTableView) {
        CityNAmeModel *city = self.cityNameArray[indexPath.row];
        indexPathRow = city.areaCode;
        self.cityLable.text = [NSString stringWithFormat:@"  %@景点",city.name];
        //点击刷新出相应的景点
        [self hotSecenary:city.areaCode];
        [self.imageTableView reloadData];
    }else{
        CityDetailViewController *cityDetailVC = [[CityDetailViewController alloc]init];
        CityHotSeneryModel *model = self.cityHotSecenaryArray[indexPath.row];
        
        //将第二页的接口网址传过去
        cityDetailVC.urlStr = [NSString stringWithFormat:kCityDetailUrl,model.scenicId];
        cityDetailVC.navigationItem.title = model.scenicName;
        
        [self.navigationController pushViewController:cityDetailVC animated:YES];
   }

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
