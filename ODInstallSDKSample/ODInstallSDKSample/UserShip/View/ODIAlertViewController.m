//
//  ODIAlertViewController.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/27.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODIAlertViewController.h"
#import "UIColor+ODExtension.h"

@interface ODIAlertViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UITextField *userIdTextFiled;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ODIAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor colorWithARGB:0x4c000000];;
    
    self.cancelBtn.layer.cornerRadius = 2;
    self.cancelBtn.layer.borderWidth = 1;
    self.cancelBtn.layer.masksToBounds = YES;
    self.cancelBtn.layer.borderColor = [UIColor colorWithRed:175 withGreen:189 withBlue:204].CGColor;
    
    self.okBtn.layer.cornerRadius = 2;
    self.okBtn.layer.masksToBounds = YES;
    
    self.containerView.layer.cornerRadius = 2;
    self.containerView.layer.masksToBounds = YES;
}


- (IBAction)cancelAction:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelAction)]) {
        [self.delegate cancelAction];
    }
}

- (IBAction)okAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(okAction:)]) {
        [self.delegate okAction:self.userIdTextFiled.text];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
