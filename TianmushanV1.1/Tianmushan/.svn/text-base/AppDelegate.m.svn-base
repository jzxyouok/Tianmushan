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

#import "AppDelegate.h"
#import "TMSChooseRootVC.h"
#import "WXApiImpl.h"
#import "APIAgent.h"
#import "WXApiImpl.h"
#import "YYCache.h"
#import "YYWebImageManager.h"
#import "TMSPhotoGroupViewController.h"
#import "TMSNavigationController.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化设置
    [self initSetup];
    
//    int cacheSizeMemory = 4*1024*1024; // 4MB
//    
//    int cacheSizeDisk = 32*1024*1024; // 32MB
//    
//    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
//    [NSURLCache setSharedURLCache:sharedCache];
    
    
    return YES;
}




//内存警告时的处理：
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
    [[[YYWebImageManager sharedManager].cache memoryCache] removeAllObjects];
    [[[YYWebImageManager sharedManager].cache diskCache] removeAllObjects];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
}


#pragma mark 初始化
- (void)initSetup
{
    /***微信注册*/
    [[WXApiImpl sharedInstance] registerAppid];
    
    //开始监控网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];

    //设置状态栏
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    //创建window
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

//    TMSNavigationController *nav = [[TMSNavigationController alloc] initWithRootViewController:[[TMSPhotoGroupViewController alloc] init]];
//    self.window.rootViewController = nav;

    self.window.rootViewController = [TMSChooseRootVC chooseRootController];

    [self.window makeKeyAndVisible];
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 微信登录 分享相关
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.scheme isEqualToString:@"wxa54dd0b8694767dc"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiImpl sharedInstance]];
    }else{
        return YES;
    }
}

-  (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.scheme isEqualToString:@"wxa54dd0b8694767dc"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiImpl sharedInstance]];
    }else{
        return YES;
    }
}



@end
