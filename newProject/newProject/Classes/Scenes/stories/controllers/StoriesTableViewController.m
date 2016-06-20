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
#import <Wilddog.h>

@interface StoriesTableViewController ()
//数据数组
@property (strong, nonatomic)NSMutableArray *dataArr;

//记录登录的用户名
@property (copy, nonatomic)NSString *userName;
//记录用户头像
@property (copy, nonatomic)NSString *headerImg;


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
    
    _dataArr = [NSMutableArray array];
    [self getStories];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    //获取登录的账户名
    [self getLoginStatus];
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


//获取动态
- (void)getStories{
    Wilddog *storiesWilddog = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com/stories"];
    [storiesWilddog observeEventType:WEventTypeChildAdded withBlock:^(WDataSnapshot * _Nonnull snapshot) {
        StoriesModel *model = [[StoriesModel alloc] init];
        [model setValuesForKeysWithDictionary:snapshot.value];
        [_dataArr addObject:model];
        [self.tableView reloadData];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        if (error) {
            NSLog(@"获取动态失败");
        }
    }];
    
}


//动态
- (void)dynamicAC{
//    NSLog(@"发布");
    //跳转到动态发表界面
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userName"]) {
        DynamicViewController *dVC = [[DynamicViewController alloc] init];
        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:dVC];
        dVC.uesrName = _userName;
        dVC.headerImg = _headerImg;
        [self presentModalViewController:nvc animated:YES];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"未登录" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:alertAC];
        [self presentViewController:alert animated:YES completion:nil];
    
    }
    
}


//获取登录的用户名和头像
- (void)getLoginStatus{
        Wilddog *userName = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com/users"];
        
        Wilddog *newName = [userName childByAppendingPath:[[NSUserDefaults standardUserDefaults] valueForKey:@"userName"]];
        
        [newName observeEventType:WEventTypeValue withBlock:^(WDataSnapshot * _Nonnull snapshot) {
            _userName = snapshot.value[@"userName"];
            _headerImg = snapshot.value[@"headerImg"];
        } withCancelBlock:^(NSError * _Nonnull error) {
            if (error) {
                NSLog(@"读取用户数据失败");
            }
        }];

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
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoriesViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //设置cell选中时背景颜色
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.297];
    cell.model = self.dataArr[_dataArr.count - 1 - indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataArr[_dataArr.count - 1 - indexPath.row] photoArr].count > 0) {
        return 200;
    }else{
        return 100;
    }
    
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
