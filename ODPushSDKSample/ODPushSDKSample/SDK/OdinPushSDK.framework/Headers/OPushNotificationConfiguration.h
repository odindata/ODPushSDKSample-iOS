//
//  OPushNotificationConfiguration.h
//  OdinPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 通知权限
 */
typedef NS_OPTIONS(NSUInteger, OPushAuthorizationOptions)
{
    OPushAuthorizationOptionsNone = 0,               //不提醒
    OPushAuthorizationOptionsBadge = (1 << 0),       //角标提醒
    OPushAuthorizationOptionsSound = (1 << 1),       //声音提醒
    OPushAuthorizationOptionsAlert = (1 << 2),       //弹框提醒
};

/**
 通知配置
 */
@interface OPushNotificationConfiguration : NSObject

/**
 权限选项
 */
@property (nonatomic, assign) OPushAuthorizationOptions types;

/**
 注入的类别，iOS10以及以上使用UNNotificationCategory，iOS10以下使用UIUserNotificationCategory。
 */
@property (nonatomic, strong) NSArray *categories;

@end
