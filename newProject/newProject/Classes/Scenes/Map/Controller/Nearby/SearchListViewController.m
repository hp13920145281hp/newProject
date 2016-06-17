//
//  SearchListViewController.m
//  TravelDiary
//
//  Created by lanou3g on 15/11/26.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "SearchListViewController.h"
#import "SearchListTableViewCell.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "UserLocationManager.h"
@interface SearchListViewController ()<UITableViewDelegate, UITableViewDataSource, BMKPoiSearchDelegate>{

       BMKPoiSearch* _poisearch;
       int curPage;
    CLLocationCoordinate2D location;

}
@property (weak, nonatomic) IBOutlet UITableView *SearchTabelView;

@property(nonatomic, strong)NSArray *listArray;

@property (nonatomic, strong) BMKNearbySearchOption *nearBySearchOption;

@property (nonatomic, assign) double userLatitude;

@property (nonatomic, assign) double userLongitude;

@end

@implementation SearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SearchTabelView.delegate = self;
    self.SearchTabelView.dataSource = self;
    
    [self.SearchTabelView registerNib:[UINib nibWithNibName:@"SearchListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchListTableViewCell"];
    
    
    _poisearch = [[BMKPoiSearch alloc]init];
    _poisearch.delegate = self;

    
    [self createView];
    
}
-(void)createView{
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 50;
    citySearchOption.city= @"北京";
    citySearchOption.keyword = _str;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
//                _nextPageButton.enabled = true;
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        //      _nextPageButton.enabled = false;
        NSLog(@"城市内检索发送失败");
    }
    

}


#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{    _listArray = [NSArray array];
    
    _listArray = result.poiInfoList;
  
    [self.SearchTabelView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _listArray.count;


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchListTableViewCell" forIndexPath:indexPath];
    
    cell.model = _listArray[indexPath.row];
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;


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
