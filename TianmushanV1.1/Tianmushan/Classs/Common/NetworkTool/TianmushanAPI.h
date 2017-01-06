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
#import "UIBarButtonItem+TMSBarbutonItem.h"
#import "UIImage+SY.h"
#import "UIView+SY.h"
#import "NSDate+SY.h"
#import "NSString+SY.h"
#import "APIAgent.h"
#import "TMSCommonInfo.h"
#import "NSObject+TMSModel.h"
#import "TMSUser.h"
#import "UIView+TMSHUD.h"
#import <MJRefresh.h>
#import "YYWebImage.h"
#import "TMSCreateTideHeader.h"
#import "TMSCreateTideHelper.h"
#import <UIView+SDAutoLayout.h>
#import "TMSLoginView.h"


#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil

#endif


#define CurrentVersion  [[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"] floatValue]

#define weakifySelf  \
__weak __typeof(&*self)weakSelf = self;

#define strongifySelf \
__strong __typeof(&*weakSelf)self = weakSelf;


#define UserDefaults [NSUserDefaults standardUserDefaults]

#define GLOBALCOLOR UIColorFromRGB(0xf7f7f7)

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CUSTOMCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CUSTOMCOLORA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IS_IPHONE_7 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

#define IS_IPHONE_7P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define LINE_HEIGHT (1.0 / [UIScreen mainScreen].scale)

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

#define IsIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0 ? YES : NO)

#define IsIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >=9.0 ? YES : NO)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//用户信息
#define UserInfo [NSKeyedUnarchiver unarchiveObjectWithFile:[TMSUser getSaveInfoPath]]

#define kSyetemFont  @"HelveticaNeue-Light"

//日历控件的高度
#define CreateTideCanlenderHeight 352

#pragma mark  登录的通知
extern NSString* const KRAPI_MEMBER_LOGINNOTIFICATION;                 // 登录成功的通知
extern NSString* const KRAPI_MEMBER_LOGINERRORNOTIFICATION;   // 登录失败的通知

extern NSString* const KRAPI_MEMBER_LOGINOUTNOTIFICATION;              // 退出登录的通知
extern NSString* const KRAPI_WEIXINSHARESUCCESSNOTIFICATION;           //分享成功的通知
extern NSString* const KRAPI_WEIXINSHAREERRORNOTIFICATION;             // 分享失败的通知
extern NSString* const KRAPI_SKIPEDITCONTROLLERNOTIFICATION; //跳转到模板编辑页面的通知



#pragma mark API接口
extern NSString* const API_Baseurl;                   // API基础URL
extern NSString* const KRAPI_Checkversion;            //检查新版本
extern NSString* const KRAPI_WXlogin;                 //微信登录
extern NSString* const KRAPI_home;                    //首页
extern NSString* const KRAPI_Mynews;                  //我的潮报
extern NSString* const KRAPI_Imgcheck;                //检查图片
extern NSString* const KRAPI_Imgupload;               //上传图片
extern NSString* const KRAPI_Imgupload;               //上传图片
extern NSString* const KRAPI_CreateH5;                //生成h5
extern NSString* const KRAPI_DeleteReport;            //删除我的潮报
extern NSString* const KRAPI_ReportCategory;          //模版分类
extern NSString* const KRAPI_FeedBack;                //意见反馈
extern NSString* const KRAPI_CreateFinish;            //生成潮报完成

#pragma mark 提醒消息相关
extern NSString* const KRAPI_NOdataErrorMsg;          //没有数据提醒文字
extern NSString* const KRAPI_CatelogNOdataErrorMsg;   //当前类目没有数据提醒文字

#pragma mark 缓存相关
extern NSString* const TMSPhotoGroupsCacheName;            //用户的相册缓存沙盒名称


