//
//  LoginViewController.m
//  UICollectionView
//
//  Created by 朱博文 on 16/6/14.
//  Copyright © 2016年 boon. All rights reserved.
//

#import "registViewController.h"
#import <Wilddog.h>

@interface registViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *registNameTF;
@property (weak, nonatomic) IBOutlet UITextField *registPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *registPasswordAgreeTF;
@property (weak, nonatomic) IBOutlet UIImageView *registUserImg;
//图片选择器
@property(nonatomic,strong)UIImagePickerController *imgPicker;
@end

@implementation registViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化照片选择器
    _imgPicker = [[UIImagePickerController alloc]init];
    //设置代理
    _imgPicker.delegate = self;
}
#pragma maek UIIamgePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //获取到我们选的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    _registUserImg.image = image;
    //如果图片来源是照相机,把图片存入相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(saveImage), nil);
        
    }
    //隐藏图片选择器
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)saveImage{
    NSLog(@"图片存进入啦");
}
//注册按钮事件
- (IBAction)registAction:(UIButton *)sender {
    //添加弹窗提示
    __weak typeof(self) weakSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //判断是否注册成功
        if ([alert.message isEqualToString:@"注册成功"]) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alert addAction:action];
    
    //判断各个输入框的各种情况
    //如果用户名为空
    if ([_registNameTF.text isEqualToString:@""]) {
        alert.message = @"用户名不能为空";
        [self presentViewController:alert animated:YES completion:nil];
    }else if ([_registPasswordTF.text isEqualToString:@""]){
        //如果密码为空
        alert.message = @"密码不能为空";
        [self presentViewController:alert animated:YES completion:nil];
    }else if(![_registPasswordTF.text isEqualToString:_registPasswordAgreeTF.text]){
        //如果两次密码不相同
        alert.message = @"两次输入的密码不相同";
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        Wilddog *registWilddog  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com"];
        [registWilddog createUser:_registNameTF.text password:_registPasswordTF.text withValueCompletionBlock:^(NSError * _Nullable error, NSDictionary * _Nonnull result) {
            if (!error) {
                alert.message = @"注册成功";
                Wilddog *usersWilddog  = [[Wilddog alloc] initWithUrl:@"https://sichuguangguang.wilddogio.com/users"];
                NSData *data = UIImageJPEGRepresentation(_registUserImg.image, 0.2);
                NSString *str = [data base64Encoding];
                NSDictionary *userInfo = @{
                                           @"headerImg": str,
                                           @"userName": _registNameTF.text,
                                           };
                Wilddog *newWilddog = [usersWilddog childByAppendingPath:result[@"uid"]];
                [newWilddog setValue:userInfo];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                NSLog(@"注册失败%@", error);
            }
        }];
    }

}
//选择图片手势事件
- (IBAction)chooseImgAction:(UITapGestureRecognizer *)sender {
    __weak typeof(self) weakSelf = self;
    //添加 Alertsheet
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //指定资源类型为相册获取图片
        _imgPicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        _imgPicker.allowsEditing = YES;
        [weakSelf presentViewController:_imgPicker animated:YES completion:nil];
    }];
    UIAlertAction *cameraAC = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //指定资源类型为照相机获取图片
        _imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imgPicker.allowsEditing = YES;
        [weakSelf presentViewController:_imgPicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAC = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //把响应事件交给弹窗
    [alert addAction:action];
    [alert addAction:cameraAC];
    [alert addAction:cancelAC];
    
    [self presentViewController:alert animated:YES completion:nil];
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
