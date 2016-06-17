//
//  MapViewController.m
//  四处逛逛
//
//  Created by hupan on 16/6/14.
//  Copyright © 2016年 hupan. All rights reserved.
//

#import "MapViewController.h"
#import "AddressViewController.h"
#import "SearchViewController.h"
#import "HostViewController.h"


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;


@property (weak, nonatomic) IBOutlet UIButton *secondBtn;

@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;

@property (weak, nonatomic) IBOutlet UIButton *forthBtn;


@end

@implementation MapViewController

- (void)viewDidLoad {
    
    self.navigationController.navigationBar.translucent = NO;
    [super viewDidLoad];
    self.navigationItem.title = @"附近生活";
    
    [self headerView];
    
    [self centerView];
}

- (void)headerView{
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.layer.cornerRadius = self.view.frame.size.width / 4;
}

- (void)centerView{
    
    
    
    self.firstBtn.layer.cornerRadius = 20;
    self.firstBtn.layer.masksToBounds = YES;
    self.firstBtn.layer.borderWidth = 5;
    self.firstBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    
    self.secondBtn.layer.cornerRadius = 20;
    self.secondBtn.layer.masksToBounds = YES;
    self.secondBtn.layer.borderWidth = 5;
    self.secondBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
    self.thirdBtn.layer.cornerRadius = 20;
    self.thirdBtn.layer.masksToBounds = YES;
    self.thirdBtn.layer.borderWidth = 5;
    self.thirdBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    self.forthBtn.layer.cornerRadius = 20;
    self.forthBtn.layer.masksToBounds = YES;
    self.forthBtn.layer.borderWidth = 5;
    self.forthBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    
}

- (IBAction)addressAction:(UIButton *)sender {
    
    AddressViewController * addressVC = [[AddressViewController alloc]init];
    [self.navigationController showViewController:addressVC sender:nil];
}


- (IBAction)nearbyAction:(UIButton *)sender {
    SearchViewController * searchVC = [[SearchViewController alloc]init];
    [self.navigationController showViewController:searchVC sender:nil];
    
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
