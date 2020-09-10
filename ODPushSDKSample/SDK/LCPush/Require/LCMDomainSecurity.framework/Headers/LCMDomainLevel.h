//
//  LCDomainLevel.h
//  LCDomainSecurity
//
//  Created by isec on 2019/12/23.
//  Copyright © 2019 isec. All rights reserved.
//

#ifndef ODDomainLevel_h
#define ODDomainLevel_h
//debug<info<warn<Error<Fatal
typedef enum : NSUInteger {
    LCMDomainLogLevelDebug,
    LCMDomainLogLevelInfo,
    LCMDomainLogLevelWarn,
    LCMDomainLogLevelError,
    LCMDomainLogLevelFatal ,
} LCMDomainLogLevel;


#endif /* ODDomainLevel_h */
