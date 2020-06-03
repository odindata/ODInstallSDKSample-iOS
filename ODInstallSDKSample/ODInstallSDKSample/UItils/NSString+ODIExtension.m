//
//  NSString+ODIExtension.m
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/27.
//  Copyright © 2020 odin. All rights reserved.
//

#import "NSString+ODIExtension.h"
#import "ODInstallHeader.h"

@implementation NSString (ODIExtension)

+ (NSString *)currentUserId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_USERIDKEY];
}

+ (NSString *)upUserId{
    return [[NSUserDefaults standardUserDefaults] objectForKey:CURRENT_UPUSERIDKEY];
}

+ (void)setCurrentUserId:(NSString *)userId{
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:CURRENT_USERIDKEY];
}

+ (void)setUpUserId:(NSString *)userId{
     [[NSUserDefaults standardUserDefaults] setObject:userId forKey:CURRENT_UPUSERIDKEY];
}
@end
