//
//  Net_Interface.h
//  AFN-Test
//
//  Created by Mai on 16/11/17.
//  Copyright © 2016年 WL. All rights reserved.
//

//
//  Net_Interface.m
//  AFN-Test
//
//  Created by Mai on 16/11/17.
//  Copyright © 2016年 WL. All rights reserved.
//

#import "NetWorkRequest.h"
#import "AFHTTPSessionManager.h"

@implementation NetWorkRequest

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (NetWorkRequest *)sharedInstance
{
    static NetWorkRequest *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[NetWorkRequest alloc]init];
    });
    return _sharedInstance;
}
- (void)GETUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!_sessionGetManager) {
        _sessionGetManager  = [AFHTTPSessionManager manager];
        //设置请求格式
        _sessionGetManager.responseSerializer = [AFJSONResponseSerializer serializer];;
    }
    // 设置请求超时时间
    //    _sessionGetManager.requestSerializer.timeoutInterval = 10;
    //设置允许接受返回数据类型
        _sessionGetManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/plain", @"text/javascript", nil];
    NSLog(@"%@",url);
    [_sessionGetManager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"********%@",error);
        //        if (task.state == 2) {
        //            return ;
        //        }
        failure(error);
    }];
    
}
- (void)POSTUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!_sessionPostManager) {
        _sessionPostManager = [AFHTTPSessionManager manager];
        //接收数据类型 --->JSON
        _sessionPostManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
    }
    //接收数据类型 --->JSON
    _sessionPostManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //访问超时时间
    _sessionPostManager.requestSerializer.timeoutInterval = 30.f;
    
    _sessionPostManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",nil];
    NSLog(@"url =%@",url);
    
    [_sessionPostManager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
    
}
- (void)HeaderPOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters data:(NSData *)data keyname:(NSString *)namestr success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!_sessionHeaderPostManager) {
        _sessionHeaderPostManager = [AFHTTPSessionManager manager];
        _sessionHeaderPostManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _sessionHeaderPostManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionHeaderPostManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/plain", @"text/javascript", nil];
        
    }
    
    if ([url isEqualToString:@""]) {
        return;
    }
    NSLog(@"%@",url);
    [_sessionHeaderPostManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data != nil) {
            int nowdate = [[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]intValue];
            NSString *fileName = [NSString stringWithFormat:@"%d.jpg",nowdate];
            [formData appendPartWithFileData:data name:namestr fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject%@",responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (task.state == 2) {
            return ;
        }
        failure(error);
        
    }];
    
}

- (void)importVoicePOSTUrl:(NSString *)url parameters:(NSDictionary *)parameters data:(NSData *)data success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!_sessionHeaderPostManager) {
        _sessionHeaderPostManager = [AFHTTPSessionManager manager];
        _sessionHeaderPostManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    _sessionHeaderPostManager.requestSerializer.timeoutInterval = 30.f;
    _sessionHeaderPostManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/plain", @"text/javascript", nil];
    NSLog(@"%@",url);
    [_sessionHeaderPostManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (data != nil) {
            int nowdate = [[NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]intValue];
            NSString *fileName = [NSString stringWithFormat:@"%d.wav",nowdate];
            [formData appendPartWithFileData:data name:@"file_wav" fileName:fileName mimeType:@"audio/x-wav"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);

    }];
    
}


-(void)PUTUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if (!_sessionPUTManager) {
        _sessionPUTManager  = [AFHTTPSessionManager manager];
        _sessionPUTManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    _sessionPUTManager.requestSerializer.timeoutInterval = 30.f;
    _sessionPUTManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json",@"text/plain", @"text/javascript", nil];
    NSLog(@"%@",url);
    [_sessionPUTManager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (task.state == 2) {
            NSLog(@"此时状态为2");
            return ;
        }
        failure(error);
    }];
    
}

- (void)requestDeleteWithURLStr:(NSString *)urlStr paramDic:(NSDictionary *)paramDic finish:(void(^)(id responseObject))finish enError:(void(^)(NSError *error))enError {
    
    if (!_sessionDELETEManager) {
        _sessionDELETEManager = [AFHTTPSessionManager manager];
        _sessionDELETEManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    _sessionDELETEManager.requestSerializer.timeoutInterval = 30.f;

    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _sessionDELETEManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
//
    // 设置请求头
    
    [_sessionDELETEManager DELETE:urlStr parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        enError(error);
    }];
}

- (void)cancelRequest
{
    if (_sessionGetManager) {
        [_sessionGetManager.operationQueue cancelAllOperations];
        _sessionGetManager = nil;
    }
    if (_sessionPostManager) {
        [_sessionPostManager.operationQueue cancelAllOperations];
        _sessionPostManager = nil;
    }
    if (_sessionHeaderPostManager) {
        [_sessionHeaderPostManager.operationQueue cancelAllOperations];
        _sessionHeaderPostManager = nil;
    }
    
}
- (void)dealloc {
    _sessionGetManager = nil;
    _sessionPostManager = nil;
    _sessionHeaderPostManager = nil;
}
@end


