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

#import "TMSDetailViewController.h"
#import "UIBarButtonItem+TMSBarbutonItem.h"
#import "TMSCreateTemplateViewController.h"
#import "TMSCommonInfo.h"
#import "TMSShareViewController.h"
#import "TMSMYCollectionViewController.h"
#import "UIView+TMSHUD.h"
#import "SYLoadingView.h"
#import "TMSNoLoginViewController.h"
#import "TMSPhotoLibraryTool.h"
#import <WebKit/WebKit.h>
#import "PhotoItem.h"
#import "TMSCreateTideController.h"
#import "TMSPhotoGroupViewController.h"
#import "TMSTabBarController.h"
#import "TMSWaveLoadView.h"
#import "TMSMusicTool.h"

@interface TMSDetailViewController ()<UIScrollViewDelegate,UIWebViewDelegate,TMSShareViewControllerDelegate,UIAlertViewDelegate,TMSNoLoginViewControllerDelegate>

/**ios7 及以下 webView*/
@property(nonatomic,strong)UIWebView *ios7webView;

/**ios8 及以下 webView*/
//@property(nonatomic,strong)WKWebView *ios8webView;

/**标识在当前页 是否已经点击过完成按钮*/
@property(nonatomic,assign)BOOL isClickedFinish;

/**loadview*/
@property (nonatomic, strong) TMSWaveLoadView *loadingView;

/**记录开始加载数据时间*/
@property(nonatomic,strong)NSDate *startDate;

/**标题*/
@property(nonatomic,weak)UILabel *titleLabel;

/**左边按钮*/
@property(nonatomic,weak)UIButton *leftButtonItem;

/**右边按钮*/
@property(nonatomic,weak) UIButton *rightButtonItem;

@end

@implementation TMSDetailViewController

- (UIWebView *)ios7webView
{
    if (!_ios7webView) {
        
        _ios7webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _ios7webView.scalesPageToFit = YES;
        _ios7webView.delegate = self;
        _ios7webView.scrollView.delegate =self;
        [self.view addSubview:_ios7webView];
    }
    return _ios7webView;
}

//- (WKWebView *)ios8webView
//{
//    if (!_ios8webView) {
//        _ios8webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//        _ios8webView.navigationDelegate = self;
//        _ios8webView.backgroundColor = [UIColor redColor];
//        _ios8webView.allowsBackForwardNavigationGestures = YES;
//        _ios8webView.scrollView.delegate =self;
//        [self.view addSubview:_ios8webView];
//    }
//    return _ios8webView;
//}


/**
 *  加载动画
 *
 *  @return <#return value description#>
 */
- (TMSWaveLoadView *)loadingView
{
    if (!_loadingView) {
        _loadingView = [TMSWaveLoadView loadingView];
        [self.view addSubview:_loadingView];
        _loadingView.center = self.view.center;
    }
    return _loadingView;
}
/*
 *关闭加载动画
 *
 */
- (void)closedLoadView
{
    //如果小于5秒
    if ([NSDate dateDifferStartDate:self.startDate endDate:[NSDate date]]<5000) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.loadingView stopLoading];
            
        });
        
    }else{
        
        [self.loadingView stopLoading];
        
    }
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
    [self.navigationController setNavigationBarHidden:YES];

    
//    if (IsIOS8) {
//        
//        //播放音乐
//        NSString *js = @"var audio = document.getElementById('musicplayer');audio.play();";
//        [self.ios8webView evaluateJavaScript:js completionHandler:nil];
//        
//    }else{
    
        //播放音乐
        NSString *js = @"var audio = document.getElementById('musicplayer');audio.play();";
        [self.ios7webView stringByEvaluatingJavaScriptFromString:js];
//    }
   


}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];

}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //添加导航栏
    [self addNavView];
    
    
    if (self.myReportJoin) {
        
        self.titleLabel.text = self.mode.title?self.mode.title:@"潮报欣赏";


    }else{
        
        if (self.shareMode) {
            
            self.titleLabel.text = @"潮报预览";

        }else{
            
            self.titleLabel.text = @"模板欣赏";

        }
    }

//    if (IsIOS8) {
//        
//        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url?self.url:@"https://www.baidu.com"]];
//        [self.ios8webView loadRequest:request];
//        
//    }else{
    
        NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:self.url?self.url:@"https://www.baidu.com"]];
        [self.ios7webView loadRequest:request];
        
//    }
   

    [self setUpRightItem];
    
    //监听微信分享状态
    [self addObserverWeixinShareNotification];
    
    [SYLoadingView showLoadingView:self.view type:loadingViewCircle];
    
}

- (void)addobserverLoginSuccess
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(skipToEditTideController) name:KRAPI_SKIPEDITCONTROLLERNOTIFICATION object:nil];
}

