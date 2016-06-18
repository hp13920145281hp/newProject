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
#import "HomeCollectionViewCell.h"
#import "NavigationViewController.h"
#import "PathViewController.h"
#import "LocationViewController.h"



@interface MapViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@property(nonatomic, strong)UICollectionView *mapHomeCollectionView;
@property(nonatomic,strong)UILabel *headerLabel;
@property(nonatomic, strong)NSArray *imageViewArray;
@property(nonatomic, strong)NSArray *titleArray;
@property (nonatomic, strong) UIImageView *topView;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createCollectionView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.titleArray = @[@"位置",@"附近",@"导航",@"路线"];
    self.imageViewArray = @[@"address_0.jpg",@"nearby",@"navigation",@"route"];
    
}
-(void)createCollectionView{
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //改变每一个item大小
    flowLayout.itemSize = CGSizeMake(100, 85);
    //改变上下行之间的间距
    flowLayout.minimumLineSpacing = 20;
    //改变两个itme中间的大小
    //flowLayout.minimumInteritemSpacing = 10;
    //控制collectionView的itme距离上，左、下、右之间的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 64, 20, 64);
    
    _mapHomeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0 ,355 , 414 , 300) collectionViewLayout:flowLayout];
    _mapHomeCollectionView.delegate = self;
    _mapHomeCollectionView.dataSource = self;
    _mapHomeCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mapHomeCollectionView];
    
    [self.mapHomeCollectionView  registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    _headerImageV.layer.masksToBounds = YES;
    _headerImageV.layer.cornerRadius = _headerImageV.frame.size.height / 4;
    
    
   
    
}
//返回cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}
//返回cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.text = _titleArray[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:_imageViewArray[indexPath.row]];
    return cell;
    
}
//collectionView点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LocationViewController *loc = [[LocationViewController alloc]init];
    PathViewController *pat = [[PathViewController alloc]init];
    SearchViewController *search = [[SearchViewController alloc]init];
    NavigationViewController *NV = [[NavigationViewController alloc]init];
    
    switch (indexPath.row) {
        case 0:
            loc.titleStr = self.titleArray[indexPath.row];
            [self.navigationController showViewController:loc sender:self];
            
            break;
        case 1:
            search.titleStr = self.titleArray[indexPath.row];
            [self.navigationController showViewController:search sender:self];
            break;
        case 2:
            NV.titleStr = self.titleArray[indexPath.row];
            [self.navigationController showViewController:NV sender:self];
            
            break;
        case 3:
            pat.patStr = self.titleArray[indexPath.row];
            [self.navigationController showViewController:pat sender:self];
            
            break;
            
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
