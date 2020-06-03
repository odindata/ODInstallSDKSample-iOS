//
//  ODIUUserView.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIUUserView.h"
#import "UIColor+ODExtension.h"
#import "ODInstallHeader.h"
#import "UIColor+ODExtension.h"
#import "NSString+ODIExtension.h"

@implementation ODIUUserView

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
    UIImageView *headImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"us_00"]];
    headImgView.frame =  CGRectMake(13 * PUBLICSCALE, 13, 46, 46);
    [self addSubview:headImgView];
    
    UIButton *shipListBtn = [[UIButton alloc]init];
    [shipListBtn setTitle:@"关系列表" forState:0];
    [shipListBtn addTarget:self action:@selector(shipListAction:) forControlEvents:UIControlEventTouchUpInside];
    [shipListBtn setTitleColor:[UIColor  colorWithRed:49 withGreen:51 withBlue:62] forState:0];
    shipListBtn.backgroundColor = [UIColor  colorWithRed:245 withGreen:247 withBlue:249];
    shipListBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    shipListBtn.layer.borderColor = [UIColor  colorWithRed:167 withGreen:182 withBlue:199].CGColor;
    shipListBtn.layer.borderWidth = 1;
    shipListBtn.layer.cornerRadius = 3;
    shipListBtn.layer.masksToBounds = YES;
    shipListBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - (13 + 76) * PUBLICSCALE, 17, 76 * PUBLICSCALE, 37);
    [self addSubview:shipListBtn];
    
    UILabel *userIdlbl = [[UILabel alloc]init];
    NSString *userId = [NSString currentUserId];
    userIdlbl.text = userId;
    userIdlbl.textColor = [UIColor  colorWithRed:49 withGreen:51 withBlue:62];
    userIdlbl.font = [UIFont systemFontOfSize:15];
    userIdlbl.frame = CGRectMake(15 * PUBLICSCALE+CGRectGetMaxX(headImgView.frame), 0, CGRectGetMinX(shipListBtn.frame) - CGRectGetMaxX(headImgView.frame), self.frame.size.height);
    [self addSubview:userIdlbl];
    
}

- (void)shipListAction:(UIButton *)sender{
    if (self.shipListBlock) {
        self.shipListBlock();
    }
}

@end
