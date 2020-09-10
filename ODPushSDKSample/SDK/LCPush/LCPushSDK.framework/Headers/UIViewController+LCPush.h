//
//  UIViewController+OdinPush.h
//  OdinPush
//
//  Created by isec on 2019/4/11.
//  Copyright © 2019 isec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LCPush)

/**
 设置控制器路径

 @return 控制器路径
 */
+ (NSString *)lcPushPath;

/**
 初始化场景参数

 @param params 场景参数
 @return 控制器对象
 */
- (instancetype)initWithLCPushScene:(NSDictionary*)params;

@end
