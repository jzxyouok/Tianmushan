/**************************************************************************
 *
 *  Created by shushaoyong on 2016/10/28.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSShareViewController.h"
#import "TianmushanAPI.h"
#import "TMSShareButton.h"
#import "WXApi.h"

typedef enum {
    TMSShareViewTypeTimeline = 0,
    TMSShareViewTypeWeixin,
    TMSShareViewTypeWeibo,
    TMSShareViewTypeQQ,
    TMSShareViewTypeQQZone
} TMSShareViewType;

@interface TMSShareViewController ()

/**分享视图*/
@property(nonatomic,weak)UIView *shareView;

/**保存所有的分享按钮*/
@property(nonatomic,strong)NSMutableArray *btns;

@end

@implementation TMSShareViewController

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createShare];
    
}


#pragma mark 创建分享面板
/**
 *  创建分享面板
 */
- (void)createShare
{
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bg = [[UIView alloc] initWithFrame:self.view.bounds];
    bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [bg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgClick)]];
    [self.view addSubview:bg];
    
    
    CGFloat margin = 12.5;
    CGFloat btnW = (SCREEN_WIDTH - margin*6)/5;
    CGFloat btnh = btnW;
    
    CGFloat shareh = 210;
    UIView *shareView = [[UIView alloc] init];
    shareView.backgroundColor = CUSTOMCOLOR(240, 240, 240);
    shareView.frame = CGRectMake(0, SCREEN_HEIGHT - shareh , SCREEN_WIDTH, shareh);
    [self.view addSubview:shareView];
    self.shareView = shareView;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    titleLabel.text = @"分享到";
    titleLabel.textColor = CUSTOMCOLOR(102, 102, 102);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [shareView addSubview:titleLabel];
    
    CGFloat contentH = 120;
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+20, SCREEN_WIDTH, contentH)];
    contentView.showsHorizontalScrollIndicator = NO;
    contentView.showsVerticalScrollIndicator = NO;
    contentView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
    NSArray *titles  = @[
    @{@"title": @"朋友圈",@"icon":@"weixintimeline"},
    @{@"title": @"微信好友",@"icon":@"weixin"},
    @{@"title": @"微博",@"icon":@"weibo"},
    @{@"title": @"QQ",@"icon":@"qq"},
    @{@"title": @"QQ空间",@"icon":@"qqzone"}
    ];
    
    UIImageView *lastBtn = nil;
    for (int i = 0 ; i< titles.count ; i++) {
        
      
        UIImageView *btn = [[UIImageView alloc] initWithFrame:CGRectMake(i*(btnW+margin),0,btnW, btnh)];
        btn.userInteractionEnabled = YES;
        btn.image = [UIImage imageNamed:[titles[i] objectForKey:@"icon"]];
        btn.tag = i;
        [btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnClick:)]];
        [contentView addSubview:btn];
        [self.btns addObject:btn];
        lastBtn = btn;
        
        UILabel *title = [[UILabel alloc] initWithFrame:btn.frame];
        title.text = [titles[i] objectForKey:@"title"];
        title.textAlignment = NSTextAlignmentCenter;
        if (IS_IPHONE_5) {
            title.font = [UIFont systemFontOfSize:10];
        }else{
            title.font = [UIFont systemFontOfSize:13];

        }
        title.top = btn.bottom;
        title.textColor = CUSTOMCOLOR(102, 102, 102);
        [contentView addSubview:title];
        
        if (i>1) {
            btn.hidden = YES;
            title.hidden = YES;
        }
        
    }
    contentView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame), 0);
    [shareView addSubview:contentView];
 
    
    CGFloat cancleh = 44;
    UIButton *cancleBtn = [[UIButton alloc] init];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    cancleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitleColor:CUSTOMCOLOR(102, 102, 102) forState:UIControlStateNormal];
    cancleBtn.frame = CGRectMake(0, CGRectGetMaxY(contentView.frame), shareView.width, cancleh);
    [shareView addSubview:cancleBtn];
    
    shareView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.15 animations:^{
            
            shareView.transform = CGAffineTransformIdentity;
            
        }completion:^(BOOL finished) {
    
        }];
        
    });
    
}

