/**************************************************************************
 *
 *  Created by shushaoyong on 2016/10/31.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

/***
 
 clientId = "<null>";
 desc = "\U65b0\U589e\U56fe\U7247\U526a\U5207\U529f\U80fd\U2026\U2026";
 downloadurl = "http:/baidu.com";
 refreshId = "<null>";
 tokenId = "<null>";
 version = "1.1";
 
 */
#import <UIKit/UIKit.h>

@interface TMSUpdateVersion : NSObject

/**version*/
@property(nonatomic,strong)NSString *version;
/**下载地址*/
@property(nonatomic,strong)NSString *downloadurl;
/**描述*/
@property(nonatomic,strong)NSString *desc;

@end
