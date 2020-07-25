//
//  NotificationService.m
//  ODPushService
//
//  Created by nathan on 2020/6/28.
//  Copyright © 2020 odin. All rights reserved.
//

#import "NotificationService.h"
#import <OdinPushSDK/OdinPushServiceExtension.h>

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    NSLog(@"bestAttemptContent.userInfo = %@", self.bestAttemptContent.userInfo);
    NSString * url = [request.content.userInfo objectForKey:@"image"];
    if (url == nil) {
        url = request.content.userInfo[@"video"];
    }
    if (url == nil) {
        url = request.content.userInfo[@"mp3"];
    }
    if (url == nil) {
        url = request.content.userInfo[@"attachment"];
    }
    
    if (url) {
        [OdinPushServiceExtension handelNotificationServiceRequestUrl:url withAttachmentsComplete:^(NSArray *attachments, NSError *error) {
            self.bestAttemptContent.attachments = attachments;
            self.contentHandler(self.bestAttemptContent);
        }];
    } else {
        self.contentHandler(self.bestAttemptContent);
    }
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
