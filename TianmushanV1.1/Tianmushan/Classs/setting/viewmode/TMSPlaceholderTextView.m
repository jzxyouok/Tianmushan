/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/30.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSPlaceholderTextView.h"
#import "TianmushanAPI.h"

@interface TMSPlaceholderTextView()

/**占位文本*/
@property(nonatomic,weak)UIButton *placeholderL;

@end

@implementation TMSPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:14];
        
        UIButton *placeholderL = [[UIButton alloc] init];
        placeholderL.titleLabel.numberOfLines = 0;
        placeholderL.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        placeholderL.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
        [self addSubview:placeholderL];
        self.placeholderL = placeholderL;
        
        [placeholderL addTarget:self action:@selector(placeholderLClick) forControlEvents:UIControlEventTouchDown];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}


- (void)placeholderLClick
{
    [self becomeFirstResponder];
}

- (void)textDidChange:(NSNotification *)note
{
    
    self.placeholderL.hidden = self.hasText;
      
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = CGRectZero;
    
    rect.origin.x = 8;
    
    rect.origin.y = 8;
    
    rect.size.width = self.frame.size.width -16;
    
    rect.size.height = self.frame.size.height -16;
    
    self.placeholderL.frame = rect;

}

#pragma mark - setter
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self.placeholderL setTitle:placeholder forState:UIControlStateNormal];
    
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self.placeholderL setTitleColor:placeholderColor forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderL.titleLabel.font = font;
}


@end
