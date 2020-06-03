//
//  ODHomeViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIHomeViewController.h"
#import "ODInstallHeader.h"
#import "ODIHomeCell.h"
#import "ODIWakeUpViewController.h"
#import "ODIUserShipViewController.h"
#import "ODIChannelViewController.h"
#import "ODIAlertViewController.h"
#import "ODInstallSDK.h"
#import "MBProgressHUD.h"
#import "NSString+ODIExtension.h"

@interface ODIHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ODIAlertViewControllerDelegate>

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong) UIWindow *alertWindow;

@end

@implementation ODIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupView];
}

- (void)setupView{
    self.title = @"Odin Install";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH - 23*2 - 18) / 2.0, (SCREEN_WIDTH - 23*2 - 18) / 2.0 * 377/311.0);
    flowLayout.minimumLineSpacing = 18;
    flowLayout.minimumInteritemSpacing = 18;
    flowLayout.sectionInset = UIEdgeInsetsMake(23, 23, 0, 18);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ODIHomeCell" bundle:nil] forCellWithReuseIdentifier:@"ReuseIdentifier"];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ODIHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSDictionary *data = self.dataArray[indexPath.row];
      cell.imgView.image = [UIImage imageNamed:data[@"imgIcon"]];
    cell.typeLbl.text = data[@"type"];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        NSString *userId = [NSString currentUserId];
        if (userId) {
            [self.navigationController pushViewController:[ODIUserShipViewController new] animated:YES];
        }else{
            ODIAlertViewController *alertVC = [[ODIAlertViewController alloc] initWithNibName:@"ODIAlertViewController" bundle:nil];
            alertVC.delegate = self;
            _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _alertWindow.windowLevel = [UIApplication sharedApplication].keyWindow.windowLevel + 1;
            _alertWindow.userInteractionEnabled = YES;
            _alertWindow.rootViewController = alertVC;
            [_alertWindow makeKeyAndVisible];
        }
        
        
    }else if (indexPath.row == 0){
        [self.navigationController pushViewController:[ODIWakeUpViewController new] animated:YES];
    }else{
        [self.navigationController pushViewController:[ODIChannelViewController new] animated:YES];
    }
}

- (void)cancelAction{
    if (_alertWindow)
    {
        [_alertWindow resignKeyWindow];
        _alertWindow.hidden = YES;
        _alertWindow = nil;
    }
}

- (void)okAction:(NSString *)userId{
    if (userId.length <= 0) {
        //提示请输入用户昵称
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"请输入用户账号";
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        
        [hud hideAnimated:YES afterDelay:2.f];
        return;
    }
    //进行注册
    [[ODInstallSDK defaultManager] reportRegister:userId phone:nil email:nil completeBlock:^(NSString * _Nullable upUserId, NSError * _Nullable error) {
        if (upUserId.length>0) {
            [NSString setUpUserId:upUserId];
        }
        [NSString setCurrentUserId:userId];
    }];
    
    if (_alertWindow)
    {
        [_alertWindow resignKeyWindow];
        _alertWindow.hidden = YES;
        _alertWindow = nil;
    }
}

- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = @[
            @{@"imgIcon":@"home_wakeup",@"type":@"一键唤醒"},
            @{@"imgIcon":@"home_user",@"type":@"用户溯源"},
            @{@"imgIcon":@"home_channel",@"type":@"渠道效果"}
        ];
    }
    return _dataArray;
}
@end
