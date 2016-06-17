//
//  SearchViewController.m
//  TravelDiary
//
//  Created by YDB MAC on 15/11/14.
//  Copyright © 2015年 YDB MAC. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "LYYSearchBar.h"
#import "UserLocationManager.h"
#import "SearchListViewController.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property(nonatomic, strong)NSArray *searchArray;
@property(nonatomic, strong)NSArray *sonArray1;
@property(nonatomic, strong)NSArray *sonArray2;
@property(nonatomic, strong)NSArray *sonArray3;
@property(nonatomic, strong)NSArray *sonArray4;
@property(nonatomic, strong)NSArray *sonArray5;
@property(nonatomic, strong)NSArray *sonArray11;
@property(nonatomic, strong)NSArray *sonArray22;
@property(nonatomic, strong)NSArray *sonArray33;
@property(nonatomic, strong)NSArray *sonArray44;
@property(nonatomic, strong)NSArray *sonArray55;
//用户纬度
@property (nonatomic,assign) double userLatitude;

//用户经度
@property (nonatomic,assign) double userLongitude;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _titleStr;
    
    //中间按钮
    LYYSearchBar *searchBar = [LYYSearchBar searchBar];
    searchBar.delegate = self;
    searchBar.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入搜索内容"];
    //当点击UITextField的时候不要弹出键盘
//    searchBar.inputView = [[UIView alloc]initWithFrame:CGRectZero];
    //尺寸
    searchBar.frame = CGRectMake(0, 0, self.view.frame.size.width - 100, 30);
    //设置中间的标题内容
    self.navigationItem.titleView = searchBar;
    
    _sonArray11 = @[@"food.jpg",@"美食"];
    _sonArray22 = @[@"hotel.jpg",@"酒店"];
    _sonArray33 = @[@"relax.jpg",@"休闲"];
    _sonArray44 = @[@"traffic.jpg",@"交通"];
    _sonArray55 = @[@"life",@"生活"];

    
     _sonArray1 = @[_sonArray11,@"中餐",@"小吃快餐",@"川菜",@"西餐",@"火锅",@"肯德基"];
     _sonArray2 = @[_sonArray22,@"快捷酒店",@"星级酒店",@"青年旅社",@"旅馆",@"特价酒店",@"招待所"];
     _sonArray3 = @[_sonArray33,@"电影院",@"KTV",@"咖啡厅",@"商场",@"美景",@"洗浴"];
     _sonArray4 = @[_sonArray44,@"公交站",@"加油站",@"火车票代售点",@"长途汽车站",@"停车场",@"火车站"];
     _sonArray5 = @[_sonArray55,@"超市",@"药店",@"ATM",@"银行",@"医院",@"厕所"];
    _searchArray = @[_sonArray1,_sonArray2,_sonArray3,_sonArray4,_sonArray5];

    [self createTableView];
    
}
-(void)createTableView{
    
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    
    [_searchTableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchcell"];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
   
    SearchListViewController *SV = [[SearchListViewController alloc]init];
    SV.str = textField.text;
    [self.navigationController showViewController:SV sender:self];
    
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _searchArray.count;


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 148;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchcell" forIndexPath:indexPath];

        
    cell.array = _searchArray[indexPath.row];
    cell.block = ^ (NSString *str)
    {
        SearchListViewController *vc  = [[SearchListViewController alloc] init];
        vc.str = str;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    return cell;


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
