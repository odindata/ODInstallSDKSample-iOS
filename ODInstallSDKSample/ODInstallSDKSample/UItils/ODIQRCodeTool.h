//
//  ODIQRCodeTool.h
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ODIQRCodeTool : NSObject

+ (UIImage *)createQRCodeWithUrlString:(NSString *)urlString size:(CGFloat)size;

@end

NS_ASSUME_NONNULL_END
