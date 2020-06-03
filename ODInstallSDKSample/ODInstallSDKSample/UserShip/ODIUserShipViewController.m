//
//  ODIUserShipViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIUserShipViewController.h"
#import "ODIUUserView.h"
#import "ODInstallHeader.h"
#import "ODIUQRCodeView.h"
#import "ODIQRCodeTool.h"
#import "ODIShipListViewController.h"
#import "ODInstallSDK.h"
#import "NSString+ODIExtension.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Extension.h"

@interface ODIUserShipViewController ()

@end

@implementation ODIUserShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"用户关系";
    
    [self setupView];
}

- (void)setupView{
    __weak typeof(self) weakSelf = self;
    ODIUUserView *userView = [[ODIUUserView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 11, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 72)];
    userView.shipListBlock = ^{
        ODIShipListViewController *shipListVc = [[ODIShipListViewController alloc]init];
        [weakSelf.navigationController pushViewController:shipListVc animated:YES];
    };
    [self.view addSubview:userView];
    
    ODIUQRCodeView *codeView = [[ODIUQRCodeView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 15 + CGRectGetMaxY(userView.frame), SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 276)];
    [self.view addSubview:codeView];
    
    NSString *userId = [NSString currentUserId];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //获取分享链接
    [[ODInstallSDK defaultManager] getShareUrlPath:nil userId:userId shareUrlBlock:^(NSString * _Nullable shareUrl, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        if (shareUrl) {
            codeView.codeImg = [ODIQRCodeTool createQRCodeWithUrlString:shareUrl size:150 *PUBLICSCALE];
        }else{
            [MBProgressHUD showTitle:@"获取分享链接失败"];
        }
    }];
}

@end
