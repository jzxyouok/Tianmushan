/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/23.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSCreateTideHelper.h"

#import <CoreLocation/CoreLocation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>


#import "TianmushanAPI.h"
#import "SYLoadingView.h"
#import "PhotoItem.h"
#import "TMSTemplateTool.h"
#import "TMSHomeMode.h"
#import "TMSShareModel.h"
#import "TMSDetailViewController.h"

//图片的原始路径 在沙盒创建目录
#define KOriginalPhotoImagePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"uploadImages"]

#define IPONE5SITEMNUMS 3   //5S上显示3个
#define IPONE6SITEMNUMS 4   //6 6p 6s 都显示4个


@interface TMSCreateTideHelper()

/**地理编码对象*/
@property(nonatomic,strong)CLGeocoder *coder;

/**保存所有图片地址*/
@property(nonatomic,strong) NSMutableArray *imagesPath;

/**保存所有图片上传的顺序 通过sha1*/
@property(nonatomic,strong) NSMutableArray *uploadImagesSort;

/**存放用户选择的照片的时间 和 地址信息*/
@property(nonatomic,strong)NSMutableArray *imagsInfo;

/**相册库*/
@property(nonatomic,strong) ALAssetsLibrary *assetLibrary;

/**用户选中的所有的图片*/
@property(nonatomic,strong)NSMutableArray *photoItems;

/**当前类对应的控制器的view*/
@property(nonatomic,strong)UIView *view;

//记录上传失败的图片
@property(nonatomic,strong)NSMutableArray *errorUploads;

@end


@implementation TMSCreateTideHelper


