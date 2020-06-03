//
//  ODIUQRCodeView.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIUQRCodeView.h"
#import "UIColor+ODExtension.h"
#import "ODInstallHeader.h"

@interface ODIUQRCodeView ()

@property(nonatomic,strong)UIImageView *qrCodeImgView;

@end

@implementation ODIUQRCodeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
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
    UILabel *tiplbl = [[UILabel alloc]init];
    tiplbl.textAlignment = NSTextAlignmentCenter;
    tiplbl.text = @"渠道二维码";
    tiplbl.textColor = [UIColor  colorWithRed:79 withGreen:81 withBlue:90];
    tiplbl.font = [UIFont systemFontOfSize:19];
    tiplbl.frame = CGRectMake(0, 32, CGRectGetWidth(self.frame) , 15);
    [self addSubview:tiplbl];
    
    UIImageView *qrCodeImgView = [[UIImageView alloc]init];
    _qrCodeImgView = qrCodeImgView;
    qrCodeImgView.frame =  CGRectMake(92 * PUBLICSCALE, 12 + CGRectGetMaxY(tiplbl.frame), 150 * PUBLICSCALE, 150 * PUBLICSCALE);
    [self addSubview:qrCodeImgView];
    
    
    UILabel *tipDownlbl = [[UILabel alloc]init];
    tipDownlbl.textAlignment = NSTextAlignmentCenter;
    tipDownlbl.text = @"扫码打开页面并下载应用\r\n即会统计响应的渠道效果";
    tipDownlbl.numberOfLines = 0;
    tipDownlbl.textColor = [UIColor  colorWithRed:114 withGreen:115 withBlue:119];
    tipDownlbl.font = [UIFont systemFontOfSize:9];
    tipDownlbl.frame = CGRectMake(0, 15 + CGRectGetMaxY(qrCodeImgView.frame), CGRectGetWidth(self.frame) , 22);
    [self addSubview:tipDownlbl];
}

- (void)setCodeImg:(UIImage *)codeImg{
    _codeImg = codeImg;
    self.qrCodeImgView.image = codeImg;
}

@end
