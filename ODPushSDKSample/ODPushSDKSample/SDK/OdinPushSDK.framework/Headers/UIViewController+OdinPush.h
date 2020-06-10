//
//  UIViewController+OdinPush.h
//  OdinPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (OdinPush)

/**
 设置控制器路径

 @return 控制器路径
 */
+ (NSString *)OdinPushPath;

/**
 初始化场景参数

 @param params 场景参数
 @return 控制器对象
 */
- (instancetype)initWithOdinPushScene:(NSDictionary*)params;

@end