#pragma mark  添加顶部导航栏
- (void)addNavView
{
    self.view.backgroundColor =  CUSTOMCOLOR(46, 46, 46);
    
    CGFloat height = 64;
    UIView *navView = [[UIView alloc] init];
    navView.backgroundColor = CUSTOMCOLOR(46, 46, 46) ;
    [self.view addSubview:navView];
    navView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).rightEqualToView(self.view).heightIs(height);
    
    
    CGFloat btnwh = 40;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [navView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.sd_layout.leftEqualToView(self.view).offset(80).rightEqualToView(self.view).offset(-80).bottomEqualToView(navView).heightIs(btnwh);
    

    UIButton *leftButtonItem = [[UIButton alloc] init];
    leftButtonItem.titleLabel.font = [UIFont systemFontOfSize:15];
    leftButtonItem.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [leftButtonItem setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftButtonItem addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftButtonItem];
    leftButtonItem.sd_layout.leftEqualToView(self.view).bottomEqualToView(navView).offset(-10).widthIs(btnwh).heightIs(height);
    self.leftButtonItem = leftButtonItem;
    
    UIButton *rightButtonItem = [[UIButton alloc] init];
    rightButtonItem.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    rightButtonItem.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButtonItem setTitle:@"去制作" forState:UIControlStateNormal];
    [navView addSubview:rightButtonItem];
    rightButtonItem.sd_layout.rightEqualToView(self.view).bottomEqualToView(navView).widthIs(80).heightIs(btnwh);
    self.rightButtonItem = rightButtonItem;
    


}




/**
 *  监听微信分享状态
 */
- (void)addObserverWeixinShareNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess) name:KRAPI_WEIXINSHARESUCCESSNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareError) name:KRAPI_WEIXINSHAREERRORNOTIFICATION object:nil];

}

- (void)shareSuccess
{
    [self.view showSucess:@"分享成功"];
}

- (void)shareError
{
    [self.view showError:@"分享失败"];
}


- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark 设置导航栏右边的item
- (void)setUpRightItem
{
    //模板预览
    if (self.watchTemplate) {
        
        
        [self.rightButtonItem setTitle:@"去制作" forState:UIControlStateNormal];
        [self.rightButtonItem addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchDown];
        

    //生成潮报预览
    }else{
        
        
        //如果是我的潮报界面进来的 显示分享
        if (self.myReportJoin) {
            
            //设置分享按钮
            [self.rightButtonItem setTitle:@"分享" forState:UIControlStateNormal];
            [self.rightButtonItem addTarget:self action:@selector(rightShareItemClick) forControlEvents:UIControlEventTouchDown];
            
            
        }else{
            

            
            [self.rightButtonItem setTitle:@"完成" forState:UIControlStateNormal];
            [self.rightButtonItem addTarget:self action:@selector(rightShareItemClick) forControlEvents:UIControlEventTouchDown];
            

        }
        
       
    }
    
    
}


#pragma mark UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.view showError:@"网页加载失败"];
    [SYLoadingView dismiss];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SYLoadingView dismiss];
}



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSLog(@"%@",request);
    
    return YES;
}


#pragma mark WKNavigationDelegate
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
//{
//    [self.view showError:@"网页加载失败"];
//    [SYLoadingView dismiss];
//
//
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
//{
//    
//    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    [SYLoadingView dismiss];
//}



#pragma mark event

/**
 *  跳转到模板制作界面
 */
- (void)rightItemClick
{
    NSLog(@"rightItemClickrightItemClickrightItemClickrightItemClick");
    
    //1. 如果用户已经登录 直接跳转上传照片页面
    //2. 如果没有登录 直接跳转到登录页面 让用户登录 登录成功后 跳转到上传照片页面
    if ([TMSCommonInfo accessToken] == nil) {
    
            TMSLoginView *loginV = [TMSLoginView loginViewTitle:@"提示" message:@"你还没有登录 快去登录吧" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitle:@"立即登录"];
            
            [loginV show];
        

        
    }else{
        
        TMSCreateTideController *createTemplatevc = [[TMSCreateTideController alloc] init];
        
        createTemplatevc.mode = self.mode;
        [self.navigationController pushViewController:createTemplatevc animated:YES];
        
    }
    
}


#pragma mark TMSLoginViewDelegate

- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    
  if ([TMSCommonInfo accessToken]) { //如果已经登录 说明是分享潮报
     
        if (index == 0) {
            
            [view hide];
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            
            //重新设置窗口的根控制器
            TMSTabBarController *tabbar =  [[TMSTabBarController alloc] init];
            tabbar.selectedIndex = 2;
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
            
        }else if (index==1)
        {
            [view hide];

            [self showShareVC];
            
        }
        
        
        
    }else{  //如果是需要登录  提示登录
    
        if (index == 0) {
            
            [view hide];
            
        }else if (index==1){
            
            [view hide];
            
            TMSNoLoginViewController *nologon = [[TMSNoLoginViewController alloc] init];
            nologon.delegate = self;
            [self.navigationController pushViewController:nologon animated:YES];
            
        }
        
        
    }

}

