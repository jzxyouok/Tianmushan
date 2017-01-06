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

#import "TMSNoLoginViewController.h"
#import "TianmushanAPI.h"
#import "WXApi.h"
#import "TMSHomeViewController.h"
#import "TMSNavigationController.h"
#import "WXApiImpl.h"
#import "TMSTabBarController.h"

@interface TMSNoLoginViewController ()<WXApiDelegate,UIApplicationDelegate,UIAlertViewDelegate>

/**微信登录*/
@property(nonatomic,weak)UIButton *wxBtn;

/**随便看看*/
@property(nonatomic,weak)UIButton *desLabel;

/**背景view*/
@property(nonatomic,weak)UIImageView *bg;

/**是否点击了随便看看 改变窗口的跟控制器*/
@property(nonatomic,assign,getter=isDesLabelClicked)BOOL desLabelClicked;

@end

@implementation TMSNoLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUp];
    [self addObserver];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.isDesLabelClicked) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:CUSTOMCOLOR(46, 46, 46)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor clearColor]]];
    }
    
}


#pragma mark
/**
 *  初始化界面
 */
- (void)setUp
{
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.image = [UIImage imageNamed:@"bg"];
    [self.view addSubview:bg];
    self.bg = bg;
    
    CGFloat height = 40;
    UIButton *wxBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-68-5-height, 175, height)];
    wxBtn.centerX= self.view.centerX;
    [wxBtn addTarget:self action:@selector(wxBtnClick) forControlEvents:UIControlEventTouchUpInside];
    wxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    wxBtn.adjustsImageWhenHighlighted = NO;
    wxBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [wxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateReserved];
    [wxBtn setImage:[UIImage imageNamed:@"weixinlogin"] forState:UIControlStateNormal];
    [wxBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    wxBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    wxBtn.layer.borderWidth = 1;
    wxBtn.transform = CGAffineTransformMakeScale(0, 0);
    wxBtn.layer.cornerRadius = 20;
    [self.view addSubview:wxBtn];
    self.wxBtn = wxBtn;
    
    UIButton *desLabel = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-68, 175, 40)];
    desLabel.centerX= self.view.centerX;
    desLabel.titleLabel.font = [UIFont systemFontOfSize:16];
    [desLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateReserved];
    [desLabel addTarget:self action:@selector(desLabelClick) forControlEvents:UIControlEventTouchUpInside];
    [desLabel setTitle:@"我先随便逛逛" forState:UIControlStateNormal];
    [self.view addSubview:desLabel];
    self.desLabel = desLabel;

    
    
    //检查用户是否已经安装微信 没有安装就隐藏微信登录按钮
    if ([WXApi isWXAppInstalled] ==0) {
        
        self.wxBtn.hidden = YES;
        
    }else{

        [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:1.8 initialSpringVelocity:30 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.wxBtn.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }

    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)]];
}

-(void)pan{}

#pragma mark
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];
}


#pragma mark
- (void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 微信登录
- (void)wxBtnClick {
    
    [[WXApiImpl sharedInstance] requestOAuth];
}

#pragma mark 随便看看
- (void)desLabelClick
{
    
    //设置点击了随便看看按钮
    self.desLabelClicked = YES;
    
    TMSTabBarController *tabbar = [[TMSTabBarController alloc] init];
    tabbar.modalTransitionStyle =  UIModalTransitionStyleCrossDissolve;
    [self presentViewController:tabbar animated:YES completion:^{
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
    }];
    
}


#pragma mark notification
-(void)loginSuccess
{
    
    NSLog(@"loginSuccessloginSuccessloginSuccess");
    
    [self.view showSucess:@"登录成功"];
    
    [self.navigationController popViewControllerAnimated:NO];

    
    if ([self.delegate respondsToSelector:@selector(noLoginViewControllerLoginSuccess:)]) {
       
        [self.delegate noLoginViewControllerLoginSuccess:self];
        
    }
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
