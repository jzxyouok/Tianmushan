/**************************************************************************
 *
 *  Created by shushaoyong on 2016/10/28.
 *    Copyright © 2016年 踏潮. All rights reserved.
 * 
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <Foundation/Foundation.h>
#import "TianmushanAPI.h"

@interface TMSCommonInfo : NSObject


/**
 *  用户是否授权
 *
 *  @param token <#token description#>
 */
+ (void)setPhotoAuthorized:(BOOL)authorized;

/**
 *  用户是否授权
 *
 *  @return <#return value description#>
 */
+ (BOOL)photoAuthorized;


/**
 *  openid
 *
 *  @param token <#token description#>
 */
+ (void)setOpenid:(NSString*)openid;

/**
 *  获取用户的openid
 *
 *  @return <#return value description#>
 */
+ (NSString*)Openid;


/**
 *  设置用户的token
 *
 *  @param token <#token description#>
 */
+ (void)setAccessToken:(NSString*)token;

/**
 *  获取用户的token
 *
 *  @return <#return value description#>
 */
+ (NSString*)accessToken;


/**
 *  设置用户的过期时间
 *
 *  @param token <#token description#>
 */
+ (void)setExpiration:(NSInteger)expiration;

/**
 *  获取用户的过期时间
 *
 *  @return <#return value description#>
 */
+ (NSInteger)expiration;


/**
 *  设置当前软件版本号
 *
 *  @param token <#token description#>
 */
+ (void)setVersion:(float)version;

/**
 *  获取当前软件版本号
 *
 *  @return <#return value description#>
 */
+ (float)version;

@end
