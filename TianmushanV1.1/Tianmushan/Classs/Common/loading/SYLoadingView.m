//  Created by 舒少勇 on 16/11/5.
//  Copyright © 2016年 ios开发. All rights reserved.
//

#import "SYLoadingView.h"
#import "UIView+SY.h"

static SYLoadingView *loadView;

@implementation SYLoadingView

+ (void)showLoadingView:(UIView*)superView type:(LoadingViewType)type
{
    loadView =[[SYLoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds  type:type];
    loadView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    loadView.center = superView.center;
    [superView addSubview:loadView];
}

+ (void)showLoadingView:(UIView*)superView type:(LoadingViewType)type offset:(CGSize)offset
{
    loadView =[[SYLoadingView alloc] initWithFrame:[UIScreen mainScreen].bounds  type:type];
    loadView.backgroundColor = [UIColor clearColor];
    loadView.centerX = superView.centerX+offset.width;
    loadView.centerY = superView.centerY+offset.height;
    [superView addSubview:loadView];
}

+ (void)dismiss
{
    [loadView removeFromSuperview];
    
}

- (instancetype)initWithFrame:(CGRect)frame type:(LoadingViewType)type
{
    
    if (self = [super initWithFrame:frame]) {
        
        
        if (type == loadingViewCircle) {
            
            [self createCircleAnimation:10 replicatorBgcolor:[[UIColor blackColor] colorWithAlphaComponent:0.8] pointColor:[[UIColor whiteColor] colorWithAlphaComponent:0.85]];
            
        }else if (type == loadingViewEndToEnd){
            
             [self createCircleAnimation:100 replicatorBgcolor:[UIColor darkGrayColor] pointColor: [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
        }
    
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        

     [self createCircleAnimation:10 replicatorBgcolor:[[UIColor blackColor] colorWithAlphaComponent:0.8] pointColor:[[UIColor whiteColor] colorWithAlphaComponent:0.85]];

        
    }
    
    return self;
    
}



- (void)createCircleAnimation:(NSInteger)instanceCount replicatorBgcolor:(UIColor*)bgcolor
 pointColor:(UIColor*)pointColor
{
    
    //创建复制图层
    CAReplicatorLayer *rep = [CAReplicatorLayer layer];
    rep.bounds = CGRectMake(0, 0, 100, 100);
    rep.cornerRadius = 8.0;
    rep.position = self.center;
    rep.backgroundColor = bgcolor.CGColor;
    
    //创建点
    CALayer *point = [CALayer layer];
    point.bounds = CGRectMake(0, 0, 10, 10);
    point.position = CGPointMake(50, 20);
    point.backgroundColor = pointColor.CGColor;
    point.shadowColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor;
    point.shadowOffset = CGSizeMake(5, 5);
    point.shadowOpacity = 0.5;
    point.cornerRadius = 5;
    [rep addSublayer:point];
    
    //定义复制图层的个数
    CGFloat count = instanceCount;
    //计算每一个子图层的旋转角度
    CGFloat angle = 2*M_PI/count;
    //设置复制的子图层个数
    rep.instanceCount = count;
    //设置旋转角度
    rep.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    //添加延迟行为 很重要 不然会同时做动画
    rep.instanceDelay = 1.0/count;
    
    //添加复制图层
    [self.layer addSublayer:rep];
    
    //创建基本的缩放动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.0;
    animation.fromValue = @1;
    animation.toValue = @0.3;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [point addAnimation:animation forKey:nil];
    
   

}


@end
