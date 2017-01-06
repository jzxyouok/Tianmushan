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

@class TMSContentViewController,TMSCategoryItem,TMSBaseViewController;

@protocol TMSContentViewControllerDelegate <NSObject>

@optional
- (void)contentViewController:(TMSContentViewController*)vc didClickedCell:(NSString*)url;

@end

/***控制器*/
@interface TMSContentViewController : TMSBaseViewController

/**item*/
@property(nonatomic,strong)TMSCategoryItem *item;

@end


/***布局对象*/
@interface TMSContentViewLayout : UICollectionViewFlowLayout

@end


/***头部view*/
@interface TMSContentViewControllerHeader : UICollectionReusableView

@end

