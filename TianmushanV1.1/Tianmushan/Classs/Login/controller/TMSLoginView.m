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
 ***************************************************************************/

#import "TMSLoginView.h"
#import "TianmushanAPI.h"


@implementation TMSLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        UIView *contentV = [[UIView alloc] init];
        contentV.backgroundColor = GLOBALCOLOR;
        [self addSubview:contentV];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textColor = UIColorFromRGB(0x333333);
        [contentV addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.textAlignment = NSTextAlignmentCenter;
        desLabel.font = [UIFont systemFontOfSize:14];
        desLabel.textColor = UIColorFromRGB(0x666666);
        [contentV addSubview:desLabel];
        self.desLabel = desLabel;
        
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = UIColorFromRGB(0xf0f0f0);
        [contentV addSubview:topLine];
        
        UIView *middleLine = [[UIView alloc] init];
        middleLine.backgroundColor = UIColorFromRGB(0xf0f0f0);
        [contentV addSubview:middleLine];
        
        UILabel *doBtn = [[UILabel alloc] init];
        doBtn.userInteractionEnabled = YES;
        doBtn.textAlignment = NSTextAlignmentCenter;
        doBtn.textColor =  UIColorFromRGB(0x30cdad);
        doBtn.font = [UIFont systemFontOfSize:15];
        doBtn.tag = 1;
        [contentV addSubview:doBtn];
        [doBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doBtnClick)]];
        self.doBtn = doBtn;
        
        
        UILabel *cancleBtn = [[UILabel alloc] init];
        cancleBtn.userInteractionEnabled = YES;
        cancleBtn.textAlignment = NSTextAlignmentCenter;
        cancleBtn.textColor =  UIColorFromRGB(0x30cdad);
        cancleBtn.font = [UIFont systemFontOfSize:15];
        cancleBtn.tag = 0;
        [contentV addSubview:cancleBtn];
        [cancleBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleBtnClick)]];
        self.cancleBtn = cancleBtn;
        
        contentV.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthRatioToView(self,0.8).heightIs(140);
        contentV.sd_cornerRadius = @5;
        
        titleLabel.sd_layout.topEqualToView(contentV).offset(15).leftEqualToView(contentV).rightEqualToView(contentV).heightIs(17);
        
        desLabel.sd_layout.topSpaceToView(titleLabel,15).leftEqualToView(contentV).rightEqualToView(contentV);
        desLabel.sd_layout.autoHeightRatio(0);
        
        cancleBtn.sd_layout.leftEqualToView(contentV).bottomEqualToView(contentV).widthRatioToView(contentV,0.49).heightIs(40);
        
        doBtn.sd_layout.rightEqualToView(contentV).bottomEqualToView(contentV).widthRatioToView(contentV,0.49).heightIs(40);
        
        topLine.sd_layout.leftEqualToView(contentV).bottomSpaceToView(doBtn,1).widthRatioToView(contentV,1).heightIs(1);
        
        middleLine.sd_layout.centerXEqualToView(contentV).widthIs(1).topSpaceToView(topLine,0).bottomEqualToView(contentV);


    }
    
    return self;
}

+ (instancetype)loginViewTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle
{
    TMSLoginView *loginview = [[TMSLoginView alloc] init];
    loginview.titleLabel.text = title;
    loginview.desLabel.text = message;
    
    loginview.doBtn.text = otherButtonTitle;
    
    loginview.cancleBtn.text = cancelButtonTitle;

    loginview.delegate = delegate;
    
    return loginview;
    
}

+ (instancetype)loginViewTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitle:(NSString *)otherButtonTitle boldTag:(NSInteger)tag
{
    TMSLoginView *loginview = [[TMSLoginView alloc] init];
    if (tag==0) {
        loginview.cancleBtn.font = [UIFont boldSystemFontOfSize:15];
    }else if(tag==1) {
        loginview.doBtn.font = [UIFont boldSystemFontOfSize:15];
    }
    loginview.titleLabel.text = title;
    loginview.desLabel.text = message;
    
    loginview.doBtn.text = otherButtonTitle;
    loginview.cancleBtn.text = cancelButtonTitle;
    
    loginview.delegate = delegate;
    return loginview;
}

+ (instancetype)loginViewTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle  cancleBtnColor:(UIColor*)cancleBtnColor otherButtonTitle:(NSString *)otherButtonTitle otherButtonColor:(UIColor*)otherButtonColor
{
    
    TMSLoginView *loginview = [[TMSLoginView alloc] init];

    loginview.titleLabel.text = title;
    loginview.desLabel.text = message;
    
    loginview.doBtn.text = otherButtonTitle;
    loginview.cancleBtn.text = cancelButtonTitle;
    
    loginview.doBtn.textColor = otherButtonColor;
    loginview.cancleBtn.textColor = cancleBtnColor;
    
    loginview.delegate = delegate;
    return loginview;
}


- (void)doBtnClick
{
    if ([self.delegate respondsToSelector:@selector(loginView:didClickedbuttonIndex:)]) {
        [self.delegate loginView:self didClickedbuttonIndex:self.doBtn.tag];
    }
}

- (void)cancleBtnClick
{
    if ([self.delegate respondsToSelector:@selector(loginView:didClickedbuttonIndex:)]) {
        [self.delegate loginView:self didClickedbuttonIndex:self.cancleBtn.tag];
    }
}


- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    
}

- (void)hide
{
    [self removeFromSuperview];
}

@end
