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

#import "TMSUMTool.h"
//#import <UMSocialCore/UMSocialCore.h>

@implementation TMSUMTool

+ (instancetype) sharedInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/**
 *  注册第三方id
 */
- (void)reister
{
//    //打开调试日志
//    [[UMSocialManager defaultManager] openLog:YES];
//    
//    //设置友盟appkey
//    [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
//    
//    // 获取友盟social版本号
//    NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
//    
//    //设置微信的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa54dd0b8694767dc" appSecret:@"937053cbc27856ead7b1a3ee82a08278" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置分享到QQ互联的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"100424468"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    //设置新浪的appKey和appSecret
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    // 如果不想显示平台下的某些类型，可用以下接口设置
    //    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_LaiWangTimeLine),@(UMSocialPlatformType_Qzone)]];
}


@end
