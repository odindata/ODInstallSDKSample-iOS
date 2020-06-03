//
//  ODLWakeUpViewController.m
//  ODLinkSDKSample
//
//  Created by nathan on 2020/5/19.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIWakeUpViewController.h"
#import <OdinShareSDK/OdinShareSDK.h>
#import <OdinShareSDKUI/OdinShareSDKUI.h>
#import "ODInstallHeader.h"
#import "MBProgressHUD+Extension.h"

@interface ODIWakeUpViewController ()

@property (weak, nonatomic) IBOutlet UIButton *wakeupBtn;

@end

@implementation ODIWakeUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.wakeupBtn.layer.cornerRadius = 4;
    self.wakeupBtn.layer.masksToBounds = YES;
}

- (IBAction)wakeupAction:(id)sender {
    NSArray *platforms =@[
        @(OdinSocialPlatformSubTypeQQFriend),
        @(OdinSocialPlatformSubTypeQZone),
        @(OdinSocialPlatformSubTypeWechatSession),
        @(OdinSocialPlatformSubTypeWechatTimeline),
        @(OdinSocialPlatformSubTypeWechatFav)
    ];
    
    OdinSocialMessageObject *obj = [[OdinSocialMessageObject alloc]init];
    OdinShareWebpageObject *webObj = [[OdinShareWebpageObject alloc]init];
    
    webObj.descr = @"分享描述";
    webObj.webpageUrl = [NSString stringWithFormat:@"http://www.odinanalysis.com/.well-known/demo/install/index.html?channelCode=%@",CHANNEL_CODE];
    webObj.title = @"分享标题";
    
    obj.shareObject = webObj;
    OdinUIShareSheetConfiguration *config=[OdinUIShareSheetConfiguration new];
    config.cancelButtonHidden = YES;
    config.style = OdinUIActionSheetStyleSimple;
    config.columnLandscapeCount = 1;
    [[OdinSocialUIManager shareInstance] showShareActionSheet:platforms shareObject:obj sheetConfiguration:config currentViewController:self CompletionHandler:^(id shareResponse, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error)
            {
                [MBProgressHUD showTitle:@"分享失败"];
            }
            else
            {
                [MBProgressHUD showTitle:@"分享成功"];
            }
        });
    }];
}


@end
