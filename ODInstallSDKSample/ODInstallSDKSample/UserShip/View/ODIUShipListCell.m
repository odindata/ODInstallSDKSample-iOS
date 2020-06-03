//
//  ODIUShipListCell.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIUShipListCell.h"
#import "ODInstallHeader.h"
#import "UIColor+ODExtension.h"

@interface ODIUShipListCell ()

@property(nonatomic,strong)UIImageView *headImgView;

@property(nonatomic,strong)UILabel *userIdlbl;

@end

@implementation ODIUShipListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setupView{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(21 * PUBLICSCALE, 11, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 72)];
    //加阴影
    containerView.layer.masksToBounds = NO;
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.shadowColor = [UIColor colorWithRed:38 withGreen:71 withBlue:98 alpha:.3].CGColor;
    containerView.layer.shadowOffset = CGSizeMake(3,4);   //0,0围绕阴影四周  0,4向下有4个像素的偏移
    containerView.layer.shadowOpacity = .3;   //设置阴影透明度
    containerView.layer.shadowRadius = 5;      //设置阴影圆角
    containerView.layer.cornerRadius = 8;     //设置视图圆角
    [self.contentView addSubview:containerView];
    
    UIImageView *headImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"us_00"]];
    _headImgView = headImgView;
    headImgView.frame =  CGRectMake(13 * PUBLICSCALE, 13, 46, 46);
    [containerView addSubview:headImgView];
    
    
    UILabel *userIdlbl = [[UILabel alloc]init];
    _userIdlbl = userIdlbl;
    userIdlbl.numberOfLines = 0;
    userIdlbl.textColor = [UIColor  colorWithRed:49 withGreen:51 withBlue:62];
    userIdlbl.font = [UIFont systemFontOfSize:15];
    userIdlbl.frame = CGRectMake(15 * PUBLICSCALE+CGRectGetMaxX(headImgView.frame), 0, CGRectGetWidth(containerView.frame) - 15 * PUBLICSCALE - CGRectGetMaxX(headImgView.frame), 72);
    [containerView addSubview:userIdlbl];
}


- (void)setUserDic:(NSDictionary *)userDic{
    _userDic = userDic;
    if ([userDic[@"userId"] isMemberOfClass:[NSNull class]]) {
         _userIdlbl.text = @"";
    }else{
        _userIdlbl.text = userDic[@"userId"];
    }
   

    _headImgView.image = [UIImage imageNamed:userDic[@"imgIcon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
