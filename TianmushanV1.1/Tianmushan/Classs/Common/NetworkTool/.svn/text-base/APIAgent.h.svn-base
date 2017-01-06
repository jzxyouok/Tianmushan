
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

#import <Foundation/Foundation.h>
#import "TianmushanAPI.h"
#import "AFNetworking.h"

@interface APIAgent : NSObject

@property(nonatomic,strong)AFHTTPSessionManager *manager;


+ (APIAgent *) sharedInstance;

/**
 *  发送一个post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数 拼接在url后面
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
- (void) postToUrl:(NSString *)url params:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary *responseObject))success withFailure:(void (^)(NSString *error))failure;

/**
 *  发送一个post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数 放在body体中
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
- (void) postToUrl:(NSString *)url bodyParams:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary *responseObject))success withFailure:(void (^)(NSString *error))failure;



/**
 *  发送一个post请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param files   需要上传的文件地址
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
- (void) postToUrl:(NSString *)url params:(NSDictionary *)params withFiles:(NSDictionary *)files withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure;

/**
 *  发送一个get请求
 *
 *  @param url     请求地址
 *  @param params  请求参数
 *  @param success 请求成功block
 *  @param failure 请求失败block
 */
- (void) getFromUrl:(NSString *)url params:(NSDictionary *) params withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure;


- (void) getFromfullUrl:(NSString *)url params:(NSDictionary *)params withCompletionBlockWithSuccess:(void (^)(NSDictionary * responseObject))success withFailure:(void (^)(NSString *error))failure;

@end
