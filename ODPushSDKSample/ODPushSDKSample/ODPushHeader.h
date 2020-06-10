//
//  ODPushHeader.h
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/25.
//  Copyright © 2020 odin. All rights reserved.
//

#ifndef ODPushHeader_h
#define ODPushHeader_h

#define StaH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NavH self.navigationController.navigationBar.frame.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define PUBLICSCALE SCREEN_WIDTH / 375.0

#endif /* ODPushHeader_h */
