/**************************************************************************
 *
 *  Created by shushaoyong on 2016/10/27.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 ***************************************************************************/

#import "APIAgent.h"

@implementation APIAgent
{
    NSString *normalString;
}

+ (APIAgent *) sharedInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


/**
 *  初始化方法
 *
 *  @return <#return value description#>
 */
- (id)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
        _manager.requestSerializer.timeoutInterval = 15;
//        _manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//        NSString *oldUserAgent =[_manager.requestSerializer.HTTPRequestHeaders objectForKey:@"User-Agent"];
//        NSString *userAgent = [@" 天目山/" stringByAppendingString:@"1.0"];
//        NSString *newUserAgent = [oldUserAgent stringByAppendingString:userAgent];
//        [_manager.requestSerializer setValue:@"ABCDEF" forHTTPHeaderField:@"ACCESS-TOKEN"];
//        [_manager.requestSerializer setValue:newUserAgent forHTTPHeaderField:@"User-Agent"];
    }
    return self;
}

/**
 *  获取完整的路径
 *
 *  @param url <#url description#>
 *
 *  @return <#return value description#>
 */
- (NSString*)fullPath:(NSString*)url
{
    return [[API_Baseurl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (void) postToUrl:(NSString *)url params:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary *responseObject))success withFailure:(void (^)(NSString *error))failure{

    
    [_manager POST:[self fullPath:url] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dicObject = (NSDictionary *)responseObject;
        if ([dicObject objectForKey:@"code"]){

        }else{
            if (dicObject == nil) {
                dicObject = @{};
            }
        }
        success(dicObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure([error localizedDescription]);

    }];
    
}



/**
 *  发送一个post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数 放在body体中
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
- (void) postToUrl:(NSString *)url bodyParams:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary *responseObject))success withFailure:(void (^)(NSString *error))failure
{
    
    
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [_manager POST:[self fullPath:url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        failure(error.localizedDescription);
        
        
    }];
    

    
}

- (void) postToUrl:(NSString *)url params:(NSDictionary *)params withFiles:(NSDictionary *)files withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure{
    
     [_manager POST:[self fullPath:url] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
         for (NSString *name in files) {
             NSString *path = files[name];
             [formData appendPartWithFileData: [NSData dataWithContentsOfFile: path] name:name fileName:[path lastPathComponent] mimeType: @"application/octet-stream"];
         }
 
     } progress:^(NSProgress * _Nonnull uploadProgress) {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSDictionary *dicObject = (NSDictionary *)responseObject;
         success(dicObject);
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         failure([error localizedDescription]);
     }];
    
}

- (void) getFromUrl:(NSString *)url params:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure{
    
    _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [_manager GET:[self fullPath:url] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dicObject = (NSDictionary *)responseObject;
        
        if ([[dicObject objectForKey:@"code"] longLongValue] == 0){
            
        }else{
            
            if (dicObject == nil) {
                dicObject = @{};
            }
        }
        
        success(dicObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure([error localizedDescription]);
    }];
    

    
    
}


- (void) getFromfullUrl:(NSString *)url params:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure{
    
    [_manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dicObject = (NSDictionary *)responseObject;
        
        if ([[dicObject objectForKey:@"code"] longLongValue] == 0){
            
        }else{
            
            if (dicObject == nil) {
                dicObject = @{};
            }
        }
        
        success(dicObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure([error localizedDescription]);
    }];
    
}



@end
