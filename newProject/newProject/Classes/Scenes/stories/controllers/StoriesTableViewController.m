//
//  StoriesTableViewController.m
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "StoriesTableViewController.h"
#import "StoriesViewCell.h"
#import "DynamicViewController.h"
#import "AppDelegate.h"
#import <FMDB.h>
#import "StoriesModel.h"

@interface StoriesTableViewController ()
//数据数组
@property (strong, nonatomic)NSMutableArray *dataArr;

@end

@implementation StoriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏title
    self.navigationItem.title = @"旅友动态";
    //设置tableView
    [self setTableView];
    //添加导航栏右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布动态" style:UIBarButtonItemStylePlain target:self action:@selector(dynamicAC)];
    
}



//tableView设置
- (void)setTableView{
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"StoriesViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //隐藏tableview滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //隐藏tableview分割线
    self.tableView.separatorStyle = NO;
    //tableview背景图片
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [img setImage:[UIImage imageNamed:@"背景.jpg"]];
    img.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.tableView setBackgroundView:img];
}

//动态
- (void)dynamicAC{
//    NSLog(@"发布");
    //跳转到动态发表界面
    DynamicViewController *dVC = [[DynamicViewController alloc] init];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dVC];
    [self presentModalViewController:nvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoriesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //设置cell选中时背景颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.297];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
