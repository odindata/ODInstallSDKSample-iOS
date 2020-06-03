//
//  ODICTipVIew.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODICTipVIew.h"
#import "ODInstallHeader.h"
#import "UIColor+ODExtension.h"

@implementation ODICTipVIew

- (instancetype)initWithFrame:(CGRect)frame{
    if (self  =  [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UILabel *textlbl = [[UILabel alloc]init];
    textlbl.text = @"落地测试页";
    textlbl.tag = 10086;
    textlbl.textColor = [UIColor colorWithRed:87 withGreen:89 withBlue:98];
    textlbl.font = [UIFont systemFontOfSize:13];
    textlbl.frame = CGRectMake(36 * PUBLICSCALE, 0, SCREEN_WIDTH - 2 * 36 * PUBLICSCALE, 43);
    [self addSubview:textlbl];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 43, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    [self addSubview:lineView];
}

@end
