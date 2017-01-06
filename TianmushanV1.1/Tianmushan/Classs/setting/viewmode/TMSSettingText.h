/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/21.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 * 
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <Foundation/Foundation.h>

@interface TMSSettingText : NSObject

/**icon*/
@property(nonatomic,strong)NSString *icon;

/**文字*/
@property(nonatomic,strong)NSString *text;

/**描述*/
@property(nonatomic,strong)NSString *detail;

/**是否隐藏下面的线*/
@property(nonatomic,assign,getter=isHiddenBottomline)BOOL hiddenBottomline;


/**对应的操作*/
@property(nonatomic,copy) void(^opration)();


@end
