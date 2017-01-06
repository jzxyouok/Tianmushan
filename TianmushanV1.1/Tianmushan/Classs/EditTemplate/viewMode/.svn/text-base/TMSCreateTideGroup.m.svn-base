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

#import "TMSCreateTideGroup.h"
#import "NSString+SY.h"
#import "TianmushanAPI.h"

@implementation TMSCreateTideGroup

- (void)setIndexRow:(NSInteger)indexRow
{
    _indexRow = indexRow;
    
    //设置标题
    _title = [NSString numberToChineseCharacter:indexRow];

}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}
@end
