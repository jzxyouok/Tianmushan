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

/**

 catalog = activity;
 count = 0;
 createTime = 1477917967;
 h5Url = "C:/Users/zjtachao/Desktop/TianmuMount/template/activity/1/index.html";
 id = 1;
 imageUrl = "C:/Users/zjtachao/Desktop/TianmuMount/template/activity/1/\U8bf7\U67ec.png";
 more = 0;
 name = "\U8001\U864e";
 num = 1500;
 
 height = 230;
 width = 270;
 
 */
#import <UIKit/UIKit.h>


#pragma mark  图片模型
@interface TMSHomeImageMode : NSObject

/**图片宽度*/
@property(nonatomic,assign)CGFloat width;

/**图片高度*/
@property(nonatomic,assign)CGFloat height;

/**图片的id标识*/
@property(nonatomic,copy)NSString *ID;

/**图片的描述信息*/
@property(nonatomic,copy)NSString *name;

/**需要的图片张数*/
@property(nonatomic,assign)NSInteger picNum;

@end

#pragma mark  模板数据模型
@interface TMSHomeMode : NSObject

/**是否是相册类目*/
@property(nonatomic,assign,getter=isPhotoCategory)BOOL photoCategory;

/**模板名称*/
@property(nonatomic,copy)NSString *name;

/**模板封面图地址*/
@property(nonatomic,copy)NSString *imageUrl;

/**模板h5地址*/
@property(nonatomic,copy)NSString *h5Url;

/**模板分享的标题*/
@property(nonatomic,copy)NSString *title;

/**模板分享的描述信息*/
@property(nonatomic,copy)NSString *desc;

/**模板的浏览量*/
@property(nonatomic,assign)NSInteger num;

/**模板名称*/
@property(nonatomic,copy)NSString *ID;

/**模板类目名称*/
@property(nonatomic,copy)NSString *catalog;

/**模板创建时间*/
@property(nonatomic,copy)NSString *createTime;

/**模板图片的尺寸数组*/
@property(nonatomic,strong)NSArray *resolution;

/**模板个数*/
@property(nonatomic,copy)NSString *count;

/**模版对应的图片张数*/
@property(nonatomic,assign)NSInteger picSize;

/**当前模板的音乐列表*/
@property(nonatomic,strong)NSArray *musicList;

/**模板需要的配置文件*/
@property(nonatomic,strong)NSArray *configList;

/**模板需要的配置文件*/
@property(nonatomic,strong)NSArray *configModelList;

/**是否最佳*/
@property(nonatomic,assign)BOOL more;

/**我的潮报需要用到的字段***/
/**是否长按了*/
@property(nonatomic,assign,getter=isLongPress)BOOL longPress;

/**模板id*/
@property(nonatomic,copy)NSString *reportid;

@end

#pragma mark  配置文件模型
@interface TMSHomeConfig : NSObject

/**当前的标题*/
@property(nonatomic,copy)NSString *title;

/**长文本 内容文本 数组 */
@property(nonatomic,strong)NSArray *longText;

/**图片数组*/
@property(nonatomic,strong)NSArray *picture;

/**短文本数组 输入框*/
@property(nonatomic,strong)NSArray *shortText;

@end

#pragma mark  音乐模型
/**
 name = "\U5317\U56fd\U4e4b\U6625";
 time = "2:10";
 url = "http://cb.adwangchao.com/template/games/1/music/0000003.mp3";
 */
@interface TMSHomeMusic : NSObject

/**音乐名称*/
@property(nonatomic,copy)NSString *name;

/**音乐时长*/
@property(nonatomic,copy)NSString *time;

/**音乐地址*/
@property(nonatomic,copy)NSString *url;

/**是否选中了当前的模型歌曲*/
@property(nonatomic,assign,getter=isSelected)BOOL selected;

/**是否选中了当前的模型音乐*/
@property(nonatomic,assign,getter=isSelectedMusic)BOOL selectedMusic;

@end
