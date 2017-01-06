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

#pragma mark  登录的通知

NSString* const KRAPI_MEMBER_LOGINNOTIFICATION = @"KRAPI_MEMBER_LOGINNOTIFICATION"; // 登录成功的通知

NSString* const KRAPI_MEMBER_LOGINERRORNOTIFICATION = @"KRAPI_MEMBER_LOGINERRORNOTIFICATION"; // 登录失败的通知

NSString* const KRAPI_MEMBER_LOGINOUTNOTIFICATION = @"KRAPI_MEMBER_LOGINOUTNOTIFICATION"; // 退出登录的通知

NSString* const KRAPI_WEIXINSHARESUCCESSNOTIFICATION = @"KRAPI_WEIXINSHARESUCCESSNOTIFICATION"; //分享成功的通知

NSString* const KRAPI_WEIXINSHAREERRORNOTIFICATION = @"KRAPI_WEIXINSHAREERRORNOTIFICATION"; // 分享失败的通知

NSString* const KRAPI_SKIPEDITCONTROLLERNOTIFICATION = @"KRAPI_SKIPEDITCONTROLLERNOTIFICATION"; //跳转到模板编辑页面的通知


#pragma mark API接口
NSString* const API_Baseurl        = @"http://cb.test.adwangchao.com/" ;          // API基础URL
//NSString* const API_Baseurl        = @"http://192.168.1.40:8082/" ;          // API基础URL

NSString* const KRAPI_Checkversion = @"tianmuMount/rest/checkversion/ios";   //检查新版本
NSString* const KRAPI_WXlogin      = @"tianmuMount/rest/user/login/wx";      //微信登录
NSString* const KRAPI_home         = @"tianmuMount/rest/template/list/";     //首页
NSString* const KRAPI_Mynews       = @"tianmuMount/rest/user/my/";;          //我的潮报
NSString* const KRAPI_Imgcheck     = @"tianmuMount/rest/user/img/check";;    //检查图片
NSString* const KRAPI_Imgupload    = @"tianmuMount/rest/user/img/upload";;   //上传图片
NSString* const KRAPI_CreateH5     = @"tianmuMount/rest/user/create";;       //生成h5
NSString* const KRAPI_DeleteReport = @"tianmuMount/rest/delete/my/";         //删除我的潮报
NSString* const KRAPI_ReportCategory=@"tianmuMount/rest/get/catalog";        //模版分类
NSString* const KRAPI_FeedBack     = @"tianmuMount/rest/save/option";        //意见反馈
NSString* const KRAPI_CreateFinish = @"tianmuMount/rest/finish/production";  //生成潮报完成

#pragma mark 提醒消息相关
NSString* const KRAPI_NOdataErrorMsg = @"加载失败";                     //没有数据提醒文字
NSString* const KRAPI_CatelogNOdataErrorMsg = @"当前类目下无模板";       //当前类目没有数据提醒文字

#pragma mark 缓存相关
NSString* const TMSPhotoGroupsCacheName  = @"TMSPhotoGroupsCacheName" ; //用户的相册缓存沙盒名称