- (ALAssetsLibrary *)assetLibrary
{
    if (!_assetLibrary) {
        _assetLibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetLibrary;
}

- (CLGeocoder *)coder
{
    if (!_coder) {
        _coder = [[CLGeocoder alloc] init];
    }
    return _coder;
}

- (NSMutableArray *)imagesPath
{
    if (!_imagesPath) {
        _imagesPath = [NSMutableArray array];
    }
    return _imagesPath;
}

- (NSMutableArray *)uploadImagesSort
{
    if (!_uploadImagesSort) {
        _uploadImagesSort = [NSMutableArray array];
    }
    return _uploadImagesSort;
}

- (NSMutableArray *)imagsInfo
{
    if (!_imagsInfo) {
        _imagsInfo = [NSMutableArray array];
    }
    return _imagsInfo;
}


- (NSMutableArray *)errorUploads
{
    if (!_errorUploads) {
        _errorUploads = [NSMutableArray array];
    }
    return _errorUploads;
}

///**
// *  获取图片的地址
// *
// *  @param items       图片模型数组
// *  @param completions 成功的回调
// */
//- (void)requestAddressWithItem:(NSMutableArray*)items Completions:(void(^)())completions
//{
//    
//    PhotoItem *item = items[0];
//    
//    CLLocation *location = item.location;
//    
//    [self locationWithAddressLatitude:location.coordinate.latitude longitude:location.coordinate.longitude completions:^(NSString *address) {
//        
//        item.address = address;
//        
//        NSLog(@"获取到第%zd张图片的地址===%@",items.count,item.address);
//        
//        [items removeObjectAtIndex:0];
//        
//        if (items.count==0) {
//            
//            completions?completions():nil;
//            
//        }else{
//            
//            [self requestAddressWithItem:items Completions:completions];
//            
//        }
//        
//    }];
//}
//
//
///**
// *  根据经纬度获取图片地址
// *
// *  @param latitude    经度
// *  @param longitude   纬度
// *  @param completions 成功的回调
// */
//- (void)locationWithAddressLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude completions:(void(^)(NSString* address))completions
//{
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//    
//    
//    [self.coder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        
//        if (error==nil) {
//            
//            CLPlacemark *mark  = [placemarks firstObject];
//            
//            if (completions) {
//                completions([NSString stringWithFormat:@"%@%@%@",mark.locality,mark.subLocality,mark.name]);
//            }
//            
//        }else{
//            
//            completions?completions(@""):nil;
//            
//        }
//        
//    }];
//    
//}



/**
 *  上传图片到服务器
 *
 *  @param photoItems <#photoItems description#>
 */
- (void)uploadPhotoItems:(NSArray *)photoItems view:(UIView*)view
{
    
    _view = view;
    
    //1. 创建存放原始图的文件夹--->OriginalPhotoImages
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    //创建目录
    if (![fileManager fileExistsAtPath:KOriginalPhotoImagePath]) {
        [fileManager createDirectoryAtPath:KOriginalPhotoImagePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    //清空上一次保存的图片地址
    [self.imagesPath removeAllObjects];
    
    //清空上一次的图片顺序
    [self.uploadImagesSort removeAllObjects];
    
    //清空上一次保存的图片信息
    [self.imagsInfo removeAllObjects];
    
    //2. 获取图片地址 将图片写入到本地的文件夹中
    for (int i = 0 ; i<photoItems.count ; i++) {
        
        PhotoItem *item = photoItems[i];
        
        if (IsIOS8) {
            [self imageWithasset:item index:i];
        }else{
            [self imageUrlWithItem:item index:i];
        }
        
    }
    
    //保存已经有图片地址的items
    self.photoItems = [photoItems mutableCopy];
    
    //检查图片是否已经上传过 如果已经上传过滤掉不需要上传的图片
    [self checkImageFileSha1];

    

}


/**
 * 检查图片是否已经上传过 如果已经上传过滤掉不需要上传的图片
 */
- (void)checkImageFileSha1
{
    
    [self checkImageList:self.imagesPath completion:^(NSArray *array) {
        
        if (array.count>0) {
            
            //保存需要删除 过滤掉 不需要上传的图片
            NSMutableArray *addImagesPath = [NSMutableArray array];
            
            for (PhotoItem *item in self.photoItems) {
                
                //获取图片的sha1
                NSString *newSha1 = [NSString sha1HashOfFileAtPath:item.filePath];
                
                //保存图片信息
                NSMutableDictionary *tempdict = [NSMutableDictionary dictionary];
                tempdict[@"time"] = item.photoCreateDate?item.photoCreateDate:@"";
                tempdict[@"gps"] = item.address?item.address:@"";
                [self.imagsInfo addObject:tempdict];
                
                
                if (newSha1) {
                    
                    //保存图片的上传顺序
                    [self.uploadImagesSort addObject:newSha1];
                    
                }
               
                
                //过滤不需要上传的图片
                for (NSString* sha in array) {
                    if ([sha isEqualToString:newSha1]) {
                        [addImagesPath addObject:item];
                    }
                }
            }
            
            //删除不需要上传的图片
            if (addImagesPath.count) {
                self.photoItems = addImagesPath;
                //过滤完成之后 上传图片
                [self uploadImages:self.photoItems];
            }else{ //否则就是所有图片都存在 直接生成h5
                [self uploadImagesDidFinish];
            }
            
            
            
        }else{ //如果当前用户选择的图片 服务器都存在 直接生成h5
            
            //获取图片的上传顺序
            for (PhotoItem *item in self.photoItems) {
                
                //获取图片的sha1
                NSString *newSha1 = [NSString sha1HashOfFileAtPath:item.filePath];
                //保存图片信息
                NSMutableDictionary *tempdict = [NSMutableDictionary dictionary];
                tempdict[@"time"] = item.photoCreateDate?item.photoCreateDate:@"";
                tempdict[@"gps"] = item.address?item.address:@"";
                [self.imagsInfo addObject:tempdict];
                
                if (newSha1) {
                    
                    //保存图片的上传顺序
                    [self.uploadImagesSort addObject:newSha1];
                    
                }
            }
            
            //否则就是所有图片都存在 直接生成h5
            [self uploadImagesDidFinish];
            
            
        }
        
    } failure:^(NSString *error) {
        
        //如果超时提示
        if ([error rangeOfString:@"The request timed out"].length != NSNotFound) {
            [self.view showError:@"请求超时"];
        }
        
        [SYLoadingView dismiss];
        
    }];
    
    
}

/**
 * 检查图片是否已经上传过 如果已经上传过滤掉不需要上传的图片
 */
- (void)checkImageList:(NSArray*)imagePath completion:(void(^)(NSArray* array))completion failure:(void(^)(NSString* error))failure
{
    if (!imagePath.count) {
        return;
    }
    
    NSMutableArray *imgSha1s = [NSMutableArray array];
    for (NSString *path  in  imagePath) {
        NSString *sha1 = [NSString sha1HashOfFileAtPath:path];
        if (sha1) {
            [imgSha1s addObject:sha1];
        }
    }
    
    if (imgSha1s.count<=0) {
        return;
    }
    
    NSDictionary *parames = @{@"userid":[TMSCommonInfo Openid]?[TMSCommonInfo Openid]:@"",@"imglist":imgSha1s};
    [[APIAgent sharedInstance] postToUrl:KRAPI_Imgcheck bodyParams:parames withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        if (![responseObject[@"rst"] isKindOfClass:[NSNull class]]) {
            
            if ([responseObject[@"rst"] isKindOfClass:[NSDictionary class]]) {
                
                if ([responseObject[@"rst"][@"imglist"] isKindOfClass:[NSArray class]]) {
                    
                    if (completion) {
                        completion(responseObject[@"rst"][@"imglist"]);
                    }
                    
                }
                
            }
            
        }else{ //返回的为空
            
            if (completion) {
                completion([NSArray array]);
            }
        }
        
    } withFailure:^(NSString *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}

/**
 *  上传图片到服务器
 */
- (void)uploadImages:(NSMutableArray*)photoItems
{
 
    dispatch_group_t group  =  dispatch_group_create();
    
    for (int i = 0 ; i< photoItems.count  ; i++) {
        
        PhotoItem *item = photoItems[i];
        
        if (![item isKindOfClass:[PhotoItem class]]) {
            continue;
        }
        
        dispatch_group_enter(group);
        //获取
        [[TMSTemplateTool sharedInstance] uploadTemplateImagesToUrl:KRAPI_Imgupload uploadName:@"uploadname" withItem:item withCompletionBlockWithProgress:^(NSProgress *pregress) {
            
        } Success:^(NSDictionary *responseObject) {
        
            NSLog(@"%@",responseObject);
            
            dispatch_group_leave(group);

            
        } withFailure:^(NSString *error) {
            
            [self.errorUploads addObject:item];
            
            dispatch_group_leave(group);
            
            NSLog(@"上传失败 还剩%zd没传  开始重新上传中.....",photoItems.count);

        }];
        
        
    }
    
    //全部上传完成 回到主线程
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        NSLog(@"全部图片上传完成==================");
       
        if (self.errorUploads.count) {
            
            NSMutableArray *temparray = [NSMutableArray arrayWithArray:[self.errorUploads mutableCopy]];
            
            [self.errorUploads removeAllObjects];
            self.errorUploads = nil;
            
            [self uploadImages:temparray];
            
        }else{
            
            //上传完成的处理
            [self uploadImagesDidFinish];
            
        }
        
        
        
    });
    
    

}


/**
 *  上传完成
 *
 *  @return
 */
- (void)uploadImagesDidFinish
{
    
    NSError *error = nil;
    //上传成功后删除创建的临时目录
    [[NSFileManager defaultManager] removeItemAtPath:KOriginalPhotoImagePath error:&error];
    if (error==nil) {
        NSLog(@"删除目录成功");
    }
    
    
    NSString *contentJson = nil;
    
    //如果内容字典数组有值
    if (self.creatTideDatas) {
        
        //替换所有的图片模型对象里面的内容
        //遍历内容数组
        if ([self.creatTideDatas isKindOfClass:[NSDictionary class]]) {
            
  
                //处理图片
                if ([self.creatTideDatas[@"picture"] isKindOfClass:[NSArray class]]) {
                    
                    if (self.uploadImagesSort.count <=0) {
                        return;
                    }
                    
                    self.creatTideDatas[@"picture"] = [self.uploadImagesSort copy];

                }
            
            
            //将处理字典模型 转换为json 字符串
            contentJson = [NSString jsonWithDictionary:self.creatTideDatas];
            
            NSLog(@"contentJson%@",contentJson);
        }
        
    }

    
    //1.生成h5
    NSDictionary *parames = @{@"userid":[TMSCommonInfo Openid],@"content":self.creatTideDatas?self.creatTideDatas:@"",@"templateId":self.mode.ID?self.mode.ID:@"",@"catalogName":self.mode.catalog?self.mode.catalog:@""};
    
    weakifySelf
    [[APIAgent sharedInstance] postToUrl:KRAPI_CreateH5 bodyParams:parames withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        strongifySelf
        
        [self.imagsInfo removeAllObjects];
        
        [self.imagesPath removeAllObjects];
        
        [self.uploadImagesSort removeAllObjects];
        
        [self.photoItems removeAllObjects];
        
        
        
        NSLog(@"%@",responseObject);
        
        
        if (![responseObject[@"rst"] isKindOfClass:[NSNull class]]) {
            
            if ([responseObject[@"rst"] isKindOfClass:[NSDictionary class]]) {
                
                
                [self.view showSucess:@"生成潮报成功"];
                
                [SYLoadingView dismiss];
                
                TMSShareModel *mode = [TMSShareModel modalWithDict:responseObject[@"rst"]];

                //发送生成潮报完成的通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_CREATETIDE_FINISHEDNOTE object:mode];

                
            }
            
        }else{
            
            [self.view showError:@"上传图片失败 请稍后再试"];
            [SYLoadingView dismiss];

        }
        
        
    } withFailure:^(NSString *error) {
        
        
        //如果超时提示
        if ([error rangeOfString:@"The request timed out"].length != NSNotFound) {
            [self.view showError:@"请求超时 请重试"];
            
        }
        
        [SYLoadingView dismiss];
        
        
    }];
    
    
    
    
}



- (void)imageUrlWithItem:(PhotoItem *)item index:(NSInteger)index
{
    //获取图片尺寸
    CGSize imgSize = CGSizeMake(item.scaleSize.width?item.scaleSize.width:1280, item.scaleSize.height?item.scaleSize.height:960);
    
//    CGSize imgSize = CGSizeMake(1280,960);

    NSLog(@"photoCreateDate====%@  address===%@",item.photoCreateDate,item.address);
    
    // 如何判断已经转化了,通过是否存在文件路径
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (item.url) {
            
            weakifySelf
            //根据url 去获取图片数据
            [self.assetLibrary assetForURL:[NSURL URLWithString:item.url] resultBlock:^(ALAsset *asset) // substitute YOURURL with your url of video
             {
                 strongifySelf
                 
                 ALAssetRepresentation *rep = [asset defaultRepresentation];
                 Byte *buffer = (Byte*)malloc(rep.size);
                 NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                 NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];//this is
                 
                 // 主要方法
                 NSString * imagePath =[KOriginalPhotoImagePath stringByAppendingPathComponent:[self requestFileName:asset.defaultRepresentation.url.absoluteString]];
                 
                 NSLog(@"imagePath===%@",imagePath);

                 //调整图片方向 裁剪图片中间区域
                 UIImage *newImage = [UIImage clipImage:[[UIImage imageWithData:data] changeImageOrientation] toRect:imgSize ];

                 [UIImageJPEGRepresentation(newImage, 0.01) writeToFile:imagePath atomically:YES];
                 
                 [self.imagesPath addObject:imagePath];
                 
                 item.filePath = imagePath;
                 
                 
             } failureBlock:^(NSError *err) {
                 NSLog(@"Error: %@",[err localizedDescription]);
             }];
            
            
            
        }
    });
    
}



