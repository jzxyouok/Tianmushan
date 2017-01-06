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

#import "TMSTemplateTool.h"
#import "AFNetworking.h"
#import "PhotoItem.h"
#import "NSString+SY.h"
#import "TianmushanAPI.h"
#import "TMSUser.h"

@interface TMSTemplateTool()

@property(nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation TMSTemplateTool


+ (instancetype) sharedInstance{
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];

    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.operationQueue.maxConcurrentOperationCount = 5;
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    }
    return  self;
}

- (void)uploadTemplateImagesToUrl:(NSString *)url uploadName:(NSString *)uploadName withFileName:(NSString *)filePath withCompletionBlockWithProgress:(void (^)(NSProgress *))upProgress Success:(void (^)(NSDictionary *))success withFailure:(void (^)(NSString *))failure
{
    
    [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *URL = [ [API_Baseurl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *fileName = [NSString stringWithMD5OfFile:filePath];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:filePath]];

    NSDictionary *parames = @{@"imgname": fileName,@"userid": [TMSCommonInfo Openid]?[TMSCommonInfo Openid]:@"1234",@"Time":@((long long)[NSDate date].timeIntervalSince1970)};
    
    [_manager POST:URL parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            [formData appendPartWithFileData:data name:@"imgfile" fileName:[fileName stringByAppendingString:@".png"] mimeType:@"application/octet-stream"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        upProgress(uploadProgress);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dicObject = (NSDictionary *)responseObject;
        success(dicObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure([error localizedDescription]);
        
    }];

    
}


- (void)uploadTemplateImagesToUrl:(NSString *)url uploadName:(NSString *)uploadName withItem:(PhotoItem *)item withCompletionBlockWithProgress:(void (^)(NSProgress *pregress))upProgress Success:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure
{

    [_manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString *URL = [ [API_Baseurl stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *fileName = [NSString sha1HashOfFileAtPath:item.filePath];
    
    NSDictionary *parames = @{@"imgname": fileName,@"userid": [TMSCommonInfo Openid],@"Time":item.photoCreateDate?item.photoCreateDate:@"",@"gps":item.address?item.address:@""};
    
    [_manager POST:URL parameters:parames constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:item.filePath]];
            [formData appendPartWithFileData:data name:@"imgfile" fileName:[fileName stringByAppendingString:@".png"] mimeType:@"application/octet-stream"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
                
        upProgress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dicObject = (NSDictionary *)responseObject;
        success(dicObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure([error localizedDescription]);
        
    }];
}

@end
