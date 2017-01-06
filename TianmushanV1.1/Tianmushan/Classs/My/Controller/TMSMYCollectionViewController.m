//
//  TMSCollectionViewController.m
//  Tianmushan
//
//  Created by shushaoyong on 2016/10/26.
//  Copyright © 2016年 踏潮. All rights reserved.

#import "TMSMYCollectionViewController.H"
#import "TianmushanAPI.h"
#import "UIBarButtonItem+TMSBarbutonItem.h"
#import "TMSHomeMode.h"
#import "TianmushanAPI.h"
#import "SYLoadingView.h"
#import "TMSMyReportGroup.h"
#import "TMSDetailViewController.h"
#import "TMSShareModel.h"
#import "TMSRefreshHeader.h"
#import "TMSSettingViewController.h"
#import "TMSNoLoginViewController.h"
#import "TMSTabBarController.h"

@interface TMSMYCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TMSMYCollectionViewCellDelegate,TMSNoLoginViewControllerDelegate>

/**内容视图*/
@property(nonatomic,weak) UICollectionView *collectionView;

/*是否正在执行加载更多动画*/
@property(nonatomic,assign)BOOL isAnimating;

//*datas
@property(nonatomic,strong)NSMutableArray *datas;


//*当前页
@property(nonatomic,assign)NSInteger currentPage;

//*总个数
@property(nonatomic,assign)NSInteger totalCount;

//*是否是上拉加载更多
@property(nonatomic,assign)BOOL pullUp;

/**上一次长按的cell*/
@property(nonatomic,strong)TMSMYCollectionViewCell *lastCell;

//没有数据 或者没有登录提示的view
@property(nonatomic,strong)UIView *nullHUD;

/**loadview*/
@property(nonatomic,strong)SYLoadingView *loadDataView;

/**提示文字*/
@property(nonatomic,weak) UILabel *hudLabel;
/**操作按钮*/
@property(nonatomic,weak)UIButton *doneBtn;

/**当前需要删除的模型*/
@property(nonatomic,strong)TMSHomeMode *item;

/**当前需要删除的cell*/
@property(nonatomic,strong)TMSMYCollectionViewCell *cell;

@end

@implementation TMSMYCollectionViewController

static NSString * const TMSMYCollectionVcreuseIdentifier = @"UICollectionViewCell";
static NSString * const TMSMYCollectionVchdaderreuseIdentifier = @"TMSMYCollectionViewHeader";
static NSString * const TMSMYCollectionVcCachePath = @"TMSMYCollectionVcCachePath.data";

