/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/3.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>

@class TMSNodataHUD;

/**
 显示位置的枚举
 */
typedef enum {
    TMSNodataHUDTop,
    TMSNodataHUDCenter,
    TMSNodataHUDBottom
}TMSNodataHUDType;

@protocol TMSNodataHUDDelegate <NSObject>

@optional
- (void)nodataHUDDidClicked:(TMSNodataHUD*)view;

@end


@interface TMSNodataHUD : UIView

@property(nonatomic,weak)id<TMSNodataHUDDelegate>delegate;

/**提示图片*/
@property(nonatomic,weak)UIImageView *imageV;

/**提示内容*/
@property(nonatomic,weak)UILabel *desLabel;


/**位置*/
@property(nonatomic,assign)TMSNodataHUDType position;


/**
 *  没有数据 的提示
 *
 *  @param title     提示文字
 *  @param imageName 提示图片
 */
- (void)noDataHUD:(NSString*)title image:(NSString*)imageName;


@end