- (void)imageWithasset:(PhotoItem*)item index:(NSInteger)index
{
    
    //获取图片尺寸
    CGSize imgSize = CGSizeMake(item.scaleSize.width?item.scaleSize.width:1280, item.scaleSize.height?item.scaleSize.height:960);
    
    NSLog(@"imgSize====%@",NSStringFromCGSize(item.scaleSize));
    
    //重新使用这个方法去获取图片的目的 是为了避免强引用导致的内存暴涨问题
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    
    weakifySelf
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        [[PHImageManager defaultManager] requestImageDataForAsset:item.asset options:options resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            strongifySelf
            
            NSString *url = [[info objectForKey:@"PHImageFileURLKey"] absoluteString];
            
            NSString * imagePath = [KOriginalPhotoImagePath stringByAppendingPathComponent:[self requestFileName:url]];
            
            NSLog(@"imagePath===%@",imagePath);
            
            //调整图片方向 裁剪图片中间区域
            UIImage *newImage = [UIImage clipImage:[[UIImage imageWithData:imageData] changeImageOrientation] toRect:imgSize ];

            [UIImageJPEGRepresentation(newImage, 0.01) writeToFile:imagePath atomically:YES];
            
            [self.imagesPath addObject:imagePath];
            
            item.filePath = imagePath;
            
        }];
        
    } error:nil];
    
    
}