- (UIView *)nullHUD
{
    if (!_nullHUD) {
        
        _nullHUD = [[UIView alloc] init];
        _nullHUD.backgroundColor = GLOBALCOLOR;
        _nullHUD.hidden = YES;
        [self.view addSubview:_nullHUD];
        
        _nullHUD.sd_layout.topEqualToView(self.view).rightEqualToView(self.view).leftEqualToView(self.view).bottomEqualToView(self.view);
        
        UIImageView *logoView = [[UIImageView alloc] init];
        logoView.image = [UIImage imageNamed:@"grayLogo"];
        [_nullHUD addSubview:logoView];
        logoView.sd_layout.topEqualToView(_nullHUD).offset(75).centerXEqualToView(_nullHUD).widthIs(100).heightIs(100);

        
        UILabel *hudLabel = [[UILabel alloc] init];
        hudLabel.text = @"你还没有创建潮报呢!";
        hudLabel.textColor = UIColorFromRGB(0x555555);
        hudLabel.textAlignment = NSTextAlignmentCenter;
        hudLabel.font = [UIFont systemFontOfSize:16];
        [_nullHUD addSubview:hudLabel];
        hudLabel.sd_layout.topSpaceToView(logoView,40).centerXEqualToView(_nullHUD).widthRatioToView(_nullHUD,0.98).heightIs(16);
        self.hudLabel = hudLabel;
        
        UIButton *doneBtn = [[UIButton alloc] init];
        [doneBtn setTitle:@"创建潮报" forState:UIControlStateNormal];
        [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        doneBtn.backgroundColor = UIColorFromRGB(0x30cdad);
        
        //用户没有登录跳转到登录界面
        if ([TMSCommonInfo accessToken]) {
            [doneBtn addTarget:self action:@selector(nullHUDDidClicked) forControlEvents:UIControlEventTouchDown];
        }else{
            hudLabel.text = @"你还没有登录呢!";
            [doneBtn setTitle:@"立即登录" forState:UIControlStateNormal];
            [doneBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchDown];
        }
        [_nullHUD addSubview:doneBtn];
        doneBtn.sd_cornerRadius = @20;
        
        doneBtn.sd_layout.topSpaceToView(hudLabel,25).centerXEqualToView(_nullHUD).widthIs(150).heightIs(40);
        
        self.doneBtn = doneBtn;
    }
    return _nullHUD;
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



- (NSMutableArray *)datas
{
    if (!_datas) {
        
        _datas = [NSMutableArray array];
        
    }
    return _datas;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initPage];
    
    //用户没有登录跳转到登录界面
    if ([TMSCommonInfo accessToken] == nil) {
        self.nullHUD.hidden = NO;
    }else{
        //已经登录 加载数据
        [self loadData];
    }
    
}


/**
 *  初始化页面
 */
- (void)initPage
{
    self.view.backgroundColor = CUSTOMCOLOR(247, 247, 247);
    
    self.title = @"我的";
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[TMSMyContentViewLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.contentInset = UIEdgeInsetsMake(10, 13, 64+44, 13);
    collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(10, 0, 64+44, 0);
    [self.view addSubview:collectionView];
    self.collectionView= collectionView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barbuttonitemWithTitle:@"设置" target:self action:@selector(settingBtnClick)];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] init]];
    
    [self.collectionView registerClass:[TMSMYCollectionViewCell class] forCellWithReuseIdentifier:TMSMYCollectionVcreuseIdentifier];
    
    [self.collectionView registerClass:[TMSMYCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TMSMYCollectionVchdaderreuseIdentifier];
    
    self.currentPage = 1;
    
    TMSRefreshHeader *header = [TMSRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.arrowView.image = [UIImage imageNamed:@"newRefresh"];
    header.stateLabel.text = @"下拉加载最新";
    [header setTitle:@"刷新数据中" forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.textColor = UIColorFromRGB(0xb9b9b9);
    self.collectionView.mj_header = header;
    
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.stateLabel.textColor = UIColorFromRGB(0xb9b9b9);
    [footer setTitle:@"没有更多潮报了" forState:MJRefreshStateNoMoreData];
    self.collectionView.mj_footer = footer;
    
    
    //如果需要滑动手势添加
    if (self.panEabled) {
        [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)]];
    }
    

    //监听登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:KRAPI_MEMBER_LOGINOUTNOTIFICATION object:nil];
}


- (void)pan{}


/**
 *  加载最新数据
 */
