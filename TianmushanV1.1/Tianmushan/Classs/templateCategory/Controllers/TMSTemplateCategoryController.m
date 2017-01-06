/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/24.
 *    Copyright © 2016年 踏潮. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSTemplateCategoryController.h"
#import "TianmushanAPI.h"
#import "TMSCategoryItem.h"
#import "TMSContentViewController.h"
#import "SYLoadingView.h"
#import "TMSNodataHUD.h"

@interface TMSTemplateCategoryController ()<TMSNodataHUDDelegate>

/**datas*/
@property(nonatomic,strong)NSMutableArray *datas;

/**缓存文件名*/
@property(nonatomic,copy)NSString *TMSContentViewControllerCachePath;

/**加载失败提醒*/
@property(nonatomic,strong)UIView *homeNullHUD;

/**loadview*/
@property(nonatomic,strong)SYLoadingView *loadDataView;

/**提示文字*/
@property(nonatomic,weak) UILabel *hudLabel;

/**操作按钮*/
@property(nonatomic,weak)UIButton *doneBtn;


@end

@implementation TMSTemplateCategoryController

- (instancetype)init
{
    if (self = [super initWithCollectionViewLayout:[[TMSTemplateCategoryLayout alloc] init]]){
        self.collectionView.backgroundColor = CUSTOMCOLOR(247, 247, 247);
        self.collectionView.contentInset = UIEdgeInsetsMake(15, 13, 20+44, 13);
    }
    return self;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

/**
 *  没有数据 提示视图
 *
 *  @return 视图对象
 */
- (UIView *)homeNullHUD
{
    if (!_homeNullHUD) {
        
        _homeNullHUD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _homeNullHUD.hidden = YES;
        [self.collectionView addSubview:_homeNullHUD];
        
        UILabel *hudLabel = [[UILabel alloc] init];
        hudLabel.text = @"数据加载失败了~";
        hudLabel.textColor = UIColorFromRGB(0x999999);
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.font = [UIFont systemFontOfSize:16];
        [_homeNullHUD addSubview:hudLabel];
        hudLabel.sd_layout.centerYEqualToView(_homeNullHUD).offset(-65).centerXEqualToView(_homeNullHUD).widthRatioToView(_homeNullHUD,0.98).heightIs(35);
        self.hudLabel = hudLabel;
        
        UIButton *doneBtn = [[UIButton alloc] init];
        [doneBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [doneBtn setTitleColor:UIColorFromRGB(0x30cdad) forState:UIControlStateNormal];
        doneBtn.layer.borderColor = UIColorFromRGB(0x30c0ad).CGColor;
        doneBtn.layer.borderWidth = 1;
        [doneBtn addTarget:self action:@selector(nullHUDDidClicked) forControlEvents:UIControlEventTouchDown];
        [_homeNullHUD addSubview:doneBtn];
        self.doneBtn = doneBtn;
        doneBtn.sd_cornerRadius = @20;
        doneBtn.sd_layout.topSpaceToView(hudLabel,15).centerXEqualToView(_homeNullHUD).widthIs(150).heightIs(40);
    }
    return _homeNullHUD;
}

- (SYLoadingView *)loadDataView
{
    if (!_loadDataView) {
        _loadDataView = [[SYLoadingView alloc] initWithFrame:CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.view addSubview:_loadDataView];
        _loadDataView.hidden = YES;
    }
    return _loadDataView;
}



static NSString * const reuseIdentifier = @"TMSTemplateCategoryCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
        
    //缓存路径
    self.TMSContentViewControllerCachePath = @"TMSTemplateCategoryController";
    
    [self.collectionView registerClass:[TMSTemplateCategoryCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self loadCategorys];
    
//    [self addobserverNetworkStatus];
}

/**
 *  监听网络状态改变
 */
//- (void)addobserverNetworkStatus
//{
//    
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        
//        NSLog(@"status===%zd",status);
//        
//        //有网络 刷新数据
//        if (status != AFNetworkReachabilityStatusNotReachable && status != AFNetworkReachabilityStatusNotReachable) {
//            
//            if (self.datas.count<=0) {
//                [self loadCategorys];
//            }
//        }
//        
//    }];
//    
//    
//}



/**
 *  加载分类数据
 */
- (void)loadCategorys
{
    
    self.loadDataView.hidden = NO;
    
    //加载缓存数据
    NSString *cacheJson = [NSString stringWithContentsOfFile:[self.TMSContentViewControllerCachePath  cachePath] encoding:NSUTF8StringEncoding error:nil];
    
    
    //有缓存加载缓存数据
    if (cacheJson) {
        NSDictionary *responseObject = [NSString dictionaryWithJson:cacheJson];
        [self loadReportDatas:responseObject];
        [self.loadDataView removeFromSuperview];

    }
    
    
    [[APIAgent sharedInstance] getFromUrl:KRAPI_ReportCategory params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
                
        //判断当前请求的数据是否和缓存中的数据一样
        NSString *newJson = [NSString jsonWithDictionary:responseObject];
        
        if (![cacheJson isEqualToString:newJson]) {
            
            //将结果集转换为json字符串 写入文件中
            NSString *json = [NSString jsonWithDictionary:responseObject];
            
            [json writeToFile:[self.TMSContentViewControllerCachePath  cachePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            
            [self loadReportDatas:responseObject];
            
            self.loadDataView.hidden = YES;
            
            
            return;
        }
        
        if (self.datas.count<=0) {
            self.homeNullHUD.hidden = NO;
        }
        
        self.loadDataView.hidden = YES;
        
    } withFailure:^(NSString *error) {
        
        //加载缓存数据
        NSString *cacheJson = [NSString stringWithContentsOfFile:[self.TMSContentViewControllerCachePath  cachePath] encoding:NSUTF8StringEncoding error:nil];
        
        //有缓存加载缓存数据
        if (cacheJson) {
            NSDictionary *responseObject = [NSString dictionaryWithJson:cacheJson];
            [self loadReportDatas:responseObject];
        }else{
            if (self.datas.count<=0) {
                self.homeNullHUD.hidden = NO;
            }
        }
        
        self.loadDataView.hidden = YES;
        
    }];
    
}

#pragma mark TMSNodataHUDDelegate
- (void)nodataHUDDidClicked:(TMSNodataHUD *)view
{
    [self loadCategorys];
}

- (void)loadReportDatas:(NSDictionary*)responseObject
{
    id rst =  responseObject[@"rst"];
    
    if (![rst isKindOfClass:[NSNull class]]) {
        
        id catelog  = responseObject[@"rst"][@"catalog"];
        
        if (![catelog isKindOfClass:[NSNull class]]) {
            
            if ([catelog isKindOfClass:[NSArray class]]) {
                
                [self.datas removeAllObjects];
                
                NSArray *response = (NSArray*)catelog;
                
                for (NSDictionary *dict in response) {
                    TMSCategoryItem *cate = [TMSCategoryItem modalWithDict:dict];
                    [self.datas addObject:cate];
                }
                
                [self.collectionView reloadData];
                
                [self.loadDataView removeFromSuperview];

                
            }
            
        }
    }
    
    self.loadDataView.hidden = YES;
    
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count?self.datas.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSTemplateCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.category = self.datas[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TMSContentViewController *content =[[TMSContentViewController alloc] init];
    content.item = self.datas[indexPath.row];
    [self.navigationController pushViewController:content animated:YES];
}

/**
 *  没有数据 view点击
 */
- (void)nullHUDDidClicked
{
    if ([[AFNetworkReachabilityManager sharedManager] isReachable] == NO) {
        
        [self.view showError:@"网络无法连接，请稍后重试！"];
        
        return;
    }
    
    self.loadDataView = nil;
    [self.homeNullHUD removeFromSuperview];
    self.homeNullHUD = nil;
    [self loadCategorys];
}



@end

@interface TMSTemplateCategoryCell()

/**背景图片*/
@property(nonatomic,weak)UIImageView *bgImageV;

/**标题*/
@property(nonatomic,weak) UILabel *title;


@end

@implementation TMSTemplateCategoryCell

- (void)setCategory:(TMSCategoryItem *)category
{
    _category = category;
    
    [self.bgImageV yy_setImageWithURL:[NSURL URLWithString:category.imageurl] placeholder:[UIImage imageNamed:@"default"] options:YYWebImageOptionProgressiveBlur|YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    
    self.title.text = [NSString stringWithFormat:@"#%@",category.nick];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *bgImageV = [[UIImageView alloc] init];
        bgImageV.image = [UIImage imageNamed:@"bg"];
        bgImageV.clipsToBounds = YES;
        bgImageV.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:bgImageV];
        self.bgImageV = bgImageV;
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"";
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:17];
        title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:title];
        self.title = title;
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgImageV.frame = self.bounds;
    
    self.title.frame = CGRectMake(0, 0, self.width, self.height);
}

@end

@implementation TMSTemplateCategoryLayout

- (void)prepareLayout
{
    CGFloat margin = 13;
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 9;
    CGFloat itemW = (SCREEN_WIDTH - 2*margin - 9)*0.5;
    self.itemSize = CGSizeMake(itemW, itemW-20);
    
}


@end

