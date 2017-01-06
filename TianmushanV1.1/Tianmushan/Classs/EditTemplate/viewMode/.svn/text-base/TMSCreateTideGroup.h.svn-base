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
#import "TMSHomeMode.h"

@interface TMSCreateTideGroup : NSObject

/**最大选择张数*/
@property(nonatomic,assign)NSInteger maxNum;

/**是否是相册类目*/
@property(nonatomic,assign,getter=isPhotoCategory)BOOL photoCategory;

/**照片对应的配置信息数组*/
@property(nonatomic,strong)TMSHomeImageMode *photoConfigs;

/**照片个数*/
@property(nonatomic,strong)NSMutableArray* photos;

/**indexpath 当前显示的是第几行 就表示是第几步*/
@property(nonatomic,assign)NSInteger indexRow;

/**标题*/
@property(nonatomic,strong)NSString *title;

/**当前组输入的文字*/
@property(nonatomic,strong)NSString* inputText;

/**当前组的高度*/
@property(nonatomic,assign)CGFloat height;

/**当前组里面的图片在服务器显示的尺寸*/
@property(nonatomic,assign)CGSize imageSize;

@end
