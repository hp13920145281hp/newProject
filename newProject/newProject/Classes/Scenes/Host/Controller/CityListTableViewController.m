//
//  CityListTableViewController.m
//  newProject
//
//  Created by SuperCodi on 16/6/18.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "CityListTableViewController.h"

@interface CityListTableViewController ()

@end

@implementation CityListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getCityData];
  
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

//解析plist文件,得到城市数据
-(void)getCityData{
    self.cityDateArray = [NSMutableArray array];
    self.citieDictionary = [NSMutableDictionary dictionary];
    self.keyArray = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    self.citieDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //获取所有的key值  并从A到Z排列 存入数组
    [self.keyArray addObjectsFromArray:[[self.citieDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//每个分区的标题
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0;
}
//返回头标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.keyArray[section];
}
//添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keyArray;
}
//多少个分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keyArray.count;
}
//每个分区多少个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = [self.keyArray objectAtIndex:section];
    NSArray *citySectionArray = [_citieDictionary objectForKey:key];
    return citySectionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //给cell赋值
    NSString *key = [self.keyArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [[self.citieDictionary objectForKey:key] objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self.keyArray objectAtIndex:indexPath.section];
    NSString *str = [[_citieDictionary objectForKey:key] objectAtIndex:indexPath.row];
    //选中的城市用block传值传回去
    self.block(str);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
