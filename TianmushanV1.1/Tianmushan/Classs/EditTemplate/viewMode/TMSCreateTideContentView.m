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

#import "TMSCreateTideContentView.h"
#import "PhotoItem.h"
#import "TMSCreateTideGroup.h"
#import "TianmushanAPI.h"
#import "TMSPhotoLibraryTool.h"
#import "TMSHomeMode.h"

static NSString *const identifier = @"TMSCreateTideContentViewidentifier";

@interface TMSCreateTideContentView()<UICollectionViewDataSource,UICollectionViewDelegate>

/**title*/
@property(nonatomic,weak)UILabel *title;

/**照片数组*/
@property(nonatomic,strong)NSMutableArray *photos;

@end

@implementation TMSCreateTideContentView

/**
 *  添加占位图片
 */
- (void)addPlaceHolder
{
    PhotoItem *tide = [[PhotoItem alloc] init];
    tide.defaultPlaceholder = YES;
    tide.image = [UIImage imageNamed:@"addPhoto"];
    [self.photos addObject:tide];
}

/**
 *  配置数据
 *
 *  @param modes <#modes description#>
 */
- (void)configGroup:(TMSCreateTideGroup*)group;
{
    //保存组
    self.group = group;
    
    
    //如果是相册 不限制照片的张数
    if (group.isPhotoCategory) {
        
        //设置标题
        self.title.text =[NSString stringWithFormat:@"%@",group.title?group.title:@"上传照片"];
        
    }else{
        
        //设置标题
//        self.title.text =[NSString stringWithFormat:@"%@(最多%zd张):",group.title?group.title:@"上传照片",group.maxNum];
          self.title.text =[NSString stringWithFormat:@"%@",group.title?group.title:@"上传照片"];

        
    }
  
    //删除原来的所有的图片
    [self.photos removeAllObjects];
    
    
    //设置配置信息
    
    for (int i = 0 ; i< group.photos.count  ; i++) {
            
        PhotoItem *item = group.photos[i];
            
        item.scaleSize = CGSizeMake(group.photoConfigs.width, group.photoConfigs.height);
            
    }
  
    //添加用户选择的图片
    [self.photos addObjectsFromArray:group.photos];
    
    if (group.photos.count) {
        
        //如果已经是最大的图片 就不添加占位图片
        if (group.photos.count<group.photoConfigs.picNum) {
            
            //添加占位图
            [self addPlaceHolder];
            
        }
        
        
    }else{

        //添加占位图
        [self addPlaceHolder];
        
        
    }
    
  
   
    
    //刷新数据
    [self.contentView reloadData];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count?self.photos.count:0;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMSCreateTideContentViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
    [cell configGroup:_group datas:self.photos indexPath:indexPath];
    
    return cell;
    
}

#pragma mark UICollectionViewDelegate

#pragma mark lazy
- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //创建标题
        UILabel *title = [[UILabel alloc] init];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = UIColorFromRGB(0x333333);
        title.font = [UIFont systemFontOfSize:15];
        [self addSubview:title];
        self.title = title;
        
        //创建内容视图
        UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[TMSCreateTideContentViewLayout alloc] init]];
        contentView.dataSource = self;
        contentView.delegate = self;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.contentInset = UIEdgeInsetsMake(kCellContentViewCelltbMargin, kCellContentViewCelllrMargin, kCellContentViewCelltbMargin, kCellContentViewCelllrMargin);
        [contentView registerClass:[TMSCreateTideContentViewCell class] forCellWithReuseIdentifier:identifier];
        [self addSubview:contentView];
        self.contentView = contentView;
        
        //添加占位图
        [self addPlaceHolder];
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = kCellMargin;
    CGFloat widht = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.contentView.frame = CGRectMake(0, margin , widht, height- kCellContentViewTitleH - margin);
    self.title.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame), widht , kCellContentViewTitleH);
}


@end

@interface TMSCreateTideContentViewCell()
{
    TMSCreateTideGroup *_group; /**当前照片对应的组模型*/
    PhotoItem *_item ;  /**当前照片对应的照片模型*/
    NSIndexPath *_indexPath ;  /**当前照片对应的照片模型*/

}

/**icon*/
@property(nonatomic,weak)UIImageView *photoView;

/**button*/
@property(nonatomic,weak)UIButton *deleteButton;

@end

@implementation TMSCreateTideContentViewCell

/**
 *  配置当前的组数据
 *
 *  @param group <#group description#>
 */
- (void)configGroup:(TMSCreateTideGroup*)group datas:(NSArray*)photos  indexPath:(NSIndexPath*)indexPath;
{
    
    //保存当前的组模型
    _group = group;
    
    //取出indexPath 当前行的照片模型
    _item = photos[indexPath.row];
    
    //保存当前位置
    _indexPath = indexPath;
    
    //如果是占位图片 直接设置图片
    if (_item.isDefaultPlaceholder) {
        
        //直接设置图片
        self.photoView.image = _item.image;
        
        //隐藏删除按钮
        self.deleteButton.hidden = YES;
        
        
    }else{ //不是占位图
        
        
        //获取图片
        weakifySelf
        [[TMSPhotoLibraryTool sharedInstance] getThumbnailWithAsset:_item.asset size:CGSizeMake(80, 80) completionBlock:^(UIImage *image) {
            strongifySelf
            self.photoView.image = image;

        }];
        
        //显示删除按钮
        self.deleteButton.hidden = NO;
    }
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *photoView = [[UIImageView alloc] init];
        photoView.backgroundColor = UIColorFromRGB(0xf1f1f1);
        photoView.contentMode = UIViewContentModeScaleAspectFill;
        photoView.userInteractionEnabled = YES;
        [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoViewClick)]];
        photoView.clipsToBounds = YES;
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"photoDelete"] forState:UIControlStateNormal];
        deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        deleteButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        [deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchDown];
        deleteButton.adjustsImageWhenHighlighted = NO;
        [self.contentView addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.photoView.frame = self.bounds;
    CGFloat btnwh = 35;
    self.deleteButton.frame = CGRectMake(self.frame.size.width - (btnwh -kCellContentViewCelltbMargin), -kCellContentViewCelltbMargin, btnwh, btnwh);
    
}

#pragma mark  event
/**
 *  图片点击事件
 */
- (void)photoViewClick
{
    //判断是否是默认的占位图片的点击
    if (_item.isDefaultPlaceholder) {  //如果是占位图点击 跳转到选择照片的界面
        
        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kCellContentViewCellAddBtnClickNotification object:_group];
        
        
    }else{ //跳转到相册预览的界面
        
        NSLog(@"预览相册");
        
        NSDictionary *dict = @{@"group":_group,@"item":_item,@"indexpath":_indexPath,@"view":self};

        //发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_PHOTOVIEWCONTROLLER_WATCHPHOTOS object:dict];
    
    }
    
}

/**
 *  删除按钮点击
 */
- (void)deleteButtonClick
{    
    //封装参数
    NSDictionary *dict = @{@"group":_group,@"item":_item,@"indexpath":_indexPath};
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCellContentViewCellDeleteBtnClickNotification object:dict];
    
    
}

@end

@implementation TMSCreateTideContentViewLayout

- (void)prepareLayout
{
    self.minimumLineSpacing = kCellContentViewItemRowMargin;  //行间距
    self.minimumInteritemSpacing = kCellContentViewItemClosMargin; //列间距
    self.itemSize = [TMSCreateTideHelper getItemSize];

}

@end


