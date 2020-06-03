//
//  ODIUUserView.h
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODIUUserView : UIView

@property(nonatomic,copy) void (^shipListBlock)(void);

@end

NS_ASSUME_NONNULL_END
