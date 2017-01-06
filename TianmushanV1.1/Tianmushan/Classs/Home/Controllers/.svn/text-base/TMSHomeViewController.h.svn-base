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

/***控制器对象*/
@interface TMSHomeViewController : TMSBaseViewController

@end

/**布局对象*/
@interface TMSHomeViewControllerLayout : UICollectionViewFlowLayout

@end


@class TMSHomeViewControllerHeader;

@protocol TMSHomeViewControllerHeaderDelegate <NSObject>

@optional
- (void)homeViewControllerHeaderDidCliked:(TMSHomeViewControllerHeader*)header;

@end
/***头部view*/
@interface TMSHomeViewControllerHeader : UICollectionReusableView

/**代理对象*/
@property(nonatomic,weak)id<TMSHomeViewControllerHeaderDelegate> delegate;


@end
