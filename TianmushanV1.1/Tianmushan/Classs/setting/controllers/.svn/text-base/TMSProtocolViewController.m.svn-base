//
//  TMSProtocolViewController.m
//  TianmushanV1.1
//
//  Created by shushaoyong on 2016/12/12.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import "TMSProtocolViewController.h"
#import "TianmushanAPI.h"

@interface TMSProtocolViewController ()

@end

@implementation TMSProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = GLOBALCOLOR;
    self.title = @"用户协议";
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"userProtocol.docx" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    [webView loadRequest:request];
    webView.contentMode = UIViewContentModeScaleToFill;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
}


@end
