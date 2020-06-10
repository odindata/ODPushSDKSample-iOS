//
//  OPushMessage.h
//  OdinPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OPushNotification.h"
#import "OPushCustomMessage.h"

/**
 消息类型
 */
typedef NS_ENUM(NSUInteger, OPushMessageType)
{
    OPushMessageTypeUDPNotify = 1, //UDP通知
    OPushMessageTypeCustom = 2, //UDP自定义消息
    OPushMessageTypeAPNs = 3, //APNs推送
    OPushMessageTypeLocal = 4, //本地推送
    OPushMessageTypeClicked = 5,//点击通知
};

/**
 消息对象
 */
@interface OPushMessage : NSObject

/**
 消息任务ID
 */
@property (nonatomic, copy) NSString *messageID;

/**
 消息类型
 */
@property (nonatomic, assign) OPushMessageType messageType;

/**
 消息内容
 */
@property (nonatomic, copy) NSString *content;

/**
 是否为及时消息，如果是定时消息，taskDate属性会有时间数据。
 */
@property (nonatomic, assign) BOOL isInstantMessage;

/**
 定时消息的发送时间
 */
@property (nonatomic, assign) NSTimeInterval taskDate;

/**
 额外的数据
 */
@property (nonatomic, strong) NSDictionary *extraInfomation;

/**
 当前服务器时间戳
 */
@property (nonatomic, assign) NSTimeInterval currentServerTimestamp;

@property (nonatomic, strong) NSNumber* iosProduction;

/**
当 OPushMessageType为OPushMessageTypeUDPNotify||OPushMessageTypeLocal时，这个字段才会有数据。
 */
@property (nonatomic, strong) OPushNotification *notification;

/**
当 OPushMessageType为OPushMessageTypeCustom时 这个字段才会有数据。
 */
@property (nonatomic, strong) OPushCustomMessage *customMessage;

/**
 当 OPushMessageType为OPushMessageTypeAPNs时，返回apns消息数据以及场景还原数据。
 当 OPushMessageType为OPushMessageTypeLocal时，返回场景还原数据。
 "odinpush_link_k" :点击Apns消息场景还原的控制器路径。
 "odinpush_link_v" :点击Apns消息场景还原的参数。
 */
@property (nonatomic, strong) NSDictionary *msgInfo;

/**
 *  字典转模型
 */
+ (instancetype)messageWithDict:(NSDictionary *)dict;

@end
