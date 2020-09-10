//
// LCFAESCipher.h
//  ODAnalysisSDK
//
//  Created by nathan on 2019/12/13.
//  Copyright © 2019 lc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSString * aesEncryptString(NSString *content, NSString *key);
NSString * aesDecryptString(NSString *content, NSString *key);

NSData * aesEncryptData(NSData *data, NSData *key);
NSData * aesDecryptData(NSData *data, NSData *key);

NS_ASSUME_NONNULL_END
