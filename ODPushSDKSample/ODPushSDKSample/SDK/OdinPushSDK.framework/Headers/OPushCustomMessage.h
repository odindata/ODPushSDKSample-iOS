//
//  OPushCustomMessage.h
//  OdinPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 自定义消息类型
 */
@interface OPushCustomMessage : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 自定义消息类型，如 text 文本
 */
@property (nonatomic, copy) NSString *type;

/**
 *  字典转模型
 */
+ (instancetype)customMessageWithDict:(NSDictionary *)dict;

@end
