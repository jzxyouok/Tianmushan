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

#import <UIKit/UIKit.h>
#import "TMSBaseViewController.h"
#import "TMSHomeMode.h"
#import "TMSShareModel.h"

@interface TMSDetailViewController : TMSBaseViewController

/**h5*/
@property(nonatomic,copy)NSString *url;

/**是否是模板预览*/
@property(nonatomic,assign,getter=isWatchTemplate)BOOL watchTemplate;

/**是否是我的潮报进入*/
@property(nonatomic,assign,getter=isMyReportJoin)BOOL myReportJoin;

/**模版对应的模型数据*/
@property(nonatomic,strong)TMSHomeMode *mode;

/**分享对应的模型数据*/
@property(nonatomic,strong)TMSShareModel *shareMode;


/**是否需要添加pan手势 以禁用右滑手势效果*/
@property(nonatomic,assign)BOOL panEabled;

@end
