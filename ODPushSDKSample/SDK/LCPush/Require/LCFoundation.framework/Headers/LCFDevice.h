//
//  LCFDevice.h
//  LCFoundation
//
//  Created by nathan on 2019/6/10.
//  Copyright © 2019 OD. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 *  网络类型
 */
typedef NS_ENUM(NSUInteger, ODFNetworkType)
{
    /**
     *  无网咯
     */
    LCFNetworkTypeNone         = 0,
    /**
     *  蜂窝网络
     */
    LCFNetworkTypeCellular     = 2,
    /**
     *  WIFI
     */
    LCFNetworkTypeWifi         = 1,
    /**
     *  2G网络
     */
    LCFNetworkTypeCellular2G   = 3,
    /**
     *  3G网络
     */
    LCFNetworkTypeCellular3G   = 4,
    /**
     *  4G网络
     */
    LCFNetworkTypeCellular4G   = 5,
};


/**
 IP版本
 
 - LCFIPVersion4: IPv4
 - LCFIPVersion6: IPv6
 */
typedef NS_ENUM(NSUInteger, LCFIPVersion)
{
    LCFIPVersion4 = 0,
    LCFIPVersion6 = 1,
};


NS_ASSUME_NONNULL_BEGIN

@interface LCFDevice : NSObject
//################################# new ####################//

/// 应用appKey(奥丁平台的ODKey)
+ (NSString *)appKey;

/// 设备型号
+ (NSString *)deviceModel;

/// sdk类型
+ (NSString *)sdkType;

/**
 *  获取手机运营商代码
 *
 *  @return 手机运营商代码
 */
+ (NSString *)carrier;

/// 系统版本
+ (NSString *)osVersion;

/// 系统名称
+ (NSString *)os;

/// 屏幕宽
+ (NSString *)screenWidth;

/// 屏幕高
+ (NSString *)screenHeight;

/// 当前网络类型
+ (NSString *)networkType;

/// 设备品牌
+ (NSString *)brand;

/// 当前手机使用的语言
+ (NSString *)language;

/// 当前设备Id
+ (NSString *)deviceId;

/// distinctId（deviceId + boundlId）
+ (NSString *)distinctId;

/// 是否是模拟器
+ (BOOL)simulator;

/// idfv获取开发商Id
+ (NSString *)idfv;

/// idfa获取广告Id
+ (NSString *)idfa;

/// cpu类型
+ (NSString *)cpuType;

/// 产生时间
+ (NSString *)statTime;

/// 判断设备是否越狱，YES代表越狱，NO代表未越狱
+ (BOOL)hasJailBroken;

/// 当前时区
+ (NSString *)currentTimeZone;



/**
 *  获取手机运营商名称
 *
 *  @return 运营商名称
 */
+ (NSString *)carrierName;

/**
 *  iso码
 *
 *  @return iso
 */
+ (NSString *)isoCountryCode;

/**
 *  获取手机运营商国家码
 *
 *  @return 运营商国家码
 */
+ (NSString *)mobileCountryCode;

/**
 *  获取手机运营商网络编号
 *
 *  @return 运营商网络编号
 */
+ (NSString *)mobileNetworkCode;

/**
 *  获取无线局域网的服务集标识（WIFI名称）iOS12以上需要xcode配置wifi权限才能获取到 ios13需要获取地理位置
 *
 *  @return 服务集标识
 */
+ (NSString *)ssid;

/**
 *  获取基础服务集标识（站点的MAC地址）iOS12以上需要xcode配置wifi权限才能获取到
 *
 *  @return 基础服务集标识
 */
+ (NSString *)bssid;

/**
 *  与当前系统版本比较
 *
 *  @param other 需要对比的版本
 *
 *  @return < 0 低于指定版本； = 0 跟指定版本相同；> 0 高于指定版本
 */
+ (NSInteger)versionCompare:(NSString *)other;

/// 获取本机ip
/// @param preferIPv4 是否包含ipv6
+  (NSMutableArray *)getIPAddress:(BOOL)preferIPv4;

+ (NSMutableDictionary *)deviceBaseInfo:(NSString *)sdkType;

+ (NSString *)deviceBaseInfoString:(NSString *)sdkType;
@end

NS_ASSUME_NONNULL_END
