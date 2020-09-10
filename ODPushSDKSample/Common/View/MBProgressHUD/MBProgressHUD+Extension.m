//
//  MBProgressHUD+Extension.m
//  ODPushDemo
//
//
//  Created by nathan on 2020/5/26.
//  Copyright © 2020 odin. All rights reserved.

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (void)showTitle:(NSString *)title
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    hud.bezelView.backgroundColor = [UIColor whiteColor];
    hud.detailsLabel.textColor = [UIColor blackColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.f];
    hud.detailsLabel.text = title;
    [hud hideAnimated:YES afterDelay:1.5f];
}

@end
