//
//  LCPush+Test.h
//  LCPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import "LCPush.h"

typedef NS_ENUM(NSInteger, OSendMessageType)
{
    OSendMessageTypeAPNs = 1,         //推送类型
    OSendMessageTypeCustom = 2,       //自定义消息类型
    OSendMessageTypeTimed = 3,        //定时通知类型
};

/**
 这个类仅”客户端发起推送接口“使用，不属于OdinPush的功能接口，开发者可以忽略。
 */
@interface LCPush (Test)

/**
 客户端发起推送接口
 
 @param msgType 消息类型
 @param content 模拟发送内容
 @param space 定时消息时间（仅对定时消息有效，单位分钟，默认值为1）
 @param isProduction 开否为生产环境（跟证书相关）
 @param extras 额外字段
 @param linkScheme 界面还原路径
 @param linkData 界面还原参数
 @param handler 结果
 */
+ (void)sendMessageWithMessageType:(OSendMessageType)msgType
                           content:(NSString *)content
                             space:(NSNumber *)space
           isProductionEnvironment:(BOOL)isProduction
                            extras:(NSDictionary *)extras
                        linkScheme:(NSString *)linkScheme
                          linkData:(NSString *)linkData
                            result:(void (^)(NSError *error))handler;

@end
