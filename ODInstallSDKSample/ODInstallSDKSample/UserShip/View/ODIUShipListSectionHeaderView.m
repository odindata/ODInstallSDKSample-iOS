//
//  ODIUShipListSectionHeaderView.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIUShipListSectionHeaderView.h"
#import "ODInstallHeader.h"
#import "UIColor+ODExtension.h"

@interface ODIUShipListSectionHeaderView ()

@property(nonatomic,strong) UILabel *textlbl;

@end

@implementation ODIUShipListSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupView{
    UILabel *textlbl = [[UILabel alloc]init];
    textlbl.tag = 10086;
    textlbl.textColor = [UIColor colorWithRed:87 withGreen:89 withBlue:98];
    textlbl.font = [UIFont systemFontOfSize:13];
    textlbl.frame = CGRectMake(36 * PUBLICSCALE, 0, SCREEN_WIDTH - 2 * 36 * PUBLICSCALE, 43);
    [self addSubview:textlbl];
    _textlbl = textlbl;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 43, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:222 withGreen:218 withBlue:218];
    [self addSubview:lineView];
}

- (void)setText:(NSString *)text{
    _text = text;
    _textlbl.text = text;
}

@end
