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


#import "TMSHomeViewController.h"
#import "SYLoadingView.h"
#import "TianmushanAPI.h"
#import "TMSHomeCell.h"
#import "TMSCategoryItem.h"
#import "TMSDetailViewController.h"
#import "TMSHomeMode.h"
#import "TMSRefreshFooter.h"
#import "TMSRefreshHeader.h"
#import "TMSMYCollectionViewController.h"
#import "TMSNoLoginViewController.h"
#import "TMSTabBarController.h"
#import "TMSCreateTideController.h"
#import "TMSContentViewController.h"


#define TMSHomeViewControllerTopHeaderlineH 15
#define TMSHomeViewControllerTopHeaderH 193+TMSHomeViewControllerTopHeaderlineH


@interface TMSHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TMSHomeViewControllerHeaderDelegate,TMSHomeCellDelegate,TMSLoginViewDelegate,TMSNoLoginViewControllerDelegate>

/**datas*/
@property(nonatomic,strong)NSMutableArray *datas;

/**当前页*/
@property(nonatomic,assign)NSInteger currentPage;

/**总个数*/
@property(nonatomic,assign)NSInteger totalCount;

/**是否是上拉加载更多*/
@property(nonatomic,assign)BOOL pullUp;

/**头部视图*/
@property(nonatomic,weak)UIView *topHeaderView;

/**内容视图*/
@property(nonatomic,strong)UICollectionView *collectionView;

/**缓存文件名*/
@property(nonatomic,copy)NSString *TMSContentViewControllerCachePath;

/**加载失败提醒*/
@property(nonatomic,strong)UIView *homeNullHUD;

/**loadview*/
@property(nonatomic,strong)UIActivityIndicatorView *loadDataView;


/**保存当前点击cell对应的模型*/
@property(nonatomic,strong)TMSHomeMode *mode;


@end

@implementation TMSHomeViewController

static NSString * const reuseIdentifier = @"TMSHomeViewControllerCell";

static NSString * const TTMSHomeViewControllerReuseIdentifier= @"TMSHomeViewControllerHeader";

/**
 *  没有数据 提示视图
 *
 *  @return 视图对象
 */
- (UIView *)homeNullHUD
{
    if (!_homeNullHUD) {
        
        CGFloat y = TMSHomeViewControllerTopHeaderH+10;
        
        _homeNullHUD = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.view.width, SCREEN_HEIGHT - y - 44)];
        _homeNullHUD.hidden = YES;
        [self.collectionView addSubview:_homeNullHUD];
        
        UILabel *hudLabel = [[UILabel alloc] init];
        hudLabel.text = @"数据加载失败了~";
        hudLabel.textColor = UIColorFromRGB(0x999999);
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.font = [UIFont systemFontOfSize:16];
        [_homeNullHUD addSubview:hudLabel];
        hudLabel.sd_layout.topEqualToView(_homeNullHUD).offset(58).centerXEqualToView(_homeNullHUD).widthRatioToView(_homeNullHUD,0.98).heightIs(35);
        
        UIButton *doneBtn = [[UIButton alloc] init];
        [doneBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [doneBtn setTitleColor:UIColorFromRGB(0x30cdad) forState:UIControlStateNormal];
        doneBtn.layer.borderColor = UIColorFromRGB(0x30c0ad).CGColor;
        doneBtn.layer.borderWidth = 1;
        [doneBtn addTarget:self action:@selector(nullHUDDidClicked) forControlEvents:UIControlEventTouchDown];
        [_homeNullHUD addSubview:doneBtn];
        doneBtn.sd_cornerRadius = @20;
        doneBtn.sd_layout.topSpaceToView(hudLabel,20).centerXEqualToView(_homeNullHUD).widthIs(150).heightIs(40);
    }
    return _homeNullHUD;
}

- (UIActivityIndicatorView *)loadDataView
{
    if (!_loadDataView) {
        
        CGFloat wh = 40;
        CGFloat x = (self.view.width - wh)*0.5;
        CGFloat y = (SCREEN_HEIGHT - TMSHomeViewControllerTopHeaderH-44-64-wh)*0.5;
        _loadDataView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        _loadDataView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _loadDataView.hidesWhenStopped = YES;
        [self.collectionView addSubview:_loadDataView];
        _loadDataView.hidden = YES;
    }
    return _loadDataView;
}




/**
 *  模型数组
 *
 *  @return 模型数组
 */
- (NSMutableArray *)datas
{
    if (!_datas) {
        
        _datas = [NSMutableArray array];
        
    }
    return _datas;
}

