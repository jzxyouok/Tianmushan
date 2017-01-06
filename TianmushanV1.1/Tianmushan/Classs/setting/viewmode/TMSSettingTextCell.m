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

#import "TMSSettingTextCell.h"
#import "TMSSettingText.h"
#import "TianmushanAPI.h"

@interface TMSSettingTextCell()

/**text*/
@property(nonatomic,weak)UILabel *title;

/**辅助视图*/
@property(nonatomic,weak)UILabel *rightText;

/**topline*/
@property(nonatomic,weak)CALayer* topline;

/**text*/
@property(nonatomic,weak)CALayer* bottomline;

/**imagev*/
@property(nonatomic,strong)UIImageView *imageV;

@end

@implementation TMSSettingTextCell

static NSString * const reuseIdentifier = @"TMSTextCellIdentifier";

+ (instancetype)cell:(UITableView *)tableView
{
    TMSSettingTextCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell = [[TMSSettingTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        CALayer *topline = [CALayer layer];
        topline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
        [self.contentView.layer addSublayer:topline];
        self.topline = topline;
        
//        UIImageView *imageV = [[UIImageView alloc] init];
//        [self.contentView addSubview:imageV];
//        self.imageV = imageV;
        
        UILabel *text = [[UILabel alloc] init];
        text.font = [UIFont systemFontOfSize:16];
        text.textColor = UIColorFromRGB(0x333333);
        [self.contentView addSubview:text];
        self.title = text;
        
        UILabel *rightText = [[UILabel alloc] init];
        rightText.textAlignment = NSTextAlignmentRight;
        rightText.font = [UIFont systemFontOfSize:13];
        rightText.textColor = UIColorFromRGB(0x999999);
        [self.contentView addSubview:rightText];
        self.rightText = rightText;
        
        
        CALayer *bottomline = [CALayer layer];
        bottomline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
        [self.contentView.layer addSublayer:bottomline];
        self.bottomline = bottomline;
    }
    
    return self;

}

- (void)setMode:(TMSSettingText *)mode
{
    _mode = mode;
    
//    self.imageV.image = [UIImage imageNamed:mode.icon];
    
    self.title.text = mode.text;
    
    if (mode.detail) {
        self.rightText.text = mode.detail;
    }
    
    if (mode.hiddenBottomline) {
        self.bottomline.hidden = YES;
    }else{
        self.bottomline.hidden = NO;
    }

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat margin = 13;
    
//    CGFloat imagew = height*0.45;
    CGFloat rightw = 50;

    
//    self.imageV.frame = CGRectMake(margin, (height-imagew)*0.5, imagew, imagew);
    
    self.title.frame = CGRectMake(margin, 0, width*0.4, height);
    
    self.rightText.frame = CGRectMake(width-rightw - margin, (height-rightw)*0.5, rightw, rightw);
    
    self.topline.frame = CGRectMake(0, 0, width, 0.5);
    
    self.bottomline.frame = CGRectMake(0, height-1, width, 0.5);

}


@end