- (void)loadNewData
{
    
    NSLog(@"loadNewDataloadNewDataloadNewDataloadNewData");
    
    self.pullUp = NO;
    
    //取消删除动画
    [self cancleLongPress];
    
    self.currentPage = 1;
    
    [self.collectionView.mj_header beginRefreshing];
    
    //同时请求数据
    NSString *url = [[KRAPI_Mynews stringByAppendingString:[TMSCommonInfo Openid]] stringByAppendingString:[NSString stringWithFormat:@"/%zd",self.currentPage]];
    
    [[APIAgent sharedInstance] getFromUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        
        if ([responseObject[@"code"] longLongValue] != 0) {
            [self.nullHUD removeFromSuperview];
            self.nullHUD = nil;
            self.nullHUD.hidden = NO;
            [self.collectionView.mj_header endRefreshing];
            return;
        }
        
        //将结果集转换为json字符串 写入文件中
        NSString *json = [NSString jsonWithDictionary:responseObject];
        
        [json writeToFile:[TMSMYCollectionVcCachePath  cachePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        [self loadReportDatas:responseObject];
        
    } withFailure:^(NSString *error) {
        
        [self.collectionView.mj_header endRefreshing];
        
    }];
    
    
}


/**
 *  加载更多数据
 */
- (void)loadMoreData
{
    self.pullUp = YES;
    [self loadData];
}


/**
 *  加载最新的数据
 */
- (void)loadData
{
    
    if (!self.pullUp) { //如果是下拉刷新 设置页数位1

        self.loadDataView.hidden = NO;
        
        self.currentPage = 1;
    }else{
    
        self.currentPage++;
        
    }

    //加载缓存数据
    NSString *cacheJson = [NSString stringWithContentsOfFile:[TMSMYCollectionVcCachePath  cachePath] encoding:NSUTF8StringEncoding error:nil];
    
    //有缓存加载缓存数据
    if (cacheJson) {
        NSDictionary *responseObject = [NSString dictionaryWithJson:cacheJson];
        [self loadReportDatas:responseObject];
        [self.loadDataView removeFromSuperview];

    }
    
    //同时请求数据
    NSString *url = [[KRAPI_Mynews stringByAppendingString:[TMSCommonInfo Openid]?[TMSCommonInfo Openid]:@""] stringByAppendingString:[NSString stringWithFormat:@"/%zd",self.currentPage]];
    
    [[APIAgent sharedInstance] getFromUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        if ([responseObject[@"code"] longLongValue] != 0) {
            [SYLoadingView dismiss];
            [self.nullHUD removeFromSuperview];
            self.nullHUD= nil;
            self.nullHUD.hidden = NO;
            return;
        }
        
        //如果是上拉加载更多 不需要缓存
        if (self.pullUp) {
            
            [self loadReportDatas:responseObject];
            [self.loadDataView removeFromSuperview];

            return;
        }
        
        //判断当前请求的数据是否和缓存中的数据一样
        NSString *newJson = [NSString jsonWithDictionary:responseObject];
        
        if (![cacheJson isEqualToString:newJson]) {
        
            //将结果集转换为json字符串 写入文件中
            NSString *json = [NSString jsonWithDictionary:responseObject];
            [json writeToFile:[TMSMYCollectionVcCachePath  cachePath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
            [self loadReportDatas:responseObject];
            [self.loadDataView removeFromSuperview];

            return;
            
        }
        

        if (self.datas.count<=0) {

            self.nullHUD.hidden = NO;
        }
        
        [self.loadDataView removeFromSuperview];

        
     
    } withFailure:^(NSString *error) {
        
        
        [self.collectionView.mj_header endRefreshing];

        [self.loadDataView removeFromSuperview];

        if (self.datas.count<=0) {
            
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            
            self.nullHUD.hidden = NO;
        }
        
        
    }];
    

}


/**
 *  处理服务器返回的数据
 *
 *  @param responseObject <#responseObject description#>
 */
- (void)loadReportDatas:(NSDictionary*)responseObject
{
    
    //如果没有数据 就不处理
    if ([responseObject[@"rst"] isKindOfClass:[NSNull class]]) {
        
        if (self.datas.count<=0) {
            
            [self.collectionView.mj_footer endRefreshing];
            self.nullHUD.hidden = NO;
            
        }else if (self.datas.count>= self.totalCount) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
    
        
        
        return;
    }
    
    NSArray *TemplateRosArray = responseObject[@"rst"][@"tianmuMountTemplateRos"];
    
    //没有数据
    if ([TemplateRosArray isKindOfClass:[NSNull class]]) {
        
        [self.loadDataView removeFromSuperview];
        self.nullHUD.hidden = NO;
        
        return;
        
    }
    
    
    NSArray *responseArray = responseObject[@"rst"][@"tianmuMountTemplateRos"];
    
    
    if (![responseArray isKindOfClass:[NSNull class]]) {
        
        //上拉加载
        if (self.pullUp) {
            
            
            if ([ responseArray count] > 0) {
                
                NSMutableArray *temp = [NSMutableArray array];
                
                for (NSDictionary *dict in responseArray) {
                    
                    if ([dict isKindOfClass:[NSNull class]]) {
                        continue;
                    }
                    
                    TMSMyReportGroup *group = [TMSMyReportGroup modalWithDict:dict];
                    [temp addObject:group];
                }
                
                [self.datas addObjectsFromArray:temp];
                
                if (self.datas.count== self.totalCount) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }
                
                [self.collectionView reloadData];
                
                
            }else{
                
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                
            }

            
        }else{ //首次刷新
            
            self.pullUp = NO;
            
            self.totalCount = [responseObject[@"count"] integerValue];
            
            //如果没有数据 就不处理
            if (![responseArray isKindOfClass:[NSNull class]]) {
                
                
                if ([responseArray count] > 0) {
                    
                    [self.nullHUD removeFromSuperview];
                    self.nullHUD = nil;
                    
                 
                    
                    //删除之前的数据
                    [self.datas removeAllObjects];
                    
                    for (NSDictionary *dict in responseArray) {
                        
                        if ([dict isKindOfClass:[NSNull class]]) {
                            continue;
                        }
                        
                        TMSMyReportGroup *group = [TMSMyReportGroup modalWithDict:dict];
                        [self.datas addObject:group];
                    }
                    
                    

                    [self.collectionView.mj_header endRefreshing];
                    
                    [self.collectionView reloadData];
                    
                    

                    if (self.datas.count>=self.totalCount) {
                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                    }
                    
                    [self.loadDataView removeFromSuperview];

                    
                }else{
                    [self.collectionView.mj_header endRefreshing];

                    [self.loadDataView removeFromSuperview];
                    self.nullHUD.hidden = NO;
                    
                }
                
            }else{
                
                [self.collectionView.mj_header endRefreshing];

                [self.loadDataView removeFromSuperview];
                self.nullHUD.hidden = NO;
            }
        }
        
    }
    
}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.datas.count?self.datas.count:0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    TMSMyReportGroup *group = self.datas[section];
    
    return group.templates.count?group.templates.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSMyReportGroup *group = self.datas[indexPath.section];
    
    
    TMSMYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TMSMYCollectionVcreuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    if (group.templates.count>=indexPath.row) {
        TMSHomeMode *mode = group.templates[indexPath.row];
        cell.model = mode;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datas.count<=0) {
        return;
    }
    
    TMSMyReportGroup *group = self.datas[indexPath.section];
    if (group.templates.count<=0) {
        return;
    }
    
    TMSHomeMode *mode = group.templates[indexPath.row];
    
    TMSDetailViewController *detail = [[TMSDetailViewController alloc] init];
    detail.panEabled = YES;
    detail.url = mode.h5Url;
    detail.watchTemplate = NO;
    detail.myReportJoin = YES;
    detail.mode = mode;
    
    //创建分享模型
    TMSShareModel *shareM = [[TMSShareModel alloc] init];
    shareM.imageurl = mode.imageUrl;
    shareM.h5url = mode.h5Url;
    shareM.title = mode.title;
    shareM.desc = mode.desc;
    detail.shareMode = shareM;
    [self.navigationController pushViewController:detail animated:YES];

}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if (kind == UICollectionElementKindSectionHeader ) {
    
        TMSMYCollectionViewHeader *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TMSMYCollectionVchdaderreuseIdentifier forIndexPath:indexPath];
        
            TMSMyReportGroup *group = self.datas[indexPath.section];
            
            reusableview.lable.text = group.daytime;
 
            return reusableview;
        
    }else if (kind == UICollectionElementKindSectionFooter){
    
        return nil;
    }
    
    return nil;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 42);
}



