//
// LCDomain.h
// LCDomain
//
//  Created by isec on 2019/8/23.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LCMDomainLevel.h"

@interface LCMDomain : NSObject

/// 同步获取可用的域名
+ (NSString *)getValidateDomain;

/// @brief 异步获取可用的域名, 回调到主线程
/// @param completion 异步回调block
+ (void)getValidateDomainCompletion:(void(^)(NSString *validateDomain))completion;

+ (void)setLogLevel:(LCMDomainLogLevel)logLevel;

+ (NSString *)sdkVersion;

@end

