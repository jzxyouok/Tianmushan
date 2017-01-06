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



#import "TMSCreateTemplateViewController.h"
#import "PhotoViewController.h"
#import "PhotoLoadView.h"
#import "PhotoItem.h"
#import "TianmushanAPI.h"
#import "TMSTemplateTool.h"
#import "PhotoBrowserController.h"
#import "TMSDetailViewController.h"
#import "NSString+SY.h"
#import "NSDate+SY.h"
#import "SYLoadingView.h"
#import "TMSShareModel.h"

//图片上传的压缩尺寸
#define uploadImageByScale CGSizeMake(1280,960)

@interface TMSCreateTemplateViewController ()<PhotoViewControllerDelegate>


/**loadingview*/
@property(nonatomic,weak)SYLoadingView *loadingview;

/**相册库*/
@property(nonatomic,strong) ALAssetsLibrary *assetLibrary;

@end

@implementation TMSCreateTemplateViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    PhotoViewController *photovc = [[PhotoViewController alloc] init];
    photovc.groupResult = self.group;
    
    //如果是相册 最多上传81张
    photovc.maxSelectedNum = self.mode.picSize?self.mode.picSize:1;
    photovc.photoDelegate = self;
    [self addChildViewController:photovc];
    photovc.view.frame = self.view.bounds;
    [self.view addSubview:photovc.view];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    
}

#pragma mark PhotoViewControllerDelegate
- (void)photoViewController:(PhotoViewController *)vc didClickedItemIndex:(NSInteger)index items:(NSArray *)photoItems
{

    NSMutableArray *temp = [NSMutableArray array];
    for (PhotoItem *photoitem in photoItems) {
        PhotoBrowserItem *item = [[PhotoBrowserItem alloc] init];
        item.asset  = photoitem.asset;
        [temp addObject:item];
        
    }
    PhotoBrowserController *photoBrowser = [[PhotoBrowserController alloc] init];
    [self addChildViewController:photoBrowser];
    photoBrowser.images = temp;
    photoBrowser.currentIndex = index;
    photoBrowser.animating = NO;
    [self.navigationController pushViewController:photoBrowser animated:YES];
    
}



- (void)photoViewController:(PhotoViewController *)vc didFinishPhotoItem:(NSArray *)photoItems
{
    
    //关闭当前视图的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_CREATETIDE_CLOSEPHOTOGROUPNOTE object:photoItems];

    
    return;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
    NSLog(@"内存警告啦！！！！！");
}



@end
