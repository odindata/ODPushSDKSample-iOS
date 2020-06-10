//
//  OdinDomain.h
//  odinDomain
//
//  Created by isec on 2019/8/23.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ODDomainLevel.h"

@interface OdinDomain : NSObject

+ (NSString *_Nullable)getValidateDomain;

+ (void)setLogLevel:(ODDomainLogLevel)logLevel;

@end