#pragma mark TMSMYCollectionViewCellDelegate
/**
 *  长按了当前的cell
 *
 *  @param cell 当前被点击的cell
 */
- (void)mYCollectionViewCellDidLongpress:(TMSMYCollectionViewCell*)cell
{
    
    //设置导航栏左边的标题为取消
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftBarbuttonitemWithTitle:@"取消" target:self action:@selector(cancleLongPress)];
    
    //给所有的模型设置长按手势为yes
    for (TMSMyReportGroup *group in self.datas) {
        
        for ( TMSHomeMode *mode in group.templates) {
            
            mode.longPress = YES;
            
        }
        
    }
    
    //刷新数据
    [self.collectionView reloadData];
    

}

/**
 *  取消长按手势
 */
- (void)cancleLongPress
{
    
    //给所有的模型设置长按手势为yes
    for (TMSMyReportGroup *group in self.datas) {
        
        for ( TMSHomeMode *mode in group.templates) {
            
            mode.longPress = NO;
            
        }
        
    }
    
    //刷新数据
    [self.collectionView reloadData];

    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    //移除导航栏左侧按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem leftBarbuttonitemWithTitle:@"" target:self  action:@selector(cancleLongPress)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.navigationItem.leftBarButtonItem.enabled = YES;

    });
}

/**
 *  删除按钮被点击了
 *
 *  @param cell 当前被点击的cell
 *  @param item 当前模型
 */
- (void)mYCollectionViewCellDidDeleteClicked:(TMSMYCollectionViewCell*)cell item:(TMSHomeMode *)item
{
    
    self.navigationItem.leftBarButtonItem.enabled = NO;

    self.item = item;
    self.cell = cell;
    
    TMSLoginView *loginV = [TMSLoginView loginViewTitle:@"提示" message:@"您确定删除此潮报吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"删除"];
    
    [loginV show];
    
}

#pragma mark TMSLoginViewDelegate

- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    if (index == 0) {
        
        [view hide];
        
    }else if (index==1){
        
        [view hide];
      
        //删除潮报
        [self deleteMyTide];
        
    }
}


