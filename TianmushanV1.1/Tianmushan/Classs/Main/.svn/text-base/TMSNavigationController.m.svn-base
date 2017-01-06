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

#import "TMSNavigationController.h"
#import "TianmushanAPI.h"

@interface TMSNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation TMSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationBar *nav = [UINavigationBar appearance];
    [nav setBackgroundImage:[UIImage createImageWithColor:CUSTOMCOLOR(46, 46, 46)] forBarMetrics:UIBarMetricsDefault];
    [nav setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont systemFontOfSize:17]
                                  }];
    self.interactivePopGestureRecognizer.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{    
    if (self.childViewControllers.count>0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

#pragma mark 支持滑动手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    //最外层的控制器不要滑动返回手势
    if (self.childViewControllers.count==1) {
        
        return NO;
    
    }

    return YES;
}


#pragma mark 
- (void)backItemClick
{
    [self popViewControllerAnimated:YES];
}

@end
