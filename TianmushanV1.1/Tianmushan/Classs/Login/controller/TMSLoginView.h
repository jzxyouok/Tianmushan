/**************************************************************************
 *
 *  Created by shushaoyong on 2016/12/12.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 
 UIAlertView *loginV = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你还没有登录 快去登录吧" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitles:@"立即登录", nil];

 
 
 ***************************************************************************/

#import <UIKit/UIKit.h>


@class TMSLoginView;

@protocol TMSLoginViewDelegate <NSObject>

@optional

- (void)loginView:(TMSLoginView*)view didClickedbuttonIndex:(NSInteger)index;

@end

@interface TMSLoginView : UIView

+ (instancetype)loginViewTitle:(NSString*)title message:(NSString*)message delegate:(id)delegate cancelButtonTitle:(NSString*)cancelButtonTitle  otherButtonTitle:(NSString*)otherButtonTitle;

+ (instancetype)loginViewTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle boldTag:(NSInteger)tag;

+ (instancetype)loginViewTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle  cancleBtnColor:(UIColor*)cancleBtnColor otherButtonTitle:(NSString *)otherButtonTitle otherButtonColor:(UIColor*)otherButtonTitle;



@property(nonatomic,weak)id<TMSLoginViewDelegate>delegate;

@property(nonatomic,weak)UILabel *titleLabel;

@property(nonatomic,weak) UILabel *desLabel;

@property(nonatomic,weak) UILabel *doBtn;

@property(nonatomic,weak)UILabel *cancleBtn;

- (void)show;

- (void)hide;

@end