#pragma mark TMSNoLoginViewControllerDelegate
- (void)noLoginViewControllerLoginSuccess:(TMSNoLoginViewController *)vc
{
    [self skipToEditTideController];
}

/**
 *  跳转到去制作界面
 */
- (void)skipToEditTideController
{
    TMSCreateTideController *createTide = [[TMSCreateTideController alloc] init];
    createTide.mode = self.mode;
    [self.navigationController pushViewController:createTide animated:YES];
}




-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    if (IsIOS8) {
//        
//        //关闭音乐
//        NSString *js = @"var audio = document.getElementById('musicplayer');audio.pause();";
//        [self.ios8webView evaluateJavaScript:js completionHandler:nil];
//        
//    }else{
    
        //关闭音乐
        NSString *js = @"var audio = document.getElementById('musicplayer');audio.pause();";
        [self.ios7webView stringByEvaluatingJavaScriptFromString:js];
    
//    }

}


/**
 *  分享模板
 */
- (void)rightShareItemClick
{
    
    
    self.rightButtonItem.userInteractionEnabled = NO;
    self.leftButtonItem.userInteractionEnabled = NO;


    //如果是我的潮报界面进入的
    if (self.myReportJoin) {
        
        [self showShareVC];
        
        return;
    }
    
    
       //已经点击过 直接分享
      if (self.isClickedFinish) {
          
          [self showShareVC];

          return;
       }
    

        self.loadingView = nil;
        [self.loadingView startLoading];
    
    
        NSString *url=[[KRAPI_CreateFinish stringByAppendingPathComponent:[TMSCommonInfo Openid]] stringByAppendingPathComponent:self.shareMode.reportid];
    
        //发送生成请求
        [[APIAgent sharedInstance] getFromUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
           
            //判断是否生成完成
            if ([responseObject[@"code"] longLongValue] ==0) {
                
                self.isClickedFinish = YES;
                
                //销毁音乐
                [TMSMusicTool invaildeMusic];

                [self.rightButtonItem setTitle:@"分享" forState:UIControlStateNormal];
                
                [self.loadingView stopLoading];
                
                [self.view showSucess:@"潮报已经保存"];
                
                TMSLoginView *loginV = [TMSLoginView loginViewTitle:@"提示" message:@"潮报已生成，快向好友分享吧！" delegate:self cancelButtonTitle:@"暂不" otherButtonTitle:@"分享"];
                
                [loginV show];
            
                [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)]];

                
            }else{
                
                self.leftButtonItem.userInteractionEnabled = YES;
                
                self.rightButtonItem.userInteractionEnabled = YES;
                
                [self.view showSucess:@"潮报保存失败"];
            }
            
            
        } withFailure:^(NSString *error) {
            
            NSLog(@"%@",error);
            
            self.leftButtonItem.userInteractionEnabled = YES;

            self.rightButtonItem.userInteractionEnabled = YES;

            [self.view showSucess:@"潮报保存失败"];
            
            [self.loadingView stopLoading];

        }];
    
}


/**
 *  显示分享控制器
 */
- (void)showShareVC
{
    
    TMSShareViewController *share = [[TMSShareViewController alloc] init];
    share.shareMode = self.shareMode;
    share.delegate = self;
    [self.view addSubview:share.view];
    [self addChildViewController:share];

}


#pragma mark

/***  此方法只是用来阻止用户右滑的*/
- (void)pan{}

/**
 *  返回按钮的点击
 */
- (void)backItemClick
{
    
    //如果是预览模板
    if (self.watchTemplate) {
        
        [super backItemClick];
        
    }else{
        
        if (self.isMyReportJoin) {
            
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            
            //已经点击过完成
            if (self.isClickedFinish) {
                
                [self.navigationController popViewControllerAnimated:NO];
                
                //重新设置窗口的根控制器
                TMSTabBarController *tabbar =  [[TMSTabBarController alloc] init];
                tabbar.selectedIndex = 2;
                [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
                
            }else{ //返回继续编辑
                
                [self.navigationController popViewControllerAnimated:YES];

            }
            
           
            
        }
    }
    
}

#pragma mark TMSShareViewControllerDelegate
- (void)shareViewControllerDidCancled:(TMSShareViewController *)vc
{
    self.rightButtonItem.userInteractionEnabled = YES;
    self.leftButtonItem.userInteractionEnabled = YES;

}


@end