- (void)deleteMyTide
{
    
    self.loadDataView = nil;
    self.loadDataView.hidden = NO;
    
    weakifySelf
    //发送请求删除当前潮报
    [self deleteMyReportWithItem:self.item completions:^{
    
        strongifySelf
        
        //获取当前的indexpath
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:self.cell];
        
        // 获取当前的组
        TMSMyReportGroup *group = self.datas[indexPath.section];
        
        //删除组模型
        [group.templates removeObject:self.item];
       
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

        //如果没有数据了就删除组
        if (group.templates.count <= 0) {
            
        
            [self.datas removeObject:group];
            
            //获取当前的cell
            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]];

            
        }
        
        NSLog(@"self.datas.count=====%zd",self.datas.count);
        
        //如果只有一组 并且是最佳的时候 就重新加载数据
        if (self.datas.count==1) {
            
            // 获取当前的组
            TMSMyReportGroup *group = self.datas[0];
            
            if ([group.daytime rangeOfString:@"最佳"].length>0) {
                
                self.navigationItem.leftBarButtonItem = [UIBarButtonItem barbuttonitemWithTitle:@"" target:nil action:nil];
                
                [self.collectionView.mj_header beginRefreshing];
                
            }
            
        }else{
            
            //刷新数据
            [self.collectionView reloadData];
            
            
        }
     
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self.loadDataView removeFromSuperview];

    }];
}



/**
 *  删除我的潮报
 *
 *  @param item        删除的潮报模型
 *  @param completions 完成的回调
 */
- (void)deleteMyReportWithItem:(TMSHomeMode*)item completions:(void(^)())completions
{
    
    NSString *url=[KRAPI_DeleteReport stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",[TMSCommonInfo Openid],item.reportid]];
    [[APIAgent sharedInstance] getFromUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
       
        if ([responseObject[@"code"] longLongValue] == 0) {
            
            [self.view showError:@"删除我的潮报成功！"];
            
            if (completions) {
                completions();
            }
        }
        
    } withFailure:^(NSString *error) {
        
        [self.view showError:@"删除潮报失败！"];
        
        self.navigationItem.leftBarButtonItem.enabled = YES;
        [self.loadDataView removeFromSuperview];
        self.loadDataView = nil;
        
    }];
}



#pragma mark TMSNodataHUDDelegate
- (void)nullHUDDidClicked
{
    TMSTabBarController *tabbar = (TMSTabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabbar.selectedIndex = 1;
    
}


#pragma mark 设置按钮点击
- (void)settingBtnClick
{
    
    TMSSettingViewController *settingVC = [[TMSSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
    
    
}

/**
 *  没有登录跳转到登录界面
 */
- (void)loginBtnClick
{
    TMSNoLoginViewController *nologin = [[TMSNoLoginViewController alloc] init];
    nologin.delegate = self;
    [self.navigationController pushViewController:nologin animated:YES];
}


#pragma mark TMSNoLoginViewControllerDelegate
- (void)noLoginViewControllerLoginSuccess:(TMSNoLoginViewController *)vc
{
    self.nullHUD.hidden = YES;
    self.nullHUD = nil;
    
    //加载数据
    [self loadData];
    
}

/**
 *  登录成功的通知
 */
- (void)loginSuccess
{
    //加载数据
    [self loadData];
    
}

/**
 *  退出登录的通知
 */
- (void)loginOut
{
    
    //显示提示框
    [self.nullHUD removeFromSuperview];
    self.nullHUD = nil;
    self.nullHUD.hidden = NO;
}




- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

#pragma mark 布局对象
@implementation TMSMyContentViewLayout

- (void)prepareLayout
{
    CGFloat margin = 13;
    self.minimumLineSpacing = 15;
    self.minimumInteritemSpacing = 9;
    
    CGFloat itemW = (SCREEN_WIDTH - 2*margin -9)*0.5;
    self.itemSize = CGSizeMake(itemW, itemW+50);
    
}

@end



#pragma mark 头部视图
@interface TMSMYCollectionViewHeader()

@end
@implementation TMSMYCollectionViewHeader 

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        lable.font = [UIFont systemFontOfSize:17];
        lable.textColor = UIColorFromRGB(0x333333);
        [self addSubview:lable];
        self.lable =lable;
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lable.frame = self.bounds;
}

@end




#pragma mark cell
@interface TMSMYCollectionViewCell()

/**cover*/
@property(nonatomic,weak)UIImageView *cover;

/**浏览量*/
@property(nonatomic,weak)UIButton *bottomLabel;

/**标题*/
@property(nonatomic,weak)UILabel *titleLabel;

/**是否点击了长按*/
@property(nonatomic,assign)BOOL longpress;


@end

@implementation TMSMYCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *cover = [[UIImageView alloc] init];
        cover.image = [UIImage imageNamed:@"default"];
        cover.contentMode = UIViewContentModeScaleAspectFill;
        cover.clipsToBounds = YES;
        cover.userInteractionEnabled = YES;
        [cover addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(coverLongpress)]];
        [self.contentView addSubview:cover];
        self.cover = cover;
        
        UIButton *bottomLabel = [[UIButton alloc] init];
        
        [bottomLabel setTitle:@"100000" forState:UIControlStateNormal];
        [bottomLabel setImage:[UIImage imageNamed:@"watch"] forState:UIControlStateNormal];
        [bottomLabel setTitleColor:CUSTOMCOLOR(68, 68, 68) forState:UIControlStateNormal];
        bottomLabel.titleLabel.font = [UIFont systemFontOfSize:12];
        bottomLabel.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        bottomLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [self.contentView addSubview:bottomLabel];
        self.bottomLabel = bottomLabel;
        
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"myRepertdeleteicon"] forState:UIControlStateNormal];
        deleteButton.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
        deleteButton.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        deleteButton.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, -5);
        [deleteButton addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchDown];
        deleteButton.hidden = YES;
        [self.contentView addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = UIColorFromRGB(0x444444);
        [self.contentView addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        titleLabel.layer.borderColor = UIColorFromRGB(0xebebeb).CGColor;
        titleLabel.layer.borderWidth = 1;
        
    }
    return self;
}

