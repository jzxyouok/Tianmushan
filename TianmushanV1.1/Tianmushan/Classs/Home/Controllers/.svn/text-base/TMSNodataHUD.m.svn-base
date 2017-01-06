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

#import "TMSNodataHUD.h"
#import "TianmushanAPI.h"

@interface TMSNodataHUD()

/**<#注释#>*/
@property(nonatomic,weak)UIButton *doenBtn;

@end

@implementation TMSNodataHUD

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = GLOBALCOLOR;
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about"]];
        [self addSubview:imageV];
        self.imageV = imageV;
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.text = @"加载失败......";
        desLabel.textAlignment = NSTextAlignmentCenter;
        desLabel.textColor = UIColorFromRGB(0x8a8a8a);
        desLabel.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:desLabel];
        self.desLabel = desLabel;
        
        UIButton *doenBtn = [[UIButton alloc] init];
        [doenBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [doenBtn setTitleColor:UIColorFromRGB(0x8a8a8a) forState:UIControlStateNormal];
        [doenBtn addTarget:self action:@selector(doenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        doenBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        doenBtn.layer.borderColor = UIColorFromRGB(0x8a8a8a).CGColor;
        doenBtn.layer.borderWidth = 1;
        doenBtn.layer.cornerRadius = 5;
        doenBtn.layer.masksToBounds = YES;
        
        [self addSubview:doenBtn];
        self.doenBtn = doenBtn;
        
        self.position = TMSNodataHUDCenter;
        
    }
    
    return self;
}


- (void)noDataHUD:(NSString *)title image:(NSString *)imageName
{
    self.desLabel.text = title;
    self.desLabel.font = [UIFont systemFontOfSize:14];
    if (imageName) {
        self.imageV.image = [UIImage imageNamed:imageName];
    }
    self.doenBtn.hidden = YES;
    
}

- (void)doenBtnClick
{
    if ([self.delegate respondsToSelector:@selector(nodataHUDDidClicked:)]) {
        [self.delegate nodataHUDDidClicked:self];
    }
}

- (void)setPosition:(TMSNodataHUDType)position
{
    _position = position;
    
    [self setNeedsLayout];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    

    CGFloat desw =  self.width*0.85;
    
    if (self.position == TMSNodataHUDCenter) {
        
        self.doenBtn.size = CGSizeMake(120, 30);
        
        self.doenBtn.center = self.center;
        
        self.desLabel.frame = CGRectMake((self.width-desw)*0.5, CGRectGetMinY(self.doenBtn.frame)-50-40,desw, 40);
        
        self.imageV.frame = CGRectMake(0, CGRectGetMinY(self.desLabel.frame)-100, 80, 80);
        
        self.imageV.centerX = self.centerX;
    
    }else if (self.position == TMSNodataHUDTop){
        
        self.imageV.frame = CGRectMake(0, 30, 80, 80);
        
        self.imageV.centerX = self.centerX;
        
        self.desLabel.frame = CGRectMake((self.width-desw)*0.5, CGRectGetMaxY(self.imageV.frame)+10,desw, 40);
        
        self.doenBtn.size = CGSizeMake(120, 30);
        
        self.doenBtn.top = CGRectGetMaxY(self.desLabel.frame)+10;
        self.doenBtn.centerX = self.centerX;
        
        
        
    }else if (self.position == TMSNodataHUDBottom){
    
        self.doenBtn.size = CGSizeMake(120, 30);
        
        self.doenBtn.centerX = self.centerX;
        self.doenBtn.top = self.height - 40;
        
        self.desLabel.frame = CGRectMake((self.width-desw)*0.5, CGRectGetMinY(self.doenBtn.frame)-40,desw, 40);
        
        self.imageV.frame = CGRectMake(0, CGRectGetMinY(self.desLabel.frame)-90, 80, 80);
        
        self.imageV.centerX = self.centerX;
        

    }
 
    
    
}


@end