#pragma mark  ======================== 初始化==========================

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initialSetup];
    [self createCollectionView];
    [self createTopHeader];    
    [self loadData];
}


#pragma mark 初始化设置
- (void)initialSetup
{
    //设置尺寸
    self.view.backgroundColor = GLOBALCOLOR;
    self.TMSContentViewControllerCachePath = @"TMSHomeViewController";
    
}

#pragma mark  ======================== 创建头部视图==========================

- (void)createTopHeader
{
    UIView *topHeaderViewBG = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.collectionView.width, TMSHomeViewControllerTopHeaderH)];
    [self.view addSubview:topHeaderViewBG];
    self.topHeaderView =topHeaderViewBG;
    
    UIButton *topHeaderView = [[UIButton alloc] initWithFrame:CGRectMake(13, 0, topHeaderViewBG.width-26,topHeaderViewBG.height-TMSHomeViewControllerTopHeaderlineH)];
    [topHeaderView addTarget:self action:@selector(topHeaderViewClick) forControlEvents:UIControlEventTouchDown ];
    topHeaderView.backgroundColor = [UIColor whiteColor];
    UIImageView *addPlus = [[UIImageView alloc] init];
    addPlus.image = [UIImage imageNamed:@"addplus"];
    
    CGFloat scale = 1.0;
    
    if (IS_IPHONE_5|| IS_IPHONE_4_OR_LESS) {
        
        scale = 0.4;
        
    }else{
        
        scale = 0.3;
        
    }
    CGFloat addh = topHeaderView.width*scale;
    
    addPlus.size = CGSizeMake(addh, addh);
    addPlus.top= 20;
    addPlus.left= (topHeaderView.width -addh)*0.5;
    addPlus.backgroundColor = [UIColor clearColor];
    [topHeaderView addSubview:addPlus];
    
    UILabel *title = [[UILabel alloc] init];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.text = @"创建潮报";
    title.frame = CGRectMake(0, CGRectGetMaxY(addPlus.frame)+5, topHeaderView.width, 30);
    [topHeaderView addSubview:title];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, topHeaderViewBG.height -TMSHomeViewControllerTopHeaderlineH, topHeaderViewBG.width, TMSHomeViewControllerTopHeaderlineH)];
    bottomView.backgroundColor = GLOBALCOLOR;
    [topHeaderViewBG addSubview:bottomView];
    
    CALayer *line = [CALayer layer];
    line.frame = CGRectMake(0, bottomView.height -1, bottomView.width, 1);
    line.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.3].CGColor;
    [bottomView.layer addSublayer:line];
    
    [topHeaderViewBG addSubview:topHeaderView];
    
}

/**
 *  头部视图的点击
 */
