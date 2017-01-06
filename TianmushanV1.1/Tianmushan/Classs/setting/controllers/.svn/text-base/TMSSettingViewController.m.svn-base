/**************************************************************************
 *
 *  Created by shushaoyong on 2016/11/21.
 *    Copyright © 2016年 浙江踏潮流网络科技有限公司. All rights reserved.
 *
 * 项目名称：浙江踏潮-天目山-h5模版制作软件
 * 版权说明：本软件属浙江踏潮网络科技有限公司所有，在未获得浙江踏潮网络科技有限公司正式授权
 *           情况下，任何企业和个人，不能获取、阅读、安装、传播本软件涉及的任何受知
 *           识产权保护的内容。
 *
 ***************************************************************************/

#import "TMSSettingViewController.h"
#import "TMSSettingArrow.h"
#import "TMSSettingText.h"
#import "TMSSettingGroup.h"
#import "TMSSettingTextCell.h"
#import "TMSSettingArrowCell.h"
#import "TMSCacheCell.h"
#import "TMSFeedBackViewController.h"
#import "TianmushanAPI.h"
#import "TMSUpdateVersion.h"
#import "TMSAboutViewController.h"
#import "TMSProtocolViewController.h"
#import "TMSNoLoginViewController.h"
#import "TMSTabBarController.h"

@interface TMSSettingViewController ()<TMSLoginViewDelegate,TMSNoLoginViewControllerDelegate>

/**模型数组*/
@property(nonatomic,strong)NSMutableArray *settingDatas;

/**退出登录按钮*/
@property(nonatomic,weak) UIButton *loginOut;

/**更新模型*/
@property(nonatomic,strong)TMSUpdateVersion *version;

/**退出登录按钮被点击了*/
@property(nonatomic,assign)BOOL loginOutClicked;


@end

@implementation TMSSettingViewController

#pragma mark lazy
- (NSMutableArray *)settingDatas
{
    if (!_settingDatas) {
        _settingDatas = [NSMutableArray array];
    }
    return _settingDatas;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initPage];
    [self createData];
    [self createFooter];
    
}

- (void)initPage
{
    self.view.backgroundColor = GLOBALCOLOR;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 54, 44);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
}

- (void)createData
{
    
    weakifySelf
    
    TMSSettingGroup *group1 = [[TMSSettingGroup alloc] init];
    [self.settingDatas addObject:group1];

    TMSSettingText *version = [[TMSSettingText alloc] init];
    version.icon = @"myRepertdeleteicon";
    version.text = @"检查更新";
    NSString *shortVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    version.detail = [NSString stringWithFormat:@"V%@",shortVersion] ;
    version.opration = ^(){
        [weakSelf updateVersion];
    };
    [group1.items addObject:version];
    

    TMSSettingGroup *group2 = [[TMSSettingGroup alloc] init];
    [self.settingDatas addObject:group2];

    TMSSettingArrow *about = [[TMSSettingArrow alloc] init];
    about.arrowIcon = @"arrow";
    about.text = @"关于我们";
    about.opration = ^(){

        TMSAboutViewController *about = [[TMSAboutViewController alloc] init];
        [weakSelf.navigationController pushViewController:about animated:YES];
        
    };
    about.hiddenBottomline = YES;
    [group2.items addObject:about];
    
    TMSSettingArrow *protocol = [[TMSSettingArrow alloc] init];
    protocol.arrowIcon = @"arrow";
    protocol.text = @"用户协议";
    protocol.hiddenBottomline = YES;
    protocol.opration = ^(){
        
        TMSProtocolViewController *protocol = [[TMSProtocolViewController alloc] init];
        [weakSelf.navigationController pushViewController:protocol animated:YES];
        
        NSLog(@"用户协议");
    };
    [group2.items addObject:protocol];
    
    TMSSettingArrow *feedback = [[TMSSettingArrow alloc] init];
    feedback.arrowIcon = @"arrow";
    feedback.text = @"意见反馈";
    
    
    feedback.opration = ^(){
        TMSFeedBackViewController *feedback = [[TMSFeedBackViewController alloc] init];
        [weakSelf.navigationController pushViewController:feedback animated:YES];
    };
    [group2.items addObject:feedback];

    
    TMSSettingGroup *group3 = [[TMSSettingGroup alloc] init];
    [self.settingDatas addObject:group3];
    
}

