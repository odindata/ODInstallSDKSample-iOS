//
//  ODIAlertViewController.h
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/27.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ODIAlertViewControllerDelegate <NSObject>

- (void)cancelAction;

- (void)okAction:(NSString *)userId;

@end

@interface ODIAlertViewController : UIViewController

@property (nonatomic, weak) id<ODIAlertViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
