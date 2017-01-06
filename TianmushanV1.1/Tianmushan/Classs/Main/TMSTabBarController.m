/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/24.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSTabBarController.h"
#import "TMSHomeViewController.h"
#import "TMSTemplateCategoryController.h"
#import "TMSMYCollectionViewController.h"
#import "TMSNavigationController.h"
#import "TianmushanAPI.h"
@interface TMSTabBarController ()

@end

@implementation TMSTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //初始化操作
    [self setUp];
    
    //添加所有子控制器
    [self addChildViewControllers];
    
    // LaunchImage
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iconImageView.image        = [UIImage launchImage];
    [self.view addSubview:iconImageView];
    
    //添加动画
    [UIView animateKeyframesWithDuration:1 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        iconImageView.transform = CGAffineTransformMakeScale(1.2,1.2);
        iconImageView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        [iconImageView removeFromSuperview];
        
    }];
}

/**
 *  初始化
 */
- (void)setUp
{
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:
                    @{
                      NSFontAttributeName:[UIFont systemFontOfSize:12],
                      NSForegroundColorAttributeName:CUSTOMCOLOR(0, 0, 0)
                      }forState:UIControlStateNormal];
    [item setTitleTextAttributes:
     @{
       NSFontAttributeName:[UIFont systemFontOfSize:12],
       NSForegroundColorAttributeName:CUSTOMCOLOR(58, 191, 173)
       }forState:UIControlStateSelected];

}


/**
 *  添加子控制器
 */
- (void)addChildViewControllers
{
    
    [self addOneChildViewController:@"TMSHomeViewController" title:@"首页" image:@"home_normal" highted:@"home_Selected"];
    [self addOneChildViewController:@"TMSTemplateCategoryController" title:@"模板" image:@"tide_normal" highted:@"tide_Selected"];
    [self addOneChildViewController:@"TMSMYCollectionViewController" title:@"我的" image:@"mine_normal" highted:@"mine_Selected"];
}

- (void)addOneChildViewController:(NSString*)vcName title:(NSString *)title image:(NSString*)imageName
                          highted:(NSString*)hightedImgName
{
    Class class = NSClassFromString(vcName);
    UIViewController *vc = [[class alloc] init];
    vc.tabBarItem.title = title;
    if ([title isEqualToString:@"模板"]) {
        vc.navigationItem.title = @"模板分类";
    }else{
        vc.navigationItem.title = title;
    }
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:hightedImgName];
    TMSNavigationController *nav = [[TMSNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}



@end
