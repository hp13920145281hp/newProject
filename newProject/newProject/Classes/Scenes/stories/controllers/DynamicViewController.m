//
//  DynamicViewController.m
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "DynamicViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <TZImagePickerController.h>
#import "AppDelegate.h"
#import <FMDB.h>
#import <BaiduMapAPI_Radar/BMKRadarManager.h>
#import <Wilddog.h>


@interface DynamicViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, TZImagePickerControllerDelegate>
//动态输入框
@property (weak, nonatomic) IBOutlet UITextView *textView;

//照片选择显示
@property (weak, nonatomic) IBOutlet UICollectionView *photoCV;

//图片数据数组
@property (strong, nonatomic)NSMutableArray *dataArr;

//图片选择器
@property (strong, nonatomic)UIImagePickerController *imgPicker;

@end

@implementation DynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏标题
    self.navigationItem.title = @"动态发表";
    //设置导航栏左右按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回 (2)"] style:UIBarButtonItemStylePlain target:self action:@selector(backAC)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"保存 (1)"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAC)];
    //设置collectionView
    [self setCollectionView];
    [self setTextView];
    
}


//设置collectionView
- (void)setCollectionView{
    //设置collectionView代理
    self.photoCV.delegate = self;
    self.photoCV.dataSource = self;
    //注册
    [self.photoCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    _dataArr = [NSMutableArray array];
}

//设置
- (void)setTextView{
    
}

//发布
- (void)saveAC{
    NSMutableArray *muArr = [NSMutableArray array];
    for (int i = 0; i < _dataArr.count; i++) {
        NSData *data = UIImageJPEGRepresentation(_dataArr[i], 0.5);
        NSString *str = [data base64Encoding];
        [muArr addObject:str];
    }
    Wilddog *storiesWilddog = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com/stories"];
    Wilddog *newWilddog = [storiesWilddog childByAutoId];
    NSDictionary *dic = @{@"userName":_uesrName, @"text":_textView.text, @"headerImg":_headerImg, @"imgs":muArr};
    [newWilddog setValue:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}


//返回
- (void)backAC{
    [self dismissModalViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [self.photoCV dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    if (indexPath.row == self.dataArr.count) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"加号"]];
    }else{
        cell.backgroundView = [[UIImageView alloc] initWithImage:self.dataArr[indexPath.row]];
    }
    return cell;
}


//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArr.count < 4) {
        [self setAlertController];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"最多选择4张图片" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alerAC = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:alerAC];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//设置弹窗
- (void)setAlertController{
    __weak typeof(self) weakSelf = self;
    //添加 AlertSheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //相册事件
    UIAlertAction *photoAC = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TZImagePickerController *tzVC = [[TZImagePickerController alloc] initWithMaxImagesCount:(4 - self.dataArr.count) delegate:self];
        [self presentViewController:tzVC animated:YES completion:nil];
    }];
    //相机事件
    UIAlertAction *cameraAC = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //指定资源类型为照相机获取图片
        _imgPicker = [[UIImagePickerController alloc] init];
        _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imgPicker.allowsEditing = YES;
        _imgPicker.delegate = self;
        [weakSelf presentViewController:_imgPicker animated:YES completion:nil];
    }];
    
    //取消操作
    UIAlertAction *canceAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //把响应事件交给弹出
    [alert addAction:photoAC];
    [alert addAction:cameraAC];
    [alert addAction:canceAC];
    
    //推出弹窗
    [self presentViewController:alert animated:YES completion:nil];
}


//点击相册中的图片或照相机照完后点击use  后触发的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.dataArr addObjectsFromArray:photos];
    [self.photoCV reloadData];
}


//点击cancel 调用的方法
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
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
