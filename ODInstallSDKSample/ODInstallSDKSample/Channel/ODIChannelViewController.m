//
//  ODIChannelViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIChannelViewController.h"
#import "ODIUQRCodeView.h"
#import "ODInstallHeader.h"
#import "ODIQRCodeTool.h"
#import "ODICTipVIew.h"
#import "ODICStatisticsView.h"
#import "ODHttpTool.h"

@interface ODIChannelViewController ()

@end

@implementation ODIChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"渠道效果";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
}

- (void)setupView{
   
    ODICTipVIew *tipView =[[ODICTipVIew alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.view addSubview:tipView];
    
    ODICStatisticsView *statView = [[ODICStatisticsView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 10 + CGRectGetMaxY(tipView.frame), SCREEN_WIDTH - 2 * 21 * PUBLICSCALE,67)];
    [self.view addSubview:statView];
    
    NSDictionary *param = @{
        @"page":@{@"index":@"1",@"size":@"10"},
        @"param":@{
                @"odinKey":@"985459861c2c4e7b8f4f2c7245e56448",
                @"timeInterval":@"custom",
                @"startTime":@"2020-06-02 00:00:00",
                @"endTime":@"2050-06-02 23:59:59"
        }
    };
    
    NSMutableArray *statData = [NSMutableArray array];
    //获取统计数据
    [ODHttpTool postWithUrlString:ODIUserStatPath parameters:param success:^(NSDictionary * _Nonnull data) {
        if ([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSMutableArray class]]) {
            for (NSDictionary *statDic in data) {
                if ([statDic[@"channelCode"] isEqualToString:CHANNEL_CODE]) {
                    [statData addObject: statDic[@"visitsNum"]];
                    [statData addObject: statDic[@"clickNum"]];
                    [statData addObject: statDic[@"installNum"]];
                    [statData addObject: statDic[@"callOnNum"]];
                    dispatch_async(dispatch_get_main_queue(),^{
                       statView.data = statData;
                    });
                    break;
                }
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    ODIUQRCodeView *codeView = [[ODIUQRCodeView alloc] initWithFrame:CGRectMake(21 * PUBLICSCALE, 19 + CGRectGetMaxY(statView.frame), SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 276)];

    codeView.codeImg = [ODIQRCodeTool createQRCodeWithUrlString:[NSString stringWithFormat:@"http://www.odinanalysis.com/.well-known/demo/install/index.html?channelCode=%@",CHANNEL_CODE] size:150 *PUBLICSCALE];
    [self.view addSubview:codeView];
}

@end
