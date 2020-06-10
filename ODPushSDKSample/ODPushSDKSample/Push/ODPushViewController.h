//
//  ODPNoteViewController.h
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/25.
//  Copyright © 2020 odin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OdinPushSDK/OdinPush+Test.h>
NS_ASSUME_NONNULL_BEGIN

@interface ODPushViewController : UIViewController

- (instancetype)initWithTitle:(NSString *)title
         description:(NSString *)description
         messageType:(OSendMessageType)type
         isTimedPush:(BOOL)isTimedPush;

- (instancetype)initWithTitle:(NSString *)title
description:(NSString *)description
messageType:(OSendMessageType)type
isTimedPush:(BOOL)isTimedPush tag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
