//
//  LCSDK.h
//  LCFoundation
//
//  Created by nathan on 2020/7/14.
//  Copyright © 2020 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCSDK : NSObject

/**
 获取版本号

 @return 版本号
 */
+ (NSString * _Nonnull)sdkVersion;

/**
 获取应用标识
 
 @return 应用标识
 */
+ (NSString * _Nullable)appKey;

/**
 获取应用密钥

 @return 应用密钥
 */
+ (NSString * _Nullable)appSecret;

@end

NS_ASSUME_NONNULL_END
