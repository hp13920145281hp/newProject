//
//  UserViewController.m
//  UICollectionView
//
//  Created by 朱博文 on 16/6/14.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "UserViewController.h"
#import "LoginViewController.h"
#import "registViewController.h"
#import "ActionTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <EaseMob.h>
#import <Wilddog.h>

@interface UserViewController ()<UITableViewDelegate,UITableViewDataSource>
//用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
//个人签名
@property (weak, nonatomic) IBOutlet UILabel *userSignLabel;
//性别
@property (weak, nonatomic) IBOutlet UILabel *userGenderLabel;
//功能列表
@property (weak, nonatomic) IBOutlet UITableView *actionTableView;

//判断是否已经登录
@property(assign,nonatomic)BOOL isLogin;
//存放功能按钮数据
@property(strong,nonatomic)NSArray *array;

//记录登录用户ID
@property (copy, nonatomic)NSString *userID;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //头像切圆
    self.userImgView.layer.cornerRadius = 75;
    self.userImgView.layer.masksToBounds = YES;

    
    //初始化数组
    self.array = @[@"收藏",@"完善信息",@"清除缓存",@"夜间模式",@"版本更新",@"关于我们"];
    self.actionTableView.delegate = self;
    self.actionTableView.dataSource = self;
    
    //注册
    [self.actionTableView registerNib:[UINib nibWithNibName:@"ActionTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    Wilddog *myRootRef  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com"];
    __weak typeof(self) weakSelf = self;
    [myRootRef observeAuthEventWithBlock:^(WAuthData *authData) {
        if (authData) {
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(CancelAction)];
            _userID = authData.uid;
            NSLog(@"%@", authData.uid);
            
        } else {
            
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction)];
        }
    }];
    
    
   
    

}

- (void)viewWillAppear:(BOOL)animated{
    Wilddog *ref = [[Wilddog alloc] initWithUrl:[NSString stringWithFormat:@"https://sichuguangguang.wilddogio.com/users/%@", _userID]];
    [ref observeEventType:WEventTypeValue withBlock:^(WDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot.value);
    } withCancelBlock:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
}


//登录按钮
- (void)loginAction{
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}



//取消登录按钮
- (void)CancelAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已退出" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        Wilddog *myRootRef  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com"];
        [myRootRef unauth];
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
    if (indexPath.row == 2) {
        //清除缓存
        [cell.celljiaoImg removeFromSuperview];
        [cell.cellSwitch removeFromSuperview];
        cell.cellLabel.text = [NSString stringWithFormat:@"%lfM",[self folderSizeAtPath:[self getCachesPath]]];
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
    return cell;
}
//获取缓存文件路径
-(NSString *)getCachesPath{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
//    NSString *filePath = [cachesDir stringByAppendingPathComponent:@"com.nickcheng.NCMusicEngine"];
    
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
////////////
-(void)ss{
    // 获取Caches目录路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    NSLog(@"cachesDircachesDir == %@",cachesDir);
    //读取缓存里面的具体单个文件/或全部文件//
    NSString *filePath = [cachesDir stringByAppendingPathComponent:@"com.nickcheng.NCMusicEngine"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"filePathfilePath%@ ==array==== %@",filePath, array);
    
    
    NSFileManager* fm=[NSFileManager defaultManager];
    if([fm fileExistsAtPath:filePath]){
        //取得一个目录下得所有文件名
        NSArray *files = [fm subpathsAtPath:filePath];
        NSLog(@"files1111111%@ == %ld",files,files.count);
        
        // 获得文件名（不带后缀）
        NSString * exestr = [[files objectAtIndex:1] stringByDeletingPathExtension];
        NSLog(@"files2222222%@  ==== %@",[files objectAtIndex:1],exestr);
    }
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