- (void)createFooter
{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 49)];
    footerV.backgroundColor = [UIColor whiteColor];
    UIButton *loginOut = [[UIButton alloc] initWithFrame:CGRectZero];
    CGFloat btnw = 150;
    CGFloat btnh = 30;
    loginOut.width = btnw;
    loginOut.height = btnh;
    loginOut.left = (footerV.width -btnw)*0.5;
    loginOut.top = (footerV.height- btnh)*0.5;
    loginOut.titleLabel.font = [UIFont systemFontOfSize:16];
    
    if ([TMSCommonInfo accessToken]) {
        [loginOut setTitle:@"退出登录" forState:UIControlStateNormal];
        [loginOut addTarget:self action:@selector(loginOutBtnClick) forControlEvents:UIControlEventTouchDown];
    }else{
        [loginOut setTitle:@"登录" forState:UIControlStateNormal];
        [loginOut addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchDown];
    }
    
    self.loginOut = loginOut;
    [loginOut setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [footerV addSubview:loginOut];
    self.tableView.tableFooterView = footerV;
    self.tableView.sectionFooterHeight = footerV.height;
    
    CALayer *topline = [CALayer layer];
    topline.backgroundColor =[UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
    [footerV.layer addSublayer:topline];
    topline.frame = CGRectMake(0, 0, footerV.width, 1);
    
    CALayer *bottomline = [CALayer layer];
    bottomline.backgroundColor = [UIColorFromRGB(0xdddddd) colorWithAlphaComponent:0.5].CGColor;
    [footerV.layer addSublayer:bottomline];
    bottomline.frame = CGRectMake(0, footerV.height-1, footerV.width, 1);
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.settingDatas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    TMSSettingGroup *group = self.settingDatas[section];
    
    return group.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSSettingGroup *group = self.settingDatas[indexPath.section];
    id cellM = group.items[indexPath.row];
    
    UITableViewCell *dircell = nil;
   
    if ([cellM isKindOfClass:[TMSSettingText class]]) {
        TMSSettingTextCell *cell = [TMSSettingTextCell cell:tableView];
        cell.mode = group.items[indexPath.row];
        dircell = cell;
    }else if ([cellM isKindOfClass:[TMSSettingArrow class]]){
        TMSSettingArrowCell *cell = [TMSSettingArrowCell cell:tableView];
        cell.mode = group.items[indexPath.row];
        dircell = cell;
    }

    return dircell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMSSettingGroup *group = self.settingDatas[indexPath.section];
    id cellM = group.items[indexPath.row];
    
    if ([cellM isKindOfClass:[TMSSettingText class]]) {
        TMSSettingText *text = (TMSSettingText*)cellM;
        text.opration();
    }else if ([cellM isKindOfClass:[TMSSettingArrow class]]){
        TMSSettingArrow *arrow = (TMSSettingArrow*)cellM;
        arrow.opration();
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] init];
    header.backgroundColor =[UIColor clearColor];
    header.frame = CGRectMake(0, 0, 0, 10);
    return header;
}

#pragma mark 退出登录按钮点击
- (void)loginOutBtnClick
{
    self.version = nil;
    self.loginOutClicked = YES;

    TMSLoginView *loginV = [TMSLoginView loginViewTitle:@"提示" message:@"您确定退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"退出"];
    
    [loginV show];
    
    
  
}

- (void)loginBtnClick
{
    self.loginOutClicked = NO;
    
    TMSNoLoginViewController *nologin = [[TMSNoLoginViewController alloc] init];
    nologin.delegate = self;
    [self.navigationController pushViewController:nologin animated:YES];
}


#pragma mark TMSLoginViewDelegate

- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    
    if (self.version) {
        
        if (index == 0) {
            
            [view hide];
            
        }else if (index==1){
            
            [view hide];
            
            NSURL *url = [NSURL URLWithString:self.version.downloadurl];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
                
            }
        }
        
        return;
    }
    
    if (index == 0) {
        
        [view hide];
        
    }else if (index==1){
        
        [view hide];
        
        
        [TMSCommonInfo setOpenid:nil];
        [TMSCommonInfo setAccessToken:nil];
        
        //删除缓存文件
//        NSFileManager *mgr = [NSFileManager defaultManager];
//        
//        NSLog(@"缓存目录====%@",[NSString cacheDirectory]);
//        
//        NSError *error = nil;
//        [mgr removeItemAtPath:[NSString cacheDirectory] error:&error];
//        
//        if (error == nil) {
//            NSLog(@"删除缓存目录成功");
//        }
       
        self.tableView.tableFooterView = nil;
        
        //重新创建
        [self createFooter];
        
        [self.view showSucess:@"退出登录成功"];
        
        
        //发送退出登录的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINOUTNOTIFICATION object:nil];
        
        
        
        //延迟0.5秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            TMSNoLoginViewController *nologin = [[TMSNoLoginViewController alloc] init];
            nologin.delegate = self;
            [self.navigationController pushViewController:nologin animated:YES];
            
            
        });
 
    }
}

#pragma mark TMSNoLoginViewControllerDelegate
- (void)noLoginViewControllerLoginSuccess:(TMSNoLoginViewController *)vc
{
//        if (!self.loginOutClicked) {
//            
//            self.tableView.tableFooterView = nil;
//            [self createFooter];
//            
//        }else{
    
          //如果退出了登录 跳转到登录界面 登录成功跳转到首页
            
          //重新设置窗口的根控制器
            TMSTabBarController *tabbar =  [[TMSTabBarController alloc] init];
            tabbar.selectedIndex = 0;
            [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
    
            
//        }
    
}



#pragma mark
- (void)backItemClick
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 检查更新
- (void)updateVersion
{
    [self.view showActivity];
    
    [[APIAgent sharedInstance] getFromUrl:KRAPI_Checkversion params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
            NSDictionary *dict = responseObject[@"rst"];
            
            if ([dict isKindOfClass:[NSNull class]]) {
                return;
            }

            if ([dict isKindOfClass:[NSDictionary class]]) {
                
                self.version = [TMSUpdateVersion modalWithDict:dict];
                
                [self.view hideActivity];

                if (self.version) {
                    
                    //如果当前的版本 和 服务器的版本不一致
                    if ([self.version.version floatValue] > CurrentVersion) {
                        
                        TMSLoginView *loginView = [TMSLoginView loginViewTitle:@"发现新版本" message:self.version.desc delegate:self cancelButtonTitle:@"稍后更新" cancleBtnColor:UIColorFromRGB(0x666666) otherButtonTitle:@"立即更新" otherButtonColor:[UIColor redColor]];
                        
                        [loginView show];
                        
                    }else{
                        
                        [self.view showSucess:@"当前已经是最新的版本"];

                    }
                    
                }
                
            }
            
        } withFailure:^(NSString *error) {
            
            NSLog(@"%@",error);
            
        }];

}


@end
