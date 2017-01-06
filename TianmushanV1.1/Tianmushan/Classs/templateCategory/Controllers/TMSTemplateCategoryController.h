/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/24.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>

#pragma mark 控制器
@interface TMSTemplateCategoryController : UICollectionViewController

@end

#pragma mark cell
@class TMSCategoryItem;
@interface TMSTemplateCategoryCell : UICollectionViewCell
@property(nonatomic,strong)TMSCategoryItem *category;
@end


#pragma mark 布局对象
@interface TMSTemplateCategoryLayout : UICollectionViewFlowLayout
@end