//加载文件名称
- (NSString*)requestFileName:(NSString*)url
{
    //获取扩展名
    NSString *extension = [[url pathExtension] lowercaseString];
    
    //获取图片名
    NSString *imgName = [[[url lastPathComponent] componentsSeparatedByString:@"."] firstObject];
    
    if ([extension rangeOfString:@"?"].location != NSNotFound) {
        
        extension = [[extension componentsSeparatedByString:@"?"] firstObject];
        imgName = [imgName stringByAppendingString:[NSString stringWithFormat:@"%lld",(long long)[NSDate date].timeIntervalSince1970]];
    }
    
    return  [NSString stringWithFormat:@"%@.%@",[imgName MD5Hash],extension];
    
}



/**
 *  获取item尺寸
 *
 *  @return <#return value description#>
 */
+(CGSize)getItemSize
{

    CGSize itemSize = CGSizeZero;
    
    CGFloat margin = kCellContentViewItemClosMargin;
    
    CGFloat lrMargin = 13;
    
    CGFloat contentw = SCREEN_WIDTH - 2*lrMargin - 2*kCellContentViewCelllrMargin;
    
    //1. 如果是 5s 显示 3列
    if (IS_IPHONE_5) {
        
        CGFloat itemw = (contentw - 2*margin)/IPONE5SITEMNUMS;
        
        itemSize = CGSizeMake(itemw, itemw);
        
    }else if (IS_IPHONE_6 || IS_IPHONE_6P){
        
        CGFloat itemw = (contentw - 3*margin)/IPONE6SITEMNUMS;
        itemSize = CGSizeMake(itemw, itemw);
        
    }else if (IS_IPHONE_7 || IS_IPHONE_7P){
        
        CGFloat itemw = (contentw - 3*margin)/IPONE6SITEMNUMS;
        itemSize = CGSizeMake(itemw, itemw);
    }
    

    
    return itemSize;
    
}


