/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/9.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSMyReportGroup.h"
#import "TMSHomeMode.h"
#import "TianmushanAPI.h"


@implementation TMSMyReportGroup

- (void)setTemplates:(NSMutableArray *)templates
{
    if (templates==nil || templates.count<=0) {
        return;
    }
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSDictionary *dict in templates) {
        TMSHomeMode *model = [TMSHomeMode modalWithDict:dict];
        [tempArr addObject:model];
    }
    
    _templates = tempArr;
    
}

@end
