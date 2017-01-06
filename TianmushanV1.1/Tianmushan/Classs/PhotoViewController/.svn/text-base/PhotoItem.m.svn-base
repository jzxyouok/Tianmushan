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

#import "Photoitem.h"
#import "NSString+SY.h"
#import "NSDate+SY.h"
#import <CoreLocation/CoreLocation.h>
#import "TianmushanAPI.h"
#import "TMSPhotoLibraryTool.h"

@implementation PhotoGroup

- (instancetype)init
{
        if (self = [super init]) {
            _images = [NSArray array];
        }
        return self;
}


+ (instancetype)groupWithName:(NSString *)name result:(id)fetchResult
{
    PhotoGroup *group = [[PhotoGroup alloc] init];
    group.groupName = [self albumWithOriginName:name];
    
    if ([fetchResult isKindOfClass:[PHFetchResult class]]) {
       
        PHFetchResult *Result = (PHFetchResult *)fetchResult;
        group.count = Result.count;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        
    } else if ([fetchResult isKindOfClass:[ALAssetsGroup class]]) {
        ALAssetsGroup *gruop = (ALAssetsGroup *)fetchResult;
        group.count = [gruop numberOfAssets];
        
#pragma clang diagnostic pop
    }
    
    
    group.groupName = name;
    group.fetchResult = fetchResult;
    return group;
}



+ (NSString *)albumWithOriginName:(NSString *)name {
    
    if (IsIOS8) {
        
        NSString *newName;
        if ([name rangeOfString:@"Roll"].location != NSNotFound)         newName = @"相机胶卷";
        else if ([name rangeOfString:@"Stream"].location != NSNotFound)  newName = @"我的照片流";
        else if ([name rangeOfString:@"Added"].location != NSNotFound)   newName = @"最近添加";
        else if ([name rangeOfString:@"Selfies"].location != NSNotFound) newName = @"自拍";
        else if ([name rangeOfString:@"shots"].location != NSNotFound)   newName = @"截屏";
        else if ([name rangeOfString:@"Videos"].location != NSNotFound)  newName = @"视频";
        else newName = name;
        return newName;
        
    }else {
        
        if ([name rangeOfString:@"Roll"].location != NSNotFound) name = @"相机胶卷";

        return name;
    }
}



@end


@implementation PhotoItem

- (NSString *)photoCreateDate
{
    if (_photoCreateDate) {
        
        return _photoCreateDate;
    }
    
    
    if (IsIOS8) {
    
        return [self.phasset.creationDate dateFormatterYMD];
   
    }else{
    
        return [self.asset valueForProperty:ALAssetPropertyDate];
        
    }
    
}


//- (UIImage *)image
//{
//    if (_image) {
//        
//        return _image;
//        
//    }
//    __block UIImage *resultImage;
//    
//    [[TMSPhotoLibraryTool sharedInstance] getThumbnailWithAsset:self.asset size:CGSizeMake(80, 80) completionBlock:^(UIImage *image) {
//        
//        resultImage = image;
//        
//    }];
//
//    return resultImage;
//}



- (id)asset
{
    if (IsIOS8) {
        return self.phasset;
    }else{
        return self.alasset;
    }

}


@end
