/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/29.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSMusicTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation TMSMusicTool

static AVPlayer *player;
static AVPlayerItem * currentItem;

+ (void)playerWithMusicUrl:(NSString *)url
{
    if (url==nil) {
        return;
    }
        
    if (player==nil) {
        
        NSURL * musicurl  = [NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:musicurl];
        player = [[AVPlayer alloc]initWithPlayerItem:songItem];
        currentItem = songItem;
        [player play];
    }else{
        
        NSURL *musicurl  = [NSURL URLWithString: [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        AVPlayerItem * songItem = [[AVPlayerItem alloc]initWithURL:musicurl];
        currentItem = songItem;
        [player replaceCurrentItemWithPlayerItem:songItem];

    }
    
   
}
/**
 *  播放当前的音乐
 */
+ (void)rePlayeMusic
{
    if (player==nil) {
        return;
    }
    
    [player play];
}

+ (void)stopMusic
{
    if (player==nil) {
        return;
    }
    
    [player pause];
}


+ (void)invaildeMusic
{
    [player pause];
    currentItem = nil;
    player = nil;
}

@end
