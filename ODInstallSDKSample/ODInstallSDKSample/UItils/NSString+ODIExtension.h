//
//  NSString+ODIExtension.h
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/27.
//  Copyright © 2020 odin. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ODIExtension)

+ (NSString *)currentUserId;

+ (NSString *)upUserId;

+ (void)setCurrentUserId:(NSString *)userId;

+ (void)setUpUserId:(NSString *)userId;

@end

NS_ASSUME_NONNULL_END
