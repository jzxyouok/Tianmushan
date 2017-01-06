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

#import "TMSLoginViewController.h"
#import "TianmushanAPI.h"
#import "WXApi.h"
#import "TMSHomeViewController.h"
#import "TMSUpdateVersion.h"
#import "TMSNavigationController.h"
#import "WXApiImpl.h"
#import "TMSTabBarController.h"
#import "TMSLoginView.h"

@interface TMSLoginViewController ()<WXApiDelegate,UIApplicationDelegate,UIAlertViewDelegate,TMSLoginViewDelegate>

/**微信登录*/
@property(nonatomic,weak)UIButton *wxBtn;

/**随便看看*/
@property(nonatomic,weak)UIButton *desLabel;

/**背景view*/
@property(nonatomic,weak)UIImageView *bg;

/**更新模型*/
@property(nonatomic,strong)TMSUpdateVersion *version;


@end

@implementation TMSLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUp];
    [self updateVersion];
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[UIColor blackColor]]];
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
    desLabel.hidden = YES;
    [self.view addSubview:desLabel];
    self.desLabel = desLabel;
    
    
    //如果用户没有登录 显示登录框
//    if ([TMSCommonInfo accessToken] == nil) {
//    
//        self.desLabel.hidden = NO;
//        
//        
//        //检查用户是否已经安装微信 没有安装就隐藏微信登录按钮
//        if ([WXApi isWXAppInstalled] ==0) {
//            
//            self.wxBtn.hidden = YES;
//            
//        }else{
//
//            [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:1.8 initialSpringVelocity:30 options:UIViewAnimationOptionCurveLinear animations:^{
//                
//                self.wxBtn.transform = CGAffineTransformIdentity;
//                
//            } completion:^(BOOL finished) {
//                
//            }];
//        }
//
//    }else{
//        
//        self.desLabel.hidden = NO;
//        
//    }
    
    
    
}


#pragma mark
- (void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginError) name:KRAPI_MEMBER_LOGINERRORNOTIFICATION object:nil];

}




#pragma mark
/**
 *  检查新版本
 */
- (void)updateVersion
{
    
    [[APIAgent sharedInstance] getFromUrl:KRAPI_Checkversion params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
       
        NSLog(@"%@",responseObject);
        
        NSDictionary *dict = responseObject[@"rst"];
        
        if ([dict isKindOfClass:[NSNull class]]) {
            return;
        }
      
        if ([dict isKindOfClass:[NSDictionary class]]) {
            
            self.version = [TMSUpdateVersion modalWithDict:dict];
            
            
            if (self.version) {
                
                //如果当前的版本 和 服务器的版本不一致
                if ([self.version.version floatValue] > CurrentVersion) {
                    
                    
                    TMSLoginView *loginView = [TMSLoginView loginViewTitle:@"发现新版本" message:self.version.desc delegate:self cancelButtonTitle:@"稍后更新" cancleBtnColor:UIColorFromRGB(0x666666) otherButtonTitle:@"立即更新" otherButtonColor:[UIColor redColor]];
                    
                    [loginView show];
                    
                    
                    [self showLoginButton];
  
                    
                }
                
            }

        }
        
    } withFailure:^(NSString *error) {
        
        NSLog(@"%@",error);
        
        [self showLoginButton];
        
    }];

}

//显示登陆按钮
- (void)showLoginButton
{

    self.desLabel.hidden = NO;
    
    //检查用户是否已经安装微信 没有安装就隐藏微信登录按钮
    if ([WXApi isWXAppInstalled] ==0) {
        
        self.wxBtn.hidden = YES;
        
    }else{
        
        [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:1.8 initialSpringVelocity:30 options:UIViewAnimationOptionCurveLinear animations:^{
            
            self.wxBtn.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
        }];
    }

}

#pragma mark TMSLoginViewDelegate
- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    if (index==0) {
        
        [view hide];
        
    }else if (index==1){
        
        [view hide];
        
        NSURL *url = [NSURL URLWithString:self.version.downloadurl];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];

        }
        
    }
    
}

#pragma mark
- (void)backItemClick
{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark 微信登录
- (void)wxBtnClick {
    
    [[WXApiImpl sharedInstance] requestOAuth];
}


#pragma mark 随便看看
- (void)desLabelClick
{
    TMSTabBarController *tabbar = [[TMSTabBarController alloc] init];
    
    if ([self respondsToSelector:@selector(presentViewController:animated:completion:)]) {
        
        tabbar.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
        
        [self presentViewController:tabbar animated:YES completion:^{
            
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
            
        }];
        
    }else{
        
        [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
        
    }
    
    
    
}



#pragma mark notification
 -(void)loginSuccess
{
    [self.view showSucess:@"登录成功"];
    
    [self desLabelClick];
    
}

- (void)loginError
{
    [self.view showSucess:@"登录失败"];
    
    [self desLabelClick];
    
}


@end
