//
//  SearchBarTableViewController.m
//  newProject
//
//  Created by SuperCodi on 16/6/20.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "SearchBarTableViewController.h"
#import "CityNAmeModel.h"
#import "CityHotSeneryTableViewCell.h"
#import "CityHotSeneryModel.h"
#import "UIImageView+WebCache.h"
#import "CityDetailViewController.h"

#define kCityNameUrl @"http://apiphp.yaochufa.com/portal/dest/provinceList?version=4.4.0&imei=00000000-586f-a266-a828-d02c62cce401&system=ios&deviceToken=00000000-586f-a266-a828-d02c62cce401&regId=040f3d14659&channel=yingyongbao%20"//城市请求

#define kCityHotUrl @"http://apiphp.yaochufa.com/portal/dest/scenicCity?areaCode=%@&system=ios&listType=province&channel=AppStore&version=4.4.0&imei=853B8C69-003C-488D-BFF8-1A21640D8184%%20"

#define kCityDetailUrl @"http://apiphp.yaochufa.com/portal/scenic/ScenicDetail430?version=4.4.0&id=%@&system=ios&channel=AppStore&imei=853B8C69-003C-488D-BFF8-1A21640D8184"

@interface SearchBarTableViewController ()<UISearchBarDelegate>

//放城市名字的数组
@property (nonatomic, strong)NSMutableArray *cityNameArray;
//放热门景区图片的数组
@property (nonatomic, strong)NSMutableArray *cityHotSecenaryArray;

//搜索的结果存放的数组
@property (retain ,nonatomic)NSMutableArray*searchResult;
//搜索控制器控件
@property (retain ,nonatomic)UISearchController *searchController;
////用来存放所有景色
//@property (strong ,nonatomic)NSMutableArray *allSecenaryArray;

@property (strong, nonatomic)UISearchBar *searchBar;

@end

static NSString *indexPathRow = @"0";

@implementation SearchBarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//显示城市名称
    [self cityName];
    //热门城市
    [self hotSecenary];

    //添加搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 35)];
    self.searchBar = [[UISearchBar alloc] init];
    //当点击UITextField的时候不要弹出键盘
    //    searchBar.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"请搜索您喜欢的旅游景点";
    _searchBar.frame = CGRectMake(0, 0, 200, 30);
    [titleView addSubview:_searchBar];
    self.navigationItem.titleView = titleView;
}
//SearchBar的代理方法
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)search
{
    [self.searchResult removeAllObjects];
    //谓词NSPredicate(用于判断, YES留下,NO 去掉)
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"self.scenicName contains[c] %@",self.searchBar.text];
    //将筛选的结果存放到搜索结果数组中
    _searchResult = [self.cityHotSecenaryArray filteredArrayUsingPredicate:searchPredicate].mutableCopy;
    //刷新表格
    [self.tableView reloadData];
}
#pragma mark ----------------------城市名字显示
-(void)cityName{
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
#pragma mark ----------------------城市热门景区显示
-(void)hotSecenary{
    _cityHotSecenaryArray = [NSMutableArray array];
    [self.tableView registerNib:[UINib nibWithNibName:@"CityHotSeneryTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    //获取网络数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kCityHotUrl,indexPathRow]];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *dict = dic[@"content"];
    NSArray *array = dict[@"hotScenic"];
    for (NSDictionary *dict1 in array) {
        CityHotSeneryModel *model = [CityHotSeneryModel new];
        [model setValuesForKeysWithDictionary:dict1];
        [self.cityHotSecenaryArray addObject:model];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.searchResult.count > 0 ? 1 : _cityNameArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResult.count > 0 ? self.searchResult.count:self.cityHotSecenaryArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityHotSeneryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
if (_searchResult == nil) {
        CityHotSeneryModel *model = self.cityHotSecenaryArray[indexPath.row];
        cell.nameLable.text = model.scenicName;
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.mudiPic] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    return cell;
}
    CityHotSeneryModel *model = self.searchResult[indexPath.row];
    cell.nameLable.text = model.scenicName;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.mudiPic] placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        CityDetailViewController *cityDetailVC = [[CityDetailViewController alloc]init];
        CityHotSeneryModel *model = self.cityHotSecenaryArray[indexPath.row];
        
        //将第二页的接口网址传过去
        cityDetailVC.urlStr = [NSString stringWithFormat:kCityDetailUrl,model.scenicId];
        cityDetailVC.navigationItem.title = model.scenicName;
        [self.navigationController pushViewController:cityDetailVC animated:YES];
    }

@end