#pragma mark event

/**
 *  分享按钮的点击
 *
 *  @param tap <#tap description#>
 */
- (void)btnClick:(UITapGestureRecognizer*)tap
{
    UIImageView *imageView = (UIImageView*)tap.view;
    
    switch (imageView.tag) {
            
        case TMSShareViewTypeTimeline:
            
            [self shareViewWithTimeline];
            
            break;
        
        case TMSShareViewTypeWeixin:
            
            [self shareViewWithWeixin];
            
            break;
            
        case TMSShareViewTypeWeibo:
            
            [self shareViewWithWeibo];
            
            break;
            
        case TMSShareViewTypeQQ:
            
            [self shareViewWithQQ];
            
            break;
            
        case TMSShareViewTypeQQZone:
            
            [self shareViewWithQQZone];

            break;
    }
    
    
}


#pragma mark 分享到对应的平台

/**
 *  分享到朋友圈
 *
 *  @param type <#type description#>
 */
- (void)shareViewWithTimeline
{
    [self cancleBtnClick];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.shareMode.title?self.shareMode.title:@"潮报";
        message.description =self.shareMode.desc?self.shareMode.desc: @"潮报 让H5不再是单调的ppt";
        
        UIImage *image =  [[YYImageCache sharedCache] getImageForKey:self.shareMode.imageurl withType:YYImageCacheTypeDisk];
        
        NSData *data =  UIImageJPEGRepresentation(image?image:[UIImage imageNamed:@"default"], 0.001);
        [message setThumbData:data];
        
        WXWebpageObject *pageobj = [WXWebpageObject object];
        pageobj.webpageUrl = self.shareMode.h5url?[self.shareMode.h5url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:@"http://www.baidu.com";
        message.mediaObject = pageobj;
        
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline; //微信朋友圈
        
        [WXApi sendReq:req];
        
    });
  
    
}

/**
 *  分享到微信
 *
 *  @param type <#type description#>
 */
- (void)shareViewWithWeixin
{
    
    [self cancleBtnClick];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.shareMode.title?self.shareMode.title:@"潮报";
        message.description =self.shareMode.desc?self.shareMode.desc: @"潮报 让H5不再是单调的ppt";
        
        UIImage *image =  [[YYImageCache sharedCache] getImageForKey:self.shareMode.imageurl withType:YYImageCacheTypeDisk];
        
        NSData *data =  UIImageJPEGRepresentation(image?image:[UIImage imageNamed:@"default"], 0.001);
        
        NSLog(@"data========%zd",data.length);
        
        [message setThumbData:data];
        
        
        WXWebpageObject *pageobj = [WXWebpageObject object];
        pageobj.webpageUrl = self.shareMode.h5url?[self.shareMode.h5url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]:@"http://www.baidu.com";
        message.mediaObject = pageobj;
        
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession; //微信好友
        
        [WXApi sendReq:req];
        
    });

}

/**
 *  分享到微博
 *
 *  @param type <#type description#>
 */
- (void)shareViewWithWeibo
{

    
}

/**
 *  分享到qq
 *
 *  @param type <#type description#>
 */
- (void)shareViewWithQQ
{

}

/**
 *  分享到qq空间
 *
 *  @param type <#type description#>
 */
- (void)shareViewWithQQZone
{
    
}



/**
 *  取消按钮点击
 */
- (void)cancleBtnClick
{
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.transform = CGAffineTransformMakeTranslation(0, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
    //取消代理
    if ([self.delegate respondsToSelector:@selector(shareViewControllerDidCancled:)]) {
        [self.delegate shareViewControllerDidCancled:self];
    }
}

/**
 *  背景点击
 */
- (void)bgClick
{
    [self cancleBtnClick];
}




@end
