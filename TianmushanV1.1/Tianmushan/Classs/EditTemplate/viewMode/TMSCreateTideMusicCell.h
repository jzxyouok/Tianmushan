/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/30.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import <UIKit/UIKit.h>


@class TMSHomeMusic,TMSCreateTideMusicCell;

@protocol TMSCreateTideMusicCellDelegate <NSObject>

@optional
/**
 *  点击了播放按钮
 *
 *  @param view  self
 *  @param music 当前view对应的音乐模型
 */
- (void)createTideMusicView:(TMSCreateTideMusicCell*)view didClickedPlaybtn:(TMSHomeMusic*)music;

/**
 *  选中了当前音乐
 *
 *  @param view  self
 *  @param music 当前view对应的音乐模型
 */
- (void)createTideMusicView:(TMSCreateTideMusicCell*)view didClickedSelectedbtn:(TMSHomeMusic*)music;


@end

@interface TMSCreateTideMusicCell : UITableViewCell


/**音乐模型*/
@property(nonatomic,strong)TMSHomeMusic *music;

/**delegate*/
@property(nonatomic,weak)id<TMSCreateTideMusicCellDelegate> delegate;


+ (instancetype)cellWithTableView:(UITableView*)tableview;


/**选择按钮*/
@property(nonatomic,weak)UIButton *iconButton;

/**播放按钮*/
@property(nonatomic,weak) UIButton *musicPlay;


///**
// *  初始化选中播放
// */
//- (void)firstPlay;
//
///**
// *  开始当前音乐的播放
// */
//- (void)startPlay;
//
///**
// *  停止当前音乐的播放
// */
//- (void)stopPlay;
//
///**
// *  当前的选中
// */
//- (void)selected;
//
///**
// *  取消当前的选中
// */
//- (void)deSelected;

/**
 *  选中了当前音乐
 *
 *  @param btn <#btn description#>
 */
- (void)selectedBtnClick;

/**
 *  点击了播放按钮
 *
 *  @param btn <#btn description#>
 */
- (void)musicPlayBtnClick;

@end