- (void)topHeaderViewClick
{
    TMSTabBarController *main=(TMSTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    main.selectedIndex = 1;
    
}


#pragma mark  ======================== 创建内容视图==========================

/**
 *  创建内容视图
 */
- (void)createCollectionView
{
    self.view.backgroundColor = GLOBALCOLOR;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:[[TMSHomeViewControllerLayout alloc] init]];
    
    collectionView.contentInset = UIEdgeInsetsMake(15+TMSHomeViewControllerTopHeaderH, 13, 64, 13);
    collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(15+TMSHomeViewControllerTopHeaderH, 0, 44, 0);
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollsToTop = NO;
    [self.collectionView registerClass:[TMSHomeCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[TMSHomeViewControllerHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TTMSHomeViewControllerReuseIdentifier];
    
    //KVO监听偏移量
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

/**
 *  监听内容视图的偏移量的改变
 *
 *  @param keyPath <#keyPath description#>
 *  @param object  <#object description#>
 *  @param change  <#change description#>
 *  @param context <#context description#>
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context

{
    
    if ([keyPath isEqualToString:@"contentOffset"])
        
    {
        
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
        
        if (offset.y<0) {
            
            
            CGFloat y =  -(TMSHomeViewControllerTopHeaderH - fabs(offset.y));
            
            self.topHeaderView.top =y;

            
        }else{
            
            self.topHeaderView.top = -(offset.y+TMSHomeViewControllerTopHeaderH);
            
        }
        
    }
    
}



#pragma mark  ========================加载数据==========================

#pragma mark  ========================加载数据==========================

/**
 *  加载数据
 */
- (void)loadData
{
    
    NSLog(@"loadDataloadDataloadDataloadDataloadDataloadData");
  

    //加载缓存数据
    NSString *cacheJson = [NSString stringWithContentsOfFile:[self.TMSContentViewControllerCachePath  cachePath] encoding:NSUTF8StringEncoding error:nil];
    
    //有缓存加载缓存数据
    if (cacheJson) {
        
        [self stopLoadDataView];
        NSDictionary *responseObject = [NSString dictionaryWithJson:cacheJson];
        [self loadReportDatas:responseObject];
        return;
        
    }else{
        
        self.loadDataView.hidden = NO;
        [self.loadDataView startAnimating];
    }
    
    
    self.currentPage = 1;

    
    //拼接url
    NSString *url = [[KRAPI_home stringByAppendingString:@"hot"] stringByAppendingString:[NSString stringWithFormat:@"/%zd",self.currentPage]];
    url = [url stringByAppendingString:@"?home=true"];
    
    //请求数据
    [[APIAgent sharedInstance] getFromUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
    
        
        //判断当前请求的数据是否和缓存中的数据一样
        NSString *newJson = [NSString jsonWithDictionary:responseObject];
        
        if (![cacheJson isEqualToString:newJson]) {
            
            //将新的结果集转换为json字符串 写入文件中
            [newJson writeToFile:[self.TMSContentViewControllerCachePath  cachePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            [self loadReportDatas:responseObject];
            
            [self stopLoadDataView];
            
            return;
            
        }
        
        if (self.datas.count<=0) {
            self.homeNullHUD.hidden = NO;
        }
        
        [self stopLoadDataView];
        
    } withFailure:^(NSString *error) {
        
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        
        if (self.datas.count<=0) {
            self.homeNullHUD.hidden = NO;
        }
        
        [self stopLoadDataView];
        
    }];
    
    
    
}

- (void)stopLoadDataView
{
    [self.loadDataView stopAnimating];
    [self.loadDataView removeFromSuperview];
    self.loadDataView = nil;
}

#pragma mark  =======================处理数据==========================

- (void)loadReportDatas:(NSDictionary*)responseObject
{
    //如果没有数据 就不处理
    if ([responseObject[@"rst"] isKindOfClass:[NSNull class]]) {
        
        if (self.datas.count<=0) {
            
            [self.collectionView.mj_footer endRefreshing];
            self.homeNullHUD.hidden = NO;
            
        }else {
            
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
        [self stopLoadDataView];
        
        
        return;
    }
    
        //如果没有数据 就不处理
        if (![responseObject[@"rst"][@"templates"] isKindOfClass:[NSNull class]]) {
            
            
            if ([(NSArray*)responseObject[@"rst"][@"templates"] count] > 0) {
                
                
                [self.homeNullHUD removeFromSuperview];
                self.homeNullHUD = nil;
                
                //删除之前的数据
                [self.datas removeAllObjects];
                
                for (NSDictionary *dict in responseObject[@"rst"][@"templates"]) {
                    
                    TMSHomeMode *model = [TMSHomeMode modalWithDict:dict];
                    
                    if ([model.catalog isEqualToString:@"photo"]) {
                        model.photoCategory = YES;
                    }
                    
                    [self.datas addObject:model];
                }
                
                
                
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView reloadData];

                //直接提示没有更多模版
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                
                [self stopLoadDataView];

                
                
            }else{
                
                [self stopLoadDataView];
                
                [self.collectionView.mj_header endRefreshing];
                self.homeNullHUD.hidden = NO;
                
            }
            
        }else{
            
            [self stopLoadDataView];
            
            [self.collectionView.mj_header endRefreshing];
            [self.collectionView.mj_footer endRefreshing];
            self.homeNullHUD.hidden = NO;
        }
    
    
}

#pragma mark  ========================datasource==========================

#pragma mark datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.datas.count?self.datas.count:0;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.datas.count && self.datas.count>=indexPath.row) {
        cell.homeMode = self.datas[indexPath.row];
    }
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    TMSDetailViewController *detail = [[TMSDetailViewController alloc] init];
    detail.watchTemplate = YES;
    if (self.datas.count && self.datas.count>=indexPath.row) {
        TMSHomeMode *mode = self.datas[indexPath.row];
        detail.url = mode.h5Url;
        detail.mode = mode;
        
    }
    [self.navigationController pushViewController:detail animated:YES];
}


- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader ) {
        
        TMSHomeViewControllerHeader *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TTMSHomeViewControllerReuseIdentifier forIndexPath:indexPath];
        reusableview.delegate = self;
        return reusableview;
        
    }else if (kind == UICollectionElementKindSectionFooter){
        
        return nil;
    }
    
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 40);
}

