//
//  OdinPushServiceExtension.h
//  OdinPushServiceExtension
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OdinPushServiceExtension : NSObject

/**
 *  多媒体推送支持
 */
+ (void)handelNotificationServiceRequestUrl:(NSString *)requestUrl withAttachmentsComplete:(void (^)(NSArray *attachments, NSError *error))completeBlock;


@end
