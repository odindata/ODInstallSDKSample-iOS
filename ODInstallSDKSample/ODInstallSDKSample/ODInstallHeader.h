//
//  ODInstallHeader.h
//  ODInstallSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#ifndef ODInstallHeader_h
#define ODInstallHeader_h

#define ODIHost @"http://www.odinanalysis.com/api/channel"
#define ODIUserPath @"/odin/channel-app/query-demo-lower-user-id"
#define ODIUserStatPath @"/odin/channel-report/query-channel-report"

#define StaH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavH self.navigationController.navigationBar.frame.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PUBLICSCALE SCREEN_WIDTH / 375.0

#define CHANNEL_CODE @"001"

#define CURRENT_USERIDKEY @"ODISample_userId"
#define CURRENT_UPUSERIDKEY @"ODISample_UpUserId"
#endif /* ODInstallHeader_h */
