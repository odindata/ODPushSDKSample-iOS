//
//  LCFHttpService.h
//  LCFoundation
//
//  Created by nathan on 2020/6/5.
//  Copyright © 2020 LC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  HTTP返回事件
 *
 *  @param response     回复对象
 *  @param responseData 回复数据
 */
typedef void(^LCFHttpResultEvent) (NSHTTPURLResponse *response, NSData *responseData);

/**
 *  HTTP错误事件
 *
 *  @param error 错误信息
 */
typedef void(^LCFHttpFaultEvent) (NSError *error);



@interface LCFHttpService : NSObject

/**
 *    @brief    提交方式，默认为GET
 */
@property (nonatomic, copy) NSString *method;

/**
 超时时间
 */
@property (nonatomic) NSTimeInterval timeout;


- (id)initWithURLString:(NSString *)urlString;

/**
 *  添加HTTP头
 *
 *  @param header 名称
 *  @param value  值
 */
- (void)addHeader:(NSString *)header value:(NSString *)value;

/**
*  添加多个参数
*
*  @param parameters 参数集合
*/
- (void)addParameters:(id)parameters;
/**
 *  发送HTTP请求
 *
 *  @param urlString             请求地址
 *  @param method                请求方式
 *  @param parameters            请求参数
 *  @param headers               请求头集合
 *  @param resultHandler         返回回调
 *  @param faultHandler          错误回调
 *
 *  @return HTTP服务对象
 */
+ (LCFHttpService *)sendHttpRequestByURLString:(NSString *)urlString
                                         method:(NSString *)method
                                     parameters:(NSDictionary *)parameters
                                        headers:(NSDictionary *)headers
                                       onResult:(LCFHttpResultEvent)resultHandler
                                       onFault:(LCFHttpFaultEvent)faultHandler;

/**
 *  发送HTTP请求
 *
 *  @param urlString             请求地址
 *  @param method                请求方式
 *  @param parameters            请求参数
 *  @param headers               请求头集合
 *  @param timeout               请求超时
 *  @param resultHandler         返回回调
 *  @param faultHandler          错误回调
 *
 *  @return HTTP服务对象
 */
+ (LCFHttpService *)sendHttpRequestByURLString:(NSString *)urlString
                                         method:(NSString *)method
                                     parameters:(NSDictionary *)parameters
                                        headers:(NSDictionary *)headers
                                        timeout:(NSTimeInterval)timeout
                                       onResult:(LCFHttpResultEvent)resultHandler
                                       onFault:(LCFHttpFaultEvent)faultHandler;


/// 发送HTTP请求
/// @param resultHandler    返回回调
/// @param faultHandler     错误
- (void)sendRequestOnResult:(LCFHttpResultEvent)resultHandler
                    onFault:(LCFHttpFaultEvent)faultHandler;
@end

NS_ASSUME_NONNULL_END
