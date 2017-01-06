/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/10.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>
#import "TMSBaseViewController.h"

@class TMSNoLoginViewController;

@protocol TMSNoLoginViewControllerDelegate <NSObject>

- (void)noLoginViewControllerLoginSuccess:(TMSNoLoginViewController*)vc;

@end

@interface TMSNoLoginViewController : TMSBaseViewController

/**登录成功之后的是否需要跳转到编辑页面*/
@property(nonatomic,weak)id<TMSNoLoginViewControllerDelegate> delegate;

@end
