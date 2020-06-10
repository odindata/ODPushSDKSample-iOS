//
//  ODDomainLevel.h
//  OdinDomainSecurity
//
//  Created by isec on 2019/12/23.
//  Copyright © 2019 isec. All rights reserved.
//

#ifndef ODDomainLevel_h
#define ODDomainLevel_h
//debug<info<warn<Error<Fatal
typedef enum : NSUInteger {
    ODDomainLogLevelDebug,
    ODDomainLogLevelInfo,
    ODDomainLogLevelWarn,
    ODDomainLogLevelError,
    ODDomainLogLevelFatal ,
} ODDomainLogLevel;


#endif /* ODDomainLevel_h */
