//  Created by 舒少勇 on 16/11/5.
//  Copyright © 2016年 ios开发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    loadingViewCircle = 0, //圆形加载动画
    loadingViewEndToEnd//首尾相连的动画
}LoadingViewType;

@interface SYLoadingView : UIView

+ (void)showLoadingView:(UIView*)superView type:(LoadingViewType)type;
+ (void)showLoadingView:(UIView*)superView type:(LoadingViewType)type offset:(CGSize)offset;
+ (void)dismiss;

@end
