/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/23.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 * 
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>

@class TMSHomeMode;

@interface TMSCreateTideHelper : NSObject

/**模版制作界面的所有内容数据*/
@property(nonatomic,strong)NSMutableDictionary *creatTideDatas;

/**模板对象*/
@property(nonatomic,strong)TMSHomeMode *mode;

/**
 *  获取内容视图中item的尺寸 根据手机屏幕尺寸不同 大小自动改变
 *
 *  @return <#return value description#>
 */
+ (CGSize)getItemSize;


/**
 * 获取内容视图的高度
 maxNum  是否达到了最大的上传个数
 */
+ (CGFloat)getContentViewHeight:(NSArray*)photos maxNum:(BOOL)maxNum;


/**
 *  上传图片到服务器
 *
 *  @param photoItems <#photoItems description#>
 */
- (void)uploadPhotoItems:(NSArray *)photoItems view:(UIView*)view;


@end
