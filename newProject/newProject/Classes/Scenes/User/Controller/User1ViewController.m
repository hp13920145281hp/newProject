//
//  User1ViewController.m
//  newProject
//
//  Created by hupan on 16/6/19.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "User1ViewController.h"
#import "LoginViewController.h"
#import "registViewController.h"
#import "ActionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <Wilddog.h>
#import "PerfectInformationViewController.h"
#import "CollectViewController.h"
#import "AboutUsViewController.h"

@interface User1ViewController ()<UITableViewDelegate,UITableViewDataSource>

//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;

//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

//个人签名
@property (weak, nonatomic) IBOutlet UILabel *userSignLabel;


//功能列表
@property (weak, nonatomic) IBOutlet UITableView *actionTableView;


//存放功能按钮数据
@property(strong,nonatomic)NSArray *array;

//记录登录用户ID
@property (copy, nonatomic)NSString *userID;


@end

@implementation User1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像切圆
    self.userImgView.layer.cornerRadius = 60;
    self.userImgView.layer.masksToBounds = YES;
    
    
    //初始化数组
    self.array = @[@"收藏",@"完善信息",@"清除缓存",@"夜间模式",@"版本更新",@"关于我们"];
    self.actionTableView.delegate = self;
    self.actionTableView.dataSource = self;
    
    //注册
    [self.actionTableView registerNib:[UINib nibWithNibName:@"ActionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
        [self setLoginView];
    [self.actionTableView reloadData];
}

//设置登录后显示内容
- (void)setLoginView{
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(CancelAction)];
        
        //显示登录用户的信息
        Wilddog *ref = [[Wilddog alloc] initWithUrl:[NSString stringWithFormat:@"https://sichuguangguang1.wilddogio.com/users/%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]]];
        [ref observeEventType:WEventTypeValue withBlock:^(WDataSnapshot *snapshot) {
            if (snapshot.value) {
                
                NSData *data = [[NSData alloc] initWithBase64Encoding:snapshot.value[@"headerImg"]];
                _userImgView.image = [UIImage imageWithData:data];
                _userNameLabel.text = snapshot.value[@"userName"];
                [[NSUserDefaults standardUserDefaults] setValue:snapshot.value[@"userName"] forKey:@"userName"];
            }
        }];
    } else {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
    }
    
}


//登录按钮事件
- (void)loginAction{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



//取消登录按钮事件
- (void)CancelAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已退出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        Wilddog *myRootRef  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang1.wilddogio.com"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userName"];
        [myRootRef unauth];
        _userNameLabel.text = @"未登录";
        _userSignLabel.text = @"";
        _userImgView.image = [UIImage imageNamed:@"DefaultAvatar"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:alertAC];
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.cellNameLabel.text = self.array[indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:self.array[indexPath.row]];
    if (indexPath.row == 2) {
        //清除缓存
        [cell.celljiaoImg removeFromSuperview];
        [cell.cellSwitch removeFromSuperview];
        dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(global, ^{
            float num = [self folderSizeAtPath:[self getCachesPath]];
            dispatch_queue_t main = dispatch_get_main_queue();
            dispatch_async(main, ^{
                cell.cellLabel.text = [NSString stringWithFormat:@"%.2fM", num];
            });
        });
    }else if (indexPath.row == 3) {
        //夜间模式
        [cell.celljiaoImg removeFromSuperview];
        [cell.cellLabel removeFromSuperview];
    }else{
        //其他
        [cell.cellLabel removeFromSuperview];
        [cell.cellSwitch removeFromSuperview];
        cell.celljiaoImg.image = [UIImage imageNamed:@"下一页"];
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //收藏
            CollectViewController *collectionVC = [[CollectViewController alloc]init];
            [self.navigationController pushViewController:collectionVC animated:YES];
        }
            break;
        case 1:
        {
            //完善信息
            PerfectInformationViewController *perfectVC = [[PerfectInformationViewController alloc]initWithNibName:@"PerfectInformationViewController" bundle:nil];
            [self.navigationController pushViewController:perfectVC animated:YES];
        }
            break;
        case 2:
        {
            //清除缓存
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认清除" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self clearCache:[self getCachesPath]];
                NSLog(@"清除");
                [self.actionTableView reloadData];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:alertAction1];
            [alertController addAction:alertAction2];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
            break;
        case 3:
        {
            //夜间模式
        }
            break;
        case 4:
        {
            //版本更新
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"此版本已是最新的版本" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:alertAC];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 5:
        {
            //关于我们
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
            break;
        default:
            break;
    }
}

//获取缓存文件路径
-(NSString *)getCachesPath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}
///计算缓存文件的大小的M
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        
        //        //取得一个目录下得所有文件名
        //        NSArray *files = [manager subpathsAtPath:filePath];
        //        NSLog(@"files1111111%@ == %ld",files,files.count);
        //
        //        // 从路径中获得完整的文件名（带后缀）
        //        NSString *exe = [filePath lastPathComponent];
        //        NSLog(@"exeexe ====%@",exe);
        //
        //        // 获得文件名（不带后缀）
        //        exe = [exe stringByDeletingPathExtension];
        //
        //        // 获得文件名（不带后缀）
        //        NSString *exestr = [[files objectAtIndex:1] stringByDeletingPathExtension];
        //        NSLog(@"files2222222%@  ==== %@",[files objectAtIndex:1],exestr);
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];//从前向后枚举器／／／／//
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        //        NSLog(@"fileName ==== %@",fileName);
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        //        NSLog(@"fileAbsolutePath ==== %@",fileAbsolutePath);
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    //    NSLog(@"folderSize ==== %lld",folderSize);
    return folderSize/(1024.0*1024.0);
}
- (void)clearCache:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            
            //如有需要，加入条件，过滤掉不想删除的文件
            
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];            
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    // SDImageCache 自带缓存
    [[SDImageCache sharedImageCache] cleanDisk];
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
