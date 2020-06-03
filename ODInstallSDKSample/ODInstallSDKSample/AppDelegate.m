//
//  AppDelegate.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import "ODIHomeViewController.h"
#import "ODInstallSDK.h"
#import "ODNavigationViewController.h"
#import <OdinShareSDK/OdinShareSDK.h>

@interface AppDelegate ()<ODInstallDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    ODNavigationViewController *navVc = [[ODNavigationViewController alloc]initWithRootViewController:[ODIHomeViewController new]];
    self.window.rootViewController = navVc;
    
    [ODInstallSDK initWithDelegate:self];
    [[ODInstallSDK defaultManager] logOn:YES];
    
    [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeWechatSession appKey:@"wx7e0acb745b6bcf44" appSecret:@"0583956fe095990091f70fab824567ab" redirectURL:nil];
       
       
       [[OdinSocialManager  defaultManager] setPlaform:OdinSocialPlatformSubTypeQQFriend appKey:@"101879896" appSecret:@"d7a6de61c89858f1bef3c3002f4a6d77" redirectURL:nil];
    return YES;
}

#pragma 一键拉起的参数回调方法
-(void)getWakeUpParams:(ODInstallData *)appData{
    
    if (appData.data) {//(动态唤醒参数)
        //e.g.如免填邀请码建立邀请关系、自动加好友、自动进入某个群组或房间等
    }
    if (appData.channelCode) {//(通过渠道链接或二维码安装会返回渠道编号)
        //e.g.可自己统计渠道相关数据等
    }
    
    //弹出提示框(便于调试，调试完成后删除此代码)
    NSLog(@"ODInstallSDK:\n动态参数：%@;\n渠道编号：%@",appData.data,appData.channelCode);
    NSString *getData;
    if (appData.data) {
        //如果有中文，转换一下方便展示
        getData = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:appData.data options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    NSString *parameter = [NSString stringWithFormat:@"如果没有任何参数返回，请确认：\n"
                           @"是否通过含有动态参数的分享链接(或二维码)安装的app\n\n动态参数：\n%@\n渠道编号：%@",
                           getData,appData.channelCode];
    UIAlertController *testAlert = [UIAlertController alertControllerWithTitle:@"唤醒参数" message:parameter preferredStyle:UIAlertControllerStyleAlert];
    [testAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:testAlert animated:true completion:nil];
    
}

//ios9以下 URI Scheme
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    //判断是否通过OpenInstall URL Scheme 唤起App
    if ([ODInstallSDK handLinkURL:url]) {
        
        return YES;
    }else if ([[OdinSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation]){
        return YES;
    }
    //其他代码
    return YES;
    
}

//iOS9以上 URL Scheme
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(nonnull NSDictionary *)options
{
    
    //判断是否通过OpenInstall URL Scheme 唤起App
    if ([ODInstallSDK handLinkURL:url]) {
        return YES;
    }else if([[OdinSocialManager  defaultManager] handleOpenURL:url]){
        return  YES;
    }
    
    //其他代码
    return YES;
    
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    if ([ODInstallSDK continueUserActivity:userActivity]) {
        return YES;
    }
    return YES;
}
@end
