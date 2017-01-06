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

#import "TMSCommonInfo.h"

NSString * const TMSAccessToken = @"TMSAccessToken";
NSString * const TMSExpiration = @"TMSExpiration";
NSString * const TMSVersion = @"TMSVersion";
NSString * const TMSopenid = @"TMSopenid";
NSString * const TMSPhotoAuthorized = @"TMSPhotoAuthorized";



@implementation TMSCommonInfo

/**
 *  用户是否授权
 *
 *  @param token <#token description#>
 */
+ (void)setPhotoAuthorized:(BOOL)authorized
{
    [UserDefaults setBool:authorized forKey:TMSPhotoAuthorized];
    [UserDefaults synchronize];
}

/**
 *  用户是否授权
 *
 *  @return <#return value description#>
 */
+ (BOOL)photoAuthorized
{
    return [UserDefaults boolForKey:TMSPhotoAuthorized];
}


/**
 *  openid
 *
 *  @param token <#token description#>
 */
+ (void)setOpenid:(NSString*)openid
{
    [UserDefaults setObject:openid forKey:TMSopenid];
    [UserDefaults synchronize];
}

/**
 *  获取用户的openid
 *
 *  @return <#return value description#>
 */
+ (NSString*)Openid
{
    NSString *openid = [UserDefaults objectForKey:TMSopenid];
    
//    if ([openid isEqualToString:@""] || openid == nil) {
//        openid = @"12345";
//    }
//    
    return openid;
}


/**
 *  设置用户的token
 *
 *  @param token <#token description#>
 */
+ (void)setAccessToken:(NSString*)token
{
    [UserDefaults setObject:token forKey:TMSAccessToken];
    [UserDefaults synchronize];
}

/**
 *  获取用户的token
 *
 *  @return <#return value description#>
 */
+ (NSString*)accessToken
{
    
    NSString *accesstoken = [UserDefaults objectForKey:TMSAccessToken];
    
//    if ([accesstoken isEqualToString:@""] || accesstoken == nil) {
//        accesstoken = @"12345";
//    }
    return accesstoken;
}


/**
 *  设置用户的过期时间
 *
 *  @param token <#token description#>
 */
+ (void)setExpiration:(NSInteger)expiration
{
    [UserDefaults setInteger:expiration forKey:TMSExpiration];
    [UserDefaults synchronize];
}

/**
 *  获取用户的过期时间
 *
 *  @return <#return value description#>
 */
+ (NSInteger)expiration
{
    return [UserDefaults integerForKey:TMSExpiration];
}

/**
 *  设置当前软件版本号
 *
 *  @param token <#token description#>
 */
+ (void)setVersion:(float)version
{
    [UserDefaults setFloat:version forKey:TMSVersion];
    [UserDefaults synchronize];
}

/**
 *  获取当前软件版本号
 *
 *  @return <#return value description#>
 */
+ (float)version
{
    return [UserDefaults floatForKey:TMSVersion];

}




@end
