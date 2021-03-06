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

#import "PhotoCell.h"
#import "Photoitem.h"
#import "TMSPhotoLibraryTool.h"



@interface PhotoCell()

/**图片*/
@property(nonatomic,weak)IBOutlet UIImageView *imageview;

@end

@implementation PhotoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.imageview addGestureRecognizer:tap];
   
    
}


- (void)tap:(UITapGestureRecognizer*)tap
{
    //打开图片浏览器
    if ([self.delegate respondsToSelector:@selector(photoCellCoverDidSelected:currentIndex:)]) {
        
        [self.delegate photoCellCoverDidSelected:self currentIndex:self.indexPath.row];
        
    }
}


- (IBAction)selectBtnClick:(UIButton *)btn {

    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        self.photoItem.isSelected = YES;
        
        if ([self.delegate respondsToSelector:@selector(photoCellDidSelected:)]) {
            [self.delegate photoCellDidSelected:self];
        }
        
    }else{
        
        
        self.photoItem.isSelected = NO;
        
        if ([self.delegate respondsToSelector:@selector(photoCellCancleSelected:)]) {
            [self.delegate photoCellCancleSelected:self];
        }
        
        
    }
    
    
}

- (void)setPhotoItem:(PhotoItem *)photoItem
{
    _photoItem  = photoItem;
    
    
    if (photoItem.asset != nil) {
        
        //异步加载图片
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
            [self performSelectorInBackground:@selector(loadImage) withObject:nil];
        
//        });
       
    }
    
    if (photoItem.isSelected) {
        
        self.selectBtn.selected = YES;
        
    }else{
        
        self.selectBtn.selected = NO;
    }
    
}

- (void)loadImage
{
 
    [[TMSPhotoLibraryTool sharedInstance] getThumbnailWithAsset:self.photoItem.asset size:CGSizeMake(80, 80) completionBlock:^(UIImage *image) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.imageview.image = image;
            
        });
        
    }];
}





@end