/**
 *  计算高度
 */
+ (CGFloat)getContentViewHeight:(NSArray*)photos maxNum:(BOOL)maxNum
{
    
    if (photos.count<=0) {
        
        return kCellContentViewItemClosMargin + [TMSCreateTideHelper getItemSize].height+kCellContentViewBottomMargin+kCellContentViewCelltbMargin+2*kCellMargin;
    }
    
    CGFloat height = 0;
    
    height += kCellContentViewTitleH;
    
    //计算有多少行
    NSInteger row = 0;
    
    if (IS_IPHONE_5) { //如果是5s每行显示三个
        
        if (photos.count<IPONE5SITEMNUMS) {
            row = 1;
            
        }else{
            
            if (photos.count%IPONE5SITEMNUMS == 0 ) {
                
                row =  photos.count/IPONE5SITEMNUMS;
                
                //如果已经还没有达到最大的上传个数 可以继续上传
                if (maxNum==NO) {
                    row++;
                }
                
            }else{
                
                row =  photos.count/IPONE5SITEMNUMS;
                row++;

            }
            
            
            

            
        }

    }else if (IS_IPHONE_6 || IS_IPHONE_6P){
        
        if (photos.count<IPONE6SITEMNUMS) {
            row = 1;
        }else{
            
            
            if (photos.count%IPONE6SITEMNUMS == 0 ) {
                row =  photos.count/IPONE6SITEMNUMS;
                
                //如果已经还没有达到最大的上传个数 可以继续上传
                if (maxNum==NO) {
                    row++;
                }
            }else{
                
                row =  photos.count/IPONE6SITEMNUMS;
                row++;
                
            }
            
        
            
        }
        
        
    }else if (IS_IPHONE_7 || IS_IPHONE_7P){
        
        if (photos.count<IPONE6SITEMNUMS) {
            row = 1;
        }else{
            
            
            if (photos.count%IPONE6SITEMNUMS == 0 ) {
                row =  photos.count/IPONE6SITEMNUMS;
                
                //如果已经还没有达到最大的上传个数 可以继续上传
                if (maxNum==NO) {
                    row++;
                }
            }else{
                
                row =  photos.count/IPONE6SITEMNUMS;
                row++;
                
            }
            
            
        }
    }
    
   return (row*kCellContentViewItemClosMargin)+ row*[TMSCreateTideHelper getItemSize].height+kCellContentViewBottomMargin+kCellContentViewCelltbMargin+2*kCellMargin;
    
}


@end
