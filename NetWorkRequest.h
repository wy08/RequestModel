//
//  Net_Interface.h
//  AFN-Test
//
//  Created by Mai on 16/11/17.
//  Copyright © 2016年 WL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface  NetWorkRequest: NSObject

@property(nonatomic, strong)AFHTTPSessionManager *sessionGetManager;
@property(nonatomic, strong)AFHTTPSessionManager *sessionPostManager;
@property(nonatomic, strong)AFHTTPSessionManager *sessionHeaderPostManager;
@property(nonatomic, strong)AFHTTPSessionManager *sessionPUTManager;
@property(nonatomic, strong)AFHTTPSessionManager *sessionPATCHManager;
@property(nonatomic, strong)AFHTTPSessionManager *sessionDELETEManager;

+ (NetWorkRequest *)sharedInstance;

- (void)cancelRequest;
/**!
 @brief GET 请求
 @param parameters 传入的参数
 @param success 调用接口成功后返回一个id类型值
 @param failure 调用接口失败后返回一个错误描述
 @return Dictiont
 */
- (void)GETUrl:(NSString *)url parameters:(NSDictionary *)parameters
       success:(void (^)(id responseObject))success
       failure:(void (^)(NSError *error))failure;
/**!
 @brief POST 请求
 @param parameters 传入的参数
 @param success 调用接口成功后返回一个id类型值
 @param failure 调用接口失败后返回一个错误描述
 */
- (void)POSTUrl:(NSString *)url parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
/**!
 @brief POST 上存头像专用接口
 @param parameters 传入的参数
 @param data 上存头像的文件
 @param success 调用接口成功后返回一个id类型值
 @param failure 调用接口失败后返回一个错误描述
 */
- (void)HeaderPOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters
                 data:(NSData *)data
              keyname:(NSString *)namestr
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

/**!
 @brief POST 上传语音
 @param parameters 传入的参数
 @param data 音频data
 @param success 调用接口成功后返回一个id类型值
 @param failure 调用接口失败后返回一个错误描述
 */

- (void)importVoicePOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters
                      data:(NSData *)data
                   success:(void (^)(id))success
                   failure:(void (^)(NSError *))failure;


- (void)PUTUrl:(NSString *)url parameters:(NSDictionary *)parameters
       success:(void(^)(id responseObject))success
       failure:(void(^)(NSError *error))failure;

- (void)requestDeleteWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError;


@end


