//
//  feedbackViewController.m
//  四处逛逛
//
//  Created by SuperCodi on 16/6/15.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "feedbackViewController.h"

@interface feedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLable;
@property (weak, nonatomic) IBOutlet UITextField *lianxiLable;
@property (weak, nonatomic) IBOutlet UITextView *detailLable;

@end

@implementation feedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//提交事件
- (IBAction)submitAction:(UIButton *)sender {
    if ([_nameLable.text isEqualToString:@""] ||  [_lianxiLable.text isEqualToString:@""] || [_detailLable.text isEqualToString:@""]) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"" message:@"您输入的内容不完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
    }else{
        UIAlertView *alter1 = [[UIAlertView alloc] initWithTitle:@"" message:@"提交成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [self.navigationController popViewControllerAnimated:YES];
        [alter1 show];
    }
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
