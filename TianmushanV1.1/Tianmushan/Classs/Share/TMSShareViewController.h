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

#import <UIKit/UIKit.h>
#import "TMSShareModel.h"

@class TMSShareViewController;

@protocol TMSShareViewControllerDelegate <NSObject>

@optional
- (void)shareViewControllerDidCancled:(TMSShareViewController*)vc;
- (void)shareViewControllerDidSuccess:(TMSShareViewController*)vc;
- (void)shareViewControllerDidError:(TMSShareViewController*)vc;

@end

@interface TMSShareViewController : UIViewController

/**分享对应的模型数据*/
@property(nonatomic,strong)TMSShareModel *shareMode;

/**代理*/
@property(nonatomic,weak)id<TMSShareViewControllerDelegate> delegate;

@end