#pragma mark  ========================event==========================

#pragma mark TMSHomeCellDelegate
- (void)homeCell:(TMSHomeCell *)cell createTideBtnClicked:(TMSHomeMode *)mode
{
    self.mode = mode;
    
    //如果没有登录 提示用户登录
    if (![TMSCommonInfo accessToken]) {
        
        TMSLoginView *loginV = [TMSLoginView loginViewTitle:@"提示" message:@"你还没有登录 快去登录吧" delegate:self cancelButtonTitle:@"暂不登录" otherButtonTitle:@"立即登录"];
        
        [loginV show];
        
        return;
        
    }
    
    [self skipToEditTideController];
}


#pragma mark TMSLoginViewDelegate

- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    if (index == 0) {
        
        [view hide];
        
    }else if (index==1){
        
        [view hide];
        
        TMSNoLoginViewController *nologon = [[TMSNoLoginViewController alloc] init];
        nologon.delegate = self;
        [self.navigationController pushViewController:nologon animated:YES];
        
    }
}

#pragma mark TMSNoLoginViewControllerDelegate
- (void)noLoginViewControllerLoginSuccess:(TMSNoLoginViewController *)vc
{
    [self skipToEditTideController];
}

/**
 *  跳转到去制作界面
 */
- (void)skipToEditTideController
{
    NSLog(@"self.navigationController======%@",self.navigationController);
    TMSCreateTideController *createTide = [[TMSCreateTideController alloc] init];
    createTide.mode = self.mode;
    [self.navigationController pushViewController:createTide animated:YES];
}



#pragma mark 没有数据view点击
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
    [self loadData];
}

#pragma mark TMSHomeViewControllerHeaderDelegate  头部视图 更多按钮点击
- (void)homeViewControllerHeaderDidCliked:(TMSHomeViewControllerHeader *)header
{
    
    //跳转到热门分类
     TMSCategoryItem *cate = [[TMSCategoryItem alloc] init];
    cate.nick = @"热门";
    cate.name = @"hot";
    
    TMSContentViewController *contentvc = [[TMSContentViewController alloc] init];
    contentvc.item  = cate;
    [self.navigationController pushViewController:contentvc animated:YES];
    
}

- (void)dealloc
{
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

#pragma mark  ========================TMSHomeViewControllerLayout==========================

@implementation TMSHomeViewControllerLayout

- (void)prepareLayout
{
    CGFloat margin = 13;
    self.minimumLineSpacing = 15;
    self.minimumInteritemSpacing = 9;
    CGFloat itemW = (SCREEN_WIDTH - 2*margin - 9)*0.5;
    self.itemSize = CGSizeMake(itemW, itemW+70);
    
}


@end


#pragma mark  =============================section headerView=============================
@interface TMSHomeViewControllerHeader()

@property(nonatomic,weak)UIImageView *icon;

@property(nonatomic,weak)UILabel *title;

@property(nonatomic,weak)UIButton *moreBtn;

@property(nonatomic,weak)UIImageView *arrow;


@end

@implementation TMSHomeViewControllerHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
                
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot"]];
        [self addSubview:icon];
        self.icon = icon;
        
        UILabel *title = [[UILabel alloc] init];
        title.text =@"最热模板";
        title.font = [UIFont systemFontOfSize:17];
        title.textColor = UIColorFromRGB(0x333333);
        [self addSubview:title];
        self.title = title;
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:arrow];
        self.arrow = arrow;
        
        UIButton *moreBtn = [[UIButton alloc] init];
        [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moreBtn setTitleColor:UIColorFromRGB(0x777777) forState:UIControlStateNormal];
        moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchDown];
        [self addSubview:moreBtn];
        self.moreBtn = moreBtn;
        
        
        
        
    }
    return self;
}

- (void)moreBtnClick
{
    if ([self.delegate respondsToSelector:@selector(homeViewControllerHeaderDidCliked:)]) {
        [self.delegate homeViewControllerHeaderDidCliked:self];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = 17;
    
    self.icon.frame = CGRectMake(0, 15, height, height);
    
    self.title.frame = CGRectMake(CGRectGetMaxX(self.icon.frame)+10, 15, self.width*0.6, 17);
    
    CGFloat btnwh = 40;
    
    CGFloat arroww = 7;
    CGFloat arrowh = 12;
    self.arrow.frame = CGRectMake(self.width - arroww, 15, arroww, arrowh);
    self.moreBtn.frame = CGRectMake(self.width-btnwh-5-arroww, 0, btnwh, btnwh);

    
}



@end



