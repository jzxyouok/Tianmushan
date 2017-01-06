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

#import "TMSHomeMode.h"
#import "NSObject+TMSModel.h"

@implementation TMSHomeImageMode

@end

@implementation TMSHomeMode

- (void)setResolution:(NSArray *)resolution
{
    if (resolution==nil || resolution.count<=0) {
        return;
    }
    NSMutableArray *tempA = [NSMutableArray array];
    for (NSDictionary *dict in resolution) {
        TMSHomeImageMode *img = [TMSHomeImageMode modalWithDict:dict];
        [tempA addObject:img];
    }
    _resolution =tempA;
}


/**
 *  处理音乐数组
 *
 *  @param musicList <#musicList description#>
 */
- (void)setMusicList:(NSArray *)musicList
{
    if (musicList.count<=0) {
        return;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSDictionary *dict in musicList) {
        TMSHomeMusic *mode = [TMSHomeMusic modalWithDict:dict];
        [temp addObject:mode];
    }
    
    _musicList = temp;
}


/**
 *  处理配置信息数组
 *
 *  @param configList <#configList description#>
 */
- (void)setConfigList:(NSArray *)configList
{
    
    _configList = configList;
    
//    NSMutableArray *temp = [NSMutableArray array];
//    
//    for (NSDictionary *dict in configList) {
//        TMSHomeConfig *mode = [TMSHomeConfig modalWithDict:dict];
//        [temp addObject:mode];
//    }
//    
//    _configList = temp;
}

@end


@implementation TMSHomeConfig

/**
 *  处理图片数组
 */
- (void)setPicture:(NSArray *)picture
{
    if (picture.count<=0) {
        return;
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    
    for (NSDictionary *dict in picture) {
        TMSHomeImageMode *mode = [TMSHomeImageMode modalWithDict:dict];
        [temp addObject:mode];
    }
    
    _picture = [temp copy];
    
}

@end

@implementation TMSHomeMusic
@end
