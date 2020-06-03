//
//  ODICStatisticsView.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODICStatisticsView.h"
#import "ODInstallHeader.h"
#import "UIColor+ODExtension.h"

@implementation ODICStatisticsView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self  =  [super initWithFrame:frame]) {
        [self setupView];
        
        //加阴影
        self.layer.masksToBounds = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.3].CGColor;
        self.layer.shadowOffset = CGSizeMake(3,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
        self.layer.shadowOpacity = .3;   //设置阴影透明度
        self.layer.shadowRadius = 5;      //设置阴影圆角
        self.layer.cornerRadius = 8;     //设置视图圆角
    }
    return self;
}

- (void)setupView{
    NSArray *statData = @[@"访问量",@"点击量",@"安装量",@"唤醒量"];
    CGFloat lblW = CGRectGetWidth(self.frame) / 4.0;
    for (NSInteger i = 0 ; i < statData.count; i++) {
        UILabel *statlbl = [[UILabel alloc]init];
        statlbl.tag = 10086 + i;
        statlbl.textAlignment = NSTextAlignmentCenter;
        statlbl.textColor = [UIColor colorWithRed:49 withGreen:51 withBlue:62];
        statlbl.font = [UIFont boldSystemFontOfSize:14];
        statlbl.frame = CGRectMake(i * lblW, 18, lblW, 20);
        [self addSubview:statlbl];
        
        UILabel *tiplbl = [[UILabel alloc]init];
        tiplbl.textAlignment = NSTextAlignmentCenter;
        tiplbl.text = statData[i];
        tiplbl.textColor = [UIColor colorWithRed:93 withGreen:95 withBlue:103];
        tiplbl.font = [UIFont systemFontOfSize:7];
        tiplbl.frame = CGRectMake(i * lblW, CGRectGetHeight(self.frame) - 7 - 15, lblW, 7);
        [self addSubview:tiplbl];
    }
}

- (void)setData:(NSArray *)data{
    _data = data;
    for (NSInteger i = 0 ; i < data.count; i++) {
        UILabel *lbl = [self viewWithTag:(10086 + i)];
        lbl.text = [NSString stringWithFormat:@"%@", data[i]];
    }
}

@end
