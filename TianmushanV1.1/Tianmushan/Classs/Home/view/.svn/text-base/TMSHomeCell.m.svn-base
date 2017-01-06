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

#import "TMSHomeCell.h"
#import "TianmushanAPI.h"
#import "TMSHomeMode.h"

@interface  TMSHomeCell()

/**<#注释#>*/
@property(nonatomic,weak)UIImageView *cover;

/**<#注释#>*/
@property(nonatomic,weak)UILabel *rightUpLabel;

/**<#注释#>*/
@property(nonatomic,weak)UIButton *number;

/**<#注释#>*/
@property(nonatomic,weak)UILabel *titleLabel;

/**<#注释#>*/
@property(nonatomic,weak)UIButton *createButton;

/**<#注释#>*/
@property(nonatomic,weak)UIImageView *coverlayer;


@end

@implementation TMSHomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *cover = [[UIImageView alloc] init];
        cover.contentMode = UIViewContentModeScaleAspectFill;
        cover.image = [UIImage imageNamed:@"default"];
        cover.clipsToBounds = YES;
        [self.contentView addSubview:cover];
        self.cover = cover;
    
        
        UILabel *rightUpLabel = [[UILabel alloc] init];
        rightUpLabel.textColor = [UIColor whiteColor];
        rightUpLabel.font = [UIFont systemFontOfSize:13];
        rightUpLabel.text = @"预览";
        rightUpLabel.textAlignment = NSTextAlignmentCenter;
        rightUpLabel.backgroundColor = [UIColorFromRGB(0x999999) colorWithAlphaComponent:0.7];
        [self.contentView addSubview:rightUpLabel];
        self.rightUpLabel = rightUpLabel;
        
        UIButton *number = [[UIButton alloc] init];
        number.layer.opacity = 0.7;
        number.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [number setImage:[UIImage imageNamed:@"watch"] forState:UIControlStateNormal];
        [number setTitle:@"0" forState:UIControlStateNormal];
        number.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        number.titleLabel.font = [UIFont systemFontOfSize:12];
        [number setTitleColor:CUSTOMCOLOR(68, 68, 68) forState:UIControlStateNormal];
        [self.contentView addSubview:number];
        self.number = number;
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = UIColorFromRGB(0x444444);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        
        UIButton *createButton = [[UIButton alloc] init];
        [createButton setTitle:@"去制作" forState:UIControlStateNormal];
        createButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [createButton addTarget:self action:@selector(createButtonClick) forControlEvents:UIControlEventTouchDown];
        [createButton setTitleColor:UIColorFromRGB(0x30C0AD) forState:UIControlStateNormal];
        [self.contentView addSubview:createButton];
        self.createButton = createButton;
        
        self.clipsToBounds = YES;
        
    }
    
    return self;
}


- (void)setHomeMode:(TMSHomeMode *)homeMode
{
    _homeMode = homeMode;
    
    self.titleLabel.text = homeMode.name;
    
    [self.number setTitle:[NSString stringWithFormat:@"%zd",homeMode.num] forState:UIControlStateNormal];
    
    [self.cover yy_setImageWithURL:[NSURL URLWithString:homeMode.imageUrl] placeholder:[UIImage imageNamed:@"default"] options:YYWebImageOptionSetImageWithFadeAnimation|YYWebImageOptionProgressive completion:nil];
    
    
}

#pragma mark createButtonClick
- (void)createButtonClick
{
    if ([self.delegate respondsToSelector:@selector(homeCell:createTideBtnClicked:)]) {
        [self.delegate homeCell:self createTideBtnClicked:self.homeMode];
    }

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    CGFloat rightw =50;
    CGFloat righth = 23;
    
    self.rightUpLabel.frame = CGRectMake(width-rightw, 0, rightw, righth);

    CGFloat titleh = 40;
    
    self.titleLabel.frame = CGRectMake(10, height - titleh, width*0.6, titleh);
    
    CGFloat btnw = width-width*0.6;
    self.createButton.frame = CGRectMake(width-btnw+3, self.titleLabel.top, btnw-3, 40);

    CGFloat numerw = 40;
    CGFloat numberh = 20;
    //获取字体的宽度
    if (self.homeMode.num) {
        
        CGFloat newW = [[NSString stringWithFormat:@"%zd",self.homeMode.num] getTextWidthWithMaxHeight:numberh fontSize:12];
        
        //如果文字的宽度超过最大的宽度 就改变宽度值
        if (newW > (numerw - 25)) {
            numerw = newW+25;
        }
        
    }
    
    self.number.frame = CGRectMake(width-numerw,height-titleh - numberh, numerw, numberh);

    CGFloat coverh = height - titleh;
    self.cover.frame = CGRectMake(0, 0, width, coverh);

}


@end
