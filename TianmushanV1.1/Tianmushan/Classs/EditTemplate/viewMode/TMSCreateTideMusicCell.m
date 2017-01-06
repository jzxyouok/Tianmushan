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

#import "TMSCreateTideMusicCell.h"
#import "TianmushanAPI.h"
#import "TMSHomeMode.h"
#import "TMSMusicTool.h"

@interface TMSCreateTideMusicCell()

/**音乐名*/
@property(nonatomic,weak)UILabel *titleLabel;

@end

@implementation TMSCreateTideMusicCell

static NSString * const identitier = @"TMSCreateTideMusicCell";

+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    TMSCreateTideMusicCell *cell = [tableview dequeueReusableCellWithIdentifier:identitier];
    if (cell==nil) {
        cell = [[TMSCreateTideMusicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identitier];
    }
    return cell;
    
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//        UIButton *iconButton = [[UIButton alloc] init];
//        [iconButton setImage:[UIImage imageNamed:@"selectedBtnNormal"] forState:UIControlStateNormal];
//        [iconButton setImage:[UIImage imageNamed:@"selectedBtnHighted"] forState:UIControlStateSelected];
//        [self addSubview:iconButton];
//        self.iconButton = iconButton;
//        iconButton.sd_layout.centerYEqualToView(self).leftEqualToView(self).offset(8).widthIs(14).heightIs(14);
//        
//        UIButton *doenBtn = [[UIButton alloc] init];
//        [doenBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchDown];
//        [self  addSubview:doenBtn];
//        doenBtn.sd_layout.centerYEqualToView(self).leftEqualToView(self).offset(13).widthRatioToView(self,0.5).heightIs(40);
//        
//        UILabel *titleLabel = [[UILabel alloc] init];
//        titleLabel.text = @"";
//        titleLabel.font = [UIFont systemFontOfSize:14];
//        titleLabel.textColor = UIColorFromRGB(0X444444);
//        [self  addSubview:titleLabel];
//        self.titleLabel = titleLabel;
//        titleLabel.sd_layout.leftSpaceToView(iconButton,8).centerYEqualToView(self).topEqualToView(self).bottomEqualToView(self).widthRatioToView(self,0.6);
//        
//        UIButton *musicPlay= [[UIButton alloc] init];
//        [musicPlay setImage:[UIImage imageNamed:@"musicplay"] forState:UIControlStateNormal];
//        [musicPlay setImage:[UIImage imageNamed:@"musicpause"] forState:UIControlStateSelected];
//        [musicPlay addTarget:self action:@selector(musicPlayBtnClick) forControlEvents:UIControlEventTouchDown];
//        [self  addSubview:musicPlay];
//        self.musicPlay = musicPlay;
//        musicPlay.sd_layout.centerYEqualToView(self).rightSpaceToView(self,13).widthIs(40).heightIs(40);
//        
//        UIImageView *musicIcon = [[UIImageView alloc] init];
//        musicIcon.image = [UIImage imageNamed:@"musicicon"];
//        [self  addSubview:musicIcon];
//        musicIcon.sd_layout.centerYEqualToView(self).rightSpaceToView(musicPlay,10).widthIs(24).heightIs(24);
//        
//        UIView *bottomline = [[UIView alloc] init];
//        bottomline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5];
//        [self  addSubview:bottomline];
//        bottomline.sd_layout.bottomEqualToView(self).offset(0).leftEqualToView(self).rightEqualToView(self).heightIs(1);
//    }
//    
//    return self;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *iconButton = [[UIButton alloc] init];
        [iconButton setImage:[UIImage imageNamed:@"selectedBtnNormal"] forState:UIControlStateNormal];
        [iconButton setImage:[UIImage imageNamed:@"selectedBtnHighted"] forState:UIControlStateSelected];
        [self.contentView addSubview:iconButton];
        self.iconButton = iconButton;
        iconButton.sd_layout.centerYEqualToView(self.contentView).leftEqualToView(self.contentView).offset(8).widthIs(14).heightIs(14);
        
        
        UIButton *doenBtn = [[UIButton alloc] init];
        doenBtn.backgroundColor = [UIColor clearColor];
        [doenBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchDown];
        [self.contentView  addSubview:doenBtn];
        doenBtn.sd_layout.centerYEqualToView(self.contentView).leftEqualToView(self.contentView).offset(0).widthRatioToView(self.contentView,0.5).heightIs(40);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = UIColorFromRGB(0X444444);
        [self.contentView  addSubview:titleLabel];
        self.titleLabel = titleLabel;
        titleLabel.sd_layout.leftSpaceToView(iconButton,8).centerYEqualToView(self.contentView).topEqualToView(self.contentView).bottomEqualToView(self.contentView).widthRatioToView(self,0.6);
        
        UIButton *musicPlay= [[UIButton alloc] init];
        [musicPlay setImage:[UIImage imageNamed:@"musicplay"] forState:UIControlStateNormal];
        [musicPlay setImage:[UIImage imageNamed:@"musicpause"] forState:UIControlStateSelected];
        [musicPlay addTarget:self action:@selector(musicPlayBtnClick) forControlEvents:UIControlEventTouchDown];
        [self.contentView  addSubview:musicPlay];
        self.musicPlay = musicPlay;
        musicPlay.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView,13).widthIs(40).heightIs(40);
        
        UIImageView *musicIcon = [[UIImageView alloc] init];
        musicIcon.image = [UIImage imageNamed:@"musicicon"];
        [self.contentView  addSubview:musicIcon];
        musicIcon.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(musicPlay,10).widthIs(24).heightIs(24);
        
        UIView *bottomline = [[UIView alloc] init];
        bottomline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5];
        [self.contentView  addSubview:bottomline];
        bottomline.sd_layout.bottomEqualToView(self.contentView).offset(0).leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(1);
        
    }
    
    return self;
}


- (void)setMusic:(TMSHomeMusic *)music
{
    _music = music;
    
    self.titleLabel.text = music.name;
    
    
}


#pragma mark event
/**
 *  选中了当前音乐
 *
 *  @param btn <#btn description#>
 */
- (void)selectedBtnClick
{
    self.iconButton.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(createTideMusicView:didClickedSelectedbtn:)]) {
        [self.delegate createTideMusicView:self didClickedSelectedbtn:self.music];
    }
    
}

/**
 *  点击了播放按钮
 *
 *  @param btn <#btn description#>
 */
- (void)musicPlayBtnClick
{
    self.musicPlay.selected = !self.musicPlay.selected;
    
    if (self.musicPlay.selected) {
    
        if ([self.delegate respondsToSelector:@selector(createTideMusicView:didClickedPlaybtn:)]) {
            [self.delegate createTideMusicView:self didClickedPlaybtn:self.music];
        }
    
    }else{
        
        //暂停音乐
        [TMSMusicTool stopMusic];
        
    }
   
    
    
      
}


@end
