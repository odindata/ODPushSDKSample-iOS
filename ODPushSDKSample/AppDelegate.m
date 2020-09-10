//
//  AppDelegate.m
//  ODPsuhSDKSample
//
//  Created by nathan on 2020/5/25.
//  Copyright © 2020 odin. All rights reserved.
//

#import "AppDelegate.h"
#import "ODPHomeViewController.h"
#import <IQKeyboardManager.h>
#import "WebViewController.h"
#import <LCPushSDK/LCPushSDK.h>
#import "ODPAlertViewController.h"
#import "ODNavigationViewController.h"
#import <LCFoundation/LCFoundation.h>
#import <LCMDomainSecurity/LCMDomain.h>
@interface AppDelegate ()<ODPAlertViewControllerDelegate>

@property (nonatomic, strong) ODPAlertViewController *alertVC;
@property (nonatomic, strong) UIWindow *alertWindow;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%@",[LCSDK sdkVersion]);
     NSLog(@"%@",[LCMDomain sdkVersion]);
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    ODNavigationViewController *navVc = [[ODNavigationViewController alloc]initWithRootViewController:[ODPHomeViewController new]];
    self.window.rootViewController = navVc;

    IQKeyboardManager.sharedManager.enable = YES;
    
    
    #ifdef DEBUG
        [LCPush setAPNsForProduction:NO];
    #else
        [LCPush setAPNsForProduction:YES];
    #endif

    LCPushNotificationConfiguration *con = [[LCPushNotificationConfiguration alloc] init];

    con.types = OPushAuthorizationOptionsSound|OPushAuthorizationOptionsAlert|OPushAuthorizationOptionsBadge;

    [LCPush setupNotification:con];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveMessage:) name:LCPushDidReceiveMessageNotification object:nil];

    return YES;
}

- (void)didReceiveMessage:(NSNotification *)notification
{
    LCPushMessage *message = notification.object;
    switch (message.messageType) {
        case OPushMessageTypeCustom: {
            self.alertVC = [[ODPAlertViewController alloc] initWithTitle:@"收到推送" content:message.content];
            self.alertVC.delegate = self;
            
            _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            _alertWindow.windowLevel = [UIApplication sharedApplication].keyWindow.windowLevel + 1;
            _alertWindow.userInteractionEnabled = YES;
            _alertWindow.rootViewController = self.alertVC;
            [_alertWindow makeKeyAndVisible];
        }
            break;
        case OPushMessageTypeClicked:{
            NSString *link = message.msgInfo[@"urlkey"];
            if (link) {
                UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
                WebViewController *webVC = [[WebViewController alloc] init];
                webVC.url = link;
                [nav pushViewController:webVC animated:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)selectOKWithData:(id)data
{
    if (_alertWindow)
    {
        [_alertWindow resignKeyWindow];
        _alertWindow.hidden = YES;
        _alertWindow = nil;
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    if (![deviceToken isKindOfClass:[NSData class]]) return;
    const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"deviceToken：%@",hexToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error);
}
@end
