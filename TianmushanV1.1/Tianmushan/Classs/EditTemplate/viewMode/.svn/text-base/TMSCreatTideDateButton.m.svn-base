/**************************************************************************
 *
 *  Created by shushaoyong on 2016/12/2.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSCreatTideDateButton.h"


@interface TMSCreatTideDateButton()

/**清除按钮*/
@property(nonatomic,weak)UIButton *clearButton;

/**占位文字*/
@property(nonatomic,strong)NSString *placholderStr;

@end

@implementation TMSCreatTideDateButton


- (void)setTextField:(UITextField *)textField
{
    _textField = textField;
    
    self.placholderStr = textField.placeholder;
    
    [textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.clearButton.hidden = NO;

}

- (void)dealloc
{
    [self.textField removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *clearButton = [[UIButton alloc] init];
        clearButton.contentEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
        clearButton.contentMode = UIViewContentModeScaleAspectFit;
        [clearButton setImage:[UIImage imageNamed:@"textclearbutton"] forState:UIControlStateNormal];
        [clearButton addTarget:self action:@selector(clearButtonClick) forControlEvents:UIControlEventTouchDown];
        clearButton.hidden = YES;
        [self addSubview:clearButton];
        self.clearButton = clearButton;
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    self.clearButton.frame = CGRectMake(self.frame.size.width - self.frame.size.height, 0, self.frame.size.height, self.frame.size.height);
    
}

- (void)clearButtonClick
{
    self.textField.text = @"";
    
    self.textField.placeholder = self.placholderStr;
    
    self.clearButton.hidden = YES;
    
}

@end
