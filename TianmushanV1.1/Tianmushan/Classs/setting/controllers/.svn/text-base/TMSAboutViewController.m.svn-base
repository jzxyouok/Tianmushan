/**************************************************************************
 *
 *  Created by shushaoyong on 2016/12/1.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSAboutViewController.h"
#import "TianmushanAPI.h"
#import "QRCodeGenerator.h"

@interface TMSAboutViewController ()

@end

@implementation TMSAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建内容视图
    [self createContentView];
}


/**
 *  绘制logo到二维码上面
 *
 *  @param image <#image description#>
 *
 *  @return <#return value description#>
 */
- (UIImage *)qrcodeCircle:(UIImage*)image
{
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);

    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(ctx, image.size.width*0.5, image.size.height*0.5, 40, 0, M_PI*2, YES);
    
    CGContextClip(ctx);
    
    UIImage *logo = [UIImage imageNamed:@"about"];
    
    [logo drawInRect:CGRectMake(image.size.width*0.5-15, image.size.height*0.5-15, 30, 30)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    return newImage;
}


/**
 *  创建内容视图
 */
- (void)createContentView
{
    self.title = @"关于我们";
    
    self.view.backgroundColor = GLOBALCOLOR;

    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:logoView];
    
    
    UIImageView *qrcodeView = [[UIImageView alloc] init];
    qrcodeView.image = [self qrcodeCircle:[QRCodeGenerator qrImageForString:@"http://www.baidu.com" imageSize:180]];
    [self.view addSubview:qrcodeView];
    
    UILabel *logoName = [[UILabel alloc] init];
    logoName.textAlignment = NSTextAlignmentCenter;
    logoName.text = @"潮报";
    logoName.textColor = UIColorFromRGB(0x333333);
    logoName.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:logoName];
    
    
    UILabel *toplabel = [[UILabel alloc] init];
    toplabel.textAlignment = NSTextAlignmentCenter;
    toplabel.text = @"请好友扫一扫，下载潮报APP吧";
    toplabel.textColor = UIColorFromRGB(0x666666);
    toplabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:toplabel];
    
    UILabel *copyrightLabel = [[UILabel alloc] init];
    copyrightLabel.textAlignment = NSTextAlignmentCenter;
    copyrightLabel.text = @"Copyright@2015-2016 All Right Reserved";
    copyrightLabel.textColor = UIColorFromRGB(0x999999);
    copyrightLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:copyrightLabel];
    
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.text = @"浙江踏潮网络科技有限公司 版权所有";
    companyLabel.textColor = UIColorFromRGB(0x999999);
    companyLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:companyLabel];
    
    logoView.sd_layout.topEqualToView(self.view).offset(60).centerXEqualToView(self.view).widthIs(90).heightIs(90);
    
    logoName.sd_layout.topSpaceToView(logoView,15).centerXEqualToView(self.view).widthIs(100).heightIs(17);

    qrcodeView.sd_layout.topSpaceToView(logoName,0).centerXEqualToView(self.view).widthIs(180).heightIs(180);
    
    toplabel.sd_layout.topSpaceToView(qrcodeView,25).centerXEqualToView(self.view).heightIs(15).widthRatioToView(self.view,0.98);
    
    copyrightLabel.sd_layout.bottomEqualToView(self.view).offset(-20).centerXEqualToView(self.view).heightIs(13).widthRatioToView(self.view,0.98);
    
    companyLabel.sd_layout.bottomEqualToView(copyrightLabel).offset(-30).centerXEqualToView(self.view).heightIs(13).widthRatioToView(self.view,0.98);

}




@end
