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

#import "TMSSettingArrowCell.h"
#import "TMSSettingArrow.h"
#import "TianmushanAPI.h"

@interface TMSSettingArrowCell()

/**text*/
@property(nonatomic,weak)UILabel *title;

/**辅助视图*/
@property(nonatomic,weak)UIImageView *rightView;

/**topline*/
@property(nonatomic,weak)CALayer* topline;

/**text*/
@property(nonatomic,weak)CALayer* bottomline;

/**imagev*/
@property(nonatomic,strong)UIImageView *imageV;

@end

@implementation TMSSettingArrowCell

static NSString * const reuseIdentifier = @"TMSArrowCellIdentifier";

+ (instancetype)cell:(UITableView *)tableView
{
    TMSSettingArrowCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[TMSSettingArrowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CALayer *topline = [CALayer layer];
        topline.backgroundColor =[UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
        [self.contentView.layer addSublayer:topline];
        self.topline = topline;
        
//        UIImageView *imageV = [[UIImageView alloc] init];
//        [self.contentView addSubview:imageV];
//        self.imageV = imageV;
//        
        UILabel *text = [[UILabel alloc] init];
        text.font = [UIFont systemFontOfSize:16];
        text.textColor = UIColorFromRGB(0x333333);
        [self.contentView addSubview:text];
        self.title = text;
        
        UIImageView *accessoryView = [[UIImageView alloc] init];
        accessoryView.clipsToBounds = YES;
        [self.contentView addSubview:accessoryView];
        self.rightView = accessoryView;
        
        
        CALayer *bottomline = [CALayer layer];
        bottomline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
        [self.contentView.layer addSublayer:bottomline];
        self.bottomline = bottomline;
        
    }
    
    return self;
}

- (void)setMode:(TMSSettingArrow *)mode
{
    _mode = mode;
    
    
//    self.imageV.image = [UIImage imageNamed:mode.icon];

    
    self.title.text = mode.text;
    
    self.rightView.image = [UIImage imageNamed:mode.arrowIcon];
    
    if (mode.hiddenBottomline) {
        self.bottomline.hidden = YES;
    }else{
        self.bottomline.hidden = NO;
    }
    
    if (mode.hiddenArrow) {
        self.rightView.hidden = YES;
        self.title.textAlignment = NSTextAlignmentCenter;
    }else{
        self.rightView.hidden = NO;
        self.title.textAlignment = NSTextAlignmentLeft;
    }

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat margin = 13;
    
//    CGFloat imagew = height*0.45;
    CGFloat rightw = 8;

//    self.imageV.frame = CGRectMake(margin, (height-imagew)*0.5, imagew, imagew);
    
    self.title.frame = CGRectMake(margin, 0, width*0.4, height);

    self.title.frame = CGRectMake(CGRectGetMaxX(self.imageV.frame)+margin, 0, width*0.4, height);
    
    self.rightView.frame = CGRectMake(width-rightw - margin, (height-12)*0.5, rightw, 12);
    
    self.topline.frame = CGRectMake(0, 0, width, 1);

    self.bottomline.frame = CGRectMake(0, height-1, width, 1);
}


@end
