//
//  UIView+TMSHUD.m
//  Tianmushan
//
//  Created by shushaoyong on 2016/11/11.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import "UIView+TMSHUD.h"

@implementation UIView (TMSHUD)

- (void)showSucess:(NSString *)title
{
    [self makeToast:title duration:0.5 position:CSToastPositionCenter];
    
}

- (void)showError:(NSString *)title
{
    [self makeToast:title duration:0.5 position:CSToastPositionCenter];
}

- (void)showError:(NSString *)title position:(id)postion
{
    [self makeToast:title duration:0.5 position:postion];
}

- (void)showActivity
{
    [self makeToastActivity:CSToastPositionCenter];
}

- (void)hideActivity
{
    [self hideToastActivity];
}


@end