//长按手势
- (void)coverLongpress
{
    //如果已经是长按手势
    if (self.model.isLongPress) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(mYCollectionViewCellDidLongpress:)]) {
        [self.delegate mYCollectionViewCellDidLongpress:self];
    }
    
}

//删除按钮点击
- (void)deleteBtnClick
{
    if ([self.delegate respondsToSelector:@selector(mYCollectionViewCellDidDeleteClicked:item:)]) {
        [self.delegate mYCollectionViewCellDidDeleteClicked:self item:self.model];
    }
}


- (void)setModel:(TMSHomeMode *)model
{
    _model = model;
    
    //长按了
    if (model.isLongPress) {
        
        //显示删除按钮
        self.deleteButton.hidden = NO;
        
        //添加抖动动画
        [self.layer addAnimation:[self addAnimation] forKey:@"longpress"];

        
    }else{
        
        //隐藏删除按钮
        self.deleteButton.hidden = YES;
        
        //移除抖动动画
        [self.layer removeAnimationForKey:@"longpress"];
        
    }
    
    //下载图片
    [self.cover yy_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholder:[UIImage imageNamed:@"default"] options:YYWebImageOptionSetImageWithFadeAnimation|YYWebImageOptionProgressiveBlur completion:nil];
    
    
    //设置标题
    [self.bottomLabel setTitle:[NSString stringWithFormat:@"%zd",model.num?model.num:0] forState:UIControlStateNormal];
    
    self.titleLabel.text = model.title?model.title:@"暂无标题";
    
}

/**
 *  添加抖动动画
 *
 *  @return <#return value description#>
 */
- (CAKeyframeAnimation*)addAnimation
{
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-5 / 180.0 * M_PI),@(5 /180.0 * M_PI),@(-5/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.25;
    keyAnimaion.repeatCount = MAXFLOAT;
    return keyAnimaion;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat deletebtnwh = 40;
    CGFloat deletebtnx = self.contentView.bounds.size.width - deletebtnwh;
    self.deleteButton.frame = CGRectMake(deletebtnx, 0, deletebtnwh, deletebtnwh);
    
    CGFloat titleH = 40;
    CGFloat titley = self.height - titleH;
    self.titleLabel.frame = CGRectMake(0, titley, self.width, titleH);
    
    self.cover.frame = CGRectMake(0, 0, self.width, self.height - titleH);
    
    CGFloat labelw = 40;
    CGFloat labelh = 20;

    //获取字体的宽度
    if (self.model.num) {
        
        CGFloat newW = [[NSString stringWithFormat:@"%zd",self.model.num] getTextWidthWithMaxHeight:labelh fontSize:12];
        
        //如果文字的宽度超过最大的宽度 就改变宽度值
        if (newW > (labelw - 25)) {
            labelw = newW+25;
        }
        
    }
    CGFloat labely = titley - labelh;
    CGFloat labelx = self.width - labelw;
    self.bottomLabel.frame = CGRectMake(labelx, labely, labelw, labelh);

}



@end
