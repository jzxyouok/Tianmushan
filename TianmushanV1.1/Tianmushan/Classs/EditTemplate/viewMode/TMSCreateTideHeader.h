//
//  TMSCreateTideHeader.h
//  editReport
//
//  Created by shushaoyong on 2016/11/23.
//  Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
//

#ifndef TMSCreateTideHeader_h
#define TMSCreateTideHeader_h

#define kCellMargin 10                   //cell间距

#define kCellWidth ([UIScreen mainScreen].bounds.size.width - 2*kCellMargin) //cell宽度

#define kCellTitleViewH 55              //潮报标题的高度

#define kCellSetupTitleH 30              //步骤标题的高度

#define kCellContentViewTitleH 20        //内容视图标题的高度。如 请上传多少张图片 标题

#define kCellContentViewBottomMargin 20  //内容视图底部的间距

#define kCellContentViewTitleH 20        //内容视图标题的高度。如 请上传多少张图片 标题

#define kCellContentViewCelllrMargin 3   //内容视图 cell左右的间距

#define kCellContentViewCelltbMargin 3   //内容视图 cell上下的间距

#define kCellContentViewItemRowMargin 5     //内容视图每个item之间的行间距

#define kCellContentViewItemClosMargin 5    //内容视图每个item之间的列间距

#define kCellBottomInputTopMargin 22     //底部输入框的顶部的间距

#define kCellBottomInputH 45             //输入框的高度 短文本框

#define kCellBottomContentInputH 100      //内容框的高度 长文本框

#define kCellBottomContentDefaultH 140   //内容视图默认的高度



#define kCellBottomInputBottomMargin 20  //底部输入框距离底部的间距


#define kCellContentViewCellDeleteBtnClickNotification @"kCellContentViewCellDeleteBtnClickNotification"//内容视图删除按钮点击通知

#define kCellContentViewCellAddBtnClickNotification @"kCellContentViewCellAddPhotoBtnClickNotification"//内容视图添加按钮点击通知

#define KRAPI_PHOTOVIEWCONTROLLER_DIDFINISHPHOTOS @"KRAPI_PHOTOVIEWCONTROLLER_DIDFINISHPHOTOS"//相册页面选择照片完成的通知

#define KRAPI_PHOTOVIEWCONTROLLER_WATCHPHOTOS @"KRAPI_PHOTOVIEWCONTROLLER_WATCHPHOTOS"//创建模版界面预览图片通知

#define KRAPI_CREATETIDE_FINISHEDNOTE @"KRAPI_CREATETIDE_FINISHEDNOTE"//生成相簿完成的通知

#define KRAPI_CREATETIDE_CLOSEPHOTOGROUPNOTE @"KRAPI_CREATETIDE_CLOSEPHOTOGROUPNOTE"//关闭相册组控制器的通知



#endif /* TMSCreateTideHeader_h */
