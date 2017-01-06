//
//  TMSFeedBackViewController.m
//  TianmushanV1.1
//
//  Created by shushaoyong on 2016/11/25.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import "TMSFeedBackViewController.h"
#import "TianmushanAPI.h"
#import "SYLoadingView.h"

@interface TMSFeedBackViewController ()<UITextViewDelegate>

@property(nonatomic,strong) UITextView *textView;

/**占位控件*/
@property(nonatomic,weak)UILabel *placeholderLabel;

/**数字计数控件*/
@property(nonatomic,weak)UILabel *numberLabel;

/**提示view*/
@property(nonatomic,strong)UILabel *hudLabel;

/**提交按钮*/
@property(nonatomic,weak)UIButton *submitBtn;

@end

@implementation TMSFeedBackViewController

//提示框
- (UILabel *)hudLabel
{
    if (!_hudLabel) {
        _hudLabel = [[UILabel alloc] init];
        CGFloat hudw = 190;
        CGFloat hudH = 44;
        _hudLabel.frame = CGRectMake((self.view.width - hudw)*0.5, CGRectGetMinY(self.submitBtn.frame)-30-hudH, hudw, hudH);
        _hudLabel.hidden = YES;
        _hudLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _hudLabel.textColor = [UIColor whiteColor];
        _hudLabel.font = [UIFont systemFontOfSize:14];
        _hudLabel.textAlignment = NSTextAlignmentCenter;
        _hudLabel.layer.cornerRadius = 5;
        _hudLabel.layer.masksToBounds = YES;
        
        [self.view addSubview:_hudLabel];
    }
    return _hudLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化
    [self setUp];
    
    //添加点击事件
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];

}


/**
 *  点击屏幕退出键盘
 */
- (void)tap
{
    [self.view endEditing:YES];
}


/**
 *  初始化操作
 */
- (void)setUp
{
    self.view.backgroundColor = GLOBALCOLOR;
    
    UITextView *textView = [[UITextView alloc] init];
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.font = [UIFont systemFontOfSize:14];
    textView.frame = CGRectMake(0, 20, self.view.width, 180);
    [self.view addSubview:textView];
    self.textView = textView;
    
    //监听文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
    
    //占位控件
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.text = @"请输入反馈，我们将不断改进";
    placeholderLabel.textColor = UIColorFromRGB(0xC1C1C1);
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    placeholderLabel.frame = CGRectMake(5, 8, 0, 0);
    [placeholderLabel sizeToFit];
    [textView addSubview:placeholderLabel];
    self.placeholderLabel = placeholderLabel;
    
    
    //数字计数控件
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.text = @"最多还可以输入150字";
    numberLabel.textColor = UIColorFromRGB(0xB5B5B5);
    numberLabel.font = [UIFont systemFontOfSize:14];
    numberLabel.frame = CGRectMake(textView.width - 150, textView.height-30, 0, 0);
    [numberLabel sizeToFit];
    [textView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    

    //提交按钮
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textView.frame)+20, 150, 40)];
    submitBtn.centerX = self.view.centerX;
    submitBtn.layer.cornerRadius = 20;
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchDown];
    submitBtn.backgroundColor = UIColorFromRGB(0x30C0AD);
    [self.view addSubview:submitBtn];
    self.submitBtn = submitBtn;
    

}

#pragma mark UITextViewDelegate

#pragma mark
- (void)textDidChanged
{
    
    self.placeholderLabel.hidden = self.textView.text.length>0;
    
    
    if (self.textView.text.length>150) {
        
        
        self.textView.text = [self.textView.text substringToIndex:150];


        [self showMessage:@"最多可以输入150个字"];
        
    }
    
    //可以输入的字
    self.numberLabel.text = [NSString stringWithFormat:@"最多还可以输入%zd字",(150 - self.textView.text.length)];
    
    [self.numberLabel sizeToFit];
    
    
}

#pragma mark UITextviewDelegate   用户按了return键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [self submitBtnClick];
        
        return NO;
    }
    
    return YES;
}

- (void)showMessage:(NSString*)title
{
    self.submitBtn.userInteractionEnabled = NO;
    self.hudLabel.text = title;
    
    self.hudLabel.hidden = NO;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.hudLabel.hidden = YES;
        
        self.hudLabel = nil;
        
        self.submitBtn.userInteractionEnabled = YES;

        
    });
    
}


/**
 *  提交按钮点击
 */
- (void)submitBtnClick
{
    
    if (self.textView.text.length<=0) {
        
        [self showMessage:@"请输入反馈内容"];
        
        return;
        
    }else if(self.textView.text.length>150){
        
        [self showMessage:@"反馈内容不得超过150个字"];

        return;
        
    }else if (self.textView.text.length<15){
        
        [self showMessage:@"反馈内容不得少于15字"];
        
        return;
    }
    
    
    [self.view endEditing:YES];
    
    [SYLoadingView showLoadingView:self.view type:loadingViewCircle offset:CGSizeMake(0, -64)];
    
    NSDictionary *parames = @{@"option":[self.textView.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
    [[APIAgent sharedInstance] postToUrl:KRAPI_FeedBack bodyParams:parames withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        if ([responseObject[@"code"] longLongValue] ==0) {
            
            [SYLoadingView dismiss];
            
            [self showMessage:@"谢谢，您的反馈我们已经收到"];
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backItemClick];
            });
        }else{
            
            [SYLoadingView dismiss];

            [self showMessage:@"提交反馈失败 请稍后再试"];

        }
        
    } withFailure:^(NSString *error) {
        
        [SYLoadingView dismiss];

        [self showMessage:@"提交反馈失败 请稍后再试"];
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
