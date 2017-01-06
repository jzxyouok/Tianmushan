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

#import "TMSCreateTideController.h"
#import "TianmushanAPI.h"
#import "TMSCreateTideHeader.h"
#import "TMSCreateTideContentView.h"
#import "TMSCreateTideGroup.h"
#import "PhotoItem.h"
#import "TMSPhotoGroupViewController.h"
#import "TMSNavigationController.h"
#import "PhotoBrowserController.h"
#import "TMSPhotoLibraryTool.h"
#import "TMSMusicTool.h"
#import "TMSCreateTideHelper.h"
#import "SYLoadingView.h"
#import "TMSPlaceholderTextView.h"
#import "TMSCreateTideMusicCell.h"
#import "TMSDetailViewController.h"
#import "SZCalendarPicker.h"
#import "TMSCreatTideDateButton.h"
#import "WHC_KeyboardManager.h"

@interface TMSCreateTideController ()<TMSCreateTideMusicCellDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,TMSLoginViewDelegate>

/**照片数组*/
@property(nonatomic,strong)NSMutableArray *photos;

/**创建scrollview*/
@property(nonatomic,weak)UIScrollView *scrollView;

/**顶部描述view*/
@property(nonatomic,weak)UIView *TopDescView;

/**顶部标题view*/
@property(nonatomic,weak)UIView *topTitleView;

/**顶部标题输入框*/
@property(nonatomic,strong)UITextField *titleInputView;

/**图片控件数组*/
@property(nonatomic,strong)NSMutableArray *pictureViews;

/**图片控件对应的图片模型数组*/
@property(nonatomic,strong)NSMutableArray *pictureModes;

/**保存用户当前点击添加图片 正在添加图片的组*/
@property(nonatomic,strong)TMSCreateTideGroup *addPhotosGroup;

/**上一次操作的音乐view*/
@property(nonatomic,strong) TMSCreateTideMusicCell  *lastSelMusicView;

/**上一次操作的音乐播放按钮*/
@property(nonatomic,strong) UIButton *musicPlay;

/**结果集字典 上传给服务器的结果*/
@property(nonatomic,strong)NSMutableDictionary *resultDatas;

/**创建模板辅助类*/
@property(nonatomic,strong)TMSCreateTideHelper *helper;

/**音乐控件*/
@property(nonatomic,weak)UITableView *musicTablieView;

/**音乐控件对应的模型数据*/
@property(nonatomic,strong)NSMutableArray *musics;

/**是否需要处理文本框成为第一响应者的事件  yes 为需要 no 不需要*/
@property(nonatomic,assign)BOOL needDisposeBecome;

/**picsize 保存相册需要上传的最大的照片个数*/
@property(nonatomic,assign)NSInteger picSize;

/**当前被点击的文本控件*/
@property(nonatomic,weak)UIView *currentClickedTextView;

/**键盘配置对象*/
@property(nonatomic,strong)WHC_KBMConfiguration *configuration;

@end

@implementation TMSCreateTideController

#pragma mark lazy
/**
 *  所有的图片控件的数据模型 里面装的是TMSCreateTideGroup模型
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

/**
 *  所有的图片控件 里面装的是TMSCreateTideContentView
 *
 *  @return <#return value description#>
 */
-(NSMutableArray *)pictureViews
{
    if (!_pictureViews) {
        _pictureViews = [NSMutableArray array];
    }
    return _pictureViews;
}

/**
 *  图片控件对应的图片数据模型 里面装的TMSHomeImageMode数组
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)pictureModes
{
    if (!_pictureModes) {
        _pictureModes = [NSMutableArray array];
    }
    return _pictureModes;
}

/**
 *  结果集对象
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary *)resultDatas
{
    if (!_resultDatas) {
        _resultDatas = [NSMutableDictionary dictionary];
    }
    return _resultDatas;
}

/**
 *  模板辅助类
 *
 *  @return <#return value description#>
 */
- (TMSCreateTideHelper *)helper
{
    if (!_helper) {
        _helper = [[TMSCreateTideHelper alloc] init];
    }
    return _helper;

}

/**
 *  音乐模型数据
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)musics
{
    if (!_musics) {
        _musics = [NSMutableArray array];
    }
    return _musics;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //初始化设置
    [self setup];
    
    //监听内容视图 删除按钮 和 添加按钮的点击发出的通知
    [self addObservers];
    
    //根据配置文件动态创建界面元素
    [self createContentView];
    
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan)]];
    
   
}

/**
 *  禁用右滑手势
 */
- (void)pan{}

/**
 *  初始化设置
 */
- (void)setup
{
    
    self.picSize = self.mode.picSize;
    self.view.autoresizingMask = UIViewAutoresizingNone;
    self.needDisposeBecome = YES;
    self.title = @"制作潮报";
    self.view.backgroundColor = GLOBALCOLOR;

    //添加最外层的内容视图
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.bounces = NO;
    
    scrollview.delegate = self;
    scrollview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollview];
    self.scrollView = scrollview;
    scrollview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.view,0).bottomEqualToView(self.view);
    
    
    CGFloat margin = 13;

   //添加顶部描述的view
    UIView *topDescView = [[UIView alloc] init];
    topDescView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [scrollview addSubview:topDescView];

    topDescView.sd_layout.leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).topEqualToView(self.scrollView).heightIs(kCellTitleViewH);
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"请按照下面步骤进行编辑";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = UIColorFromRGB(0x777777);
    [topDescView addSubview:title];
    title.sd_layout.leftSpaceToView(topDescView,margin).topEqualToView(topDescView).rightSpaceToView(topDescView,margin).heightIs(kCellTitleViewH);

    //添加顶部标题
    UIView *topTitleView = [[UILabel alloc] init];
    topTitleView.backgroundColor = [UIColor whiteColor];
    [scrollview addSubview:topTitleView];
    topTitleView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(topDescView,0).rightEqualToView(self.view).heightIs(80);
    
    CGFloat titilBgviewTopMargin = 15;
    UIView *titilBgview = [[UIView alloc] init];
    titilBgview.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [scrollview addSubview:titilBgview];
    titilBgview.sd_layout.leftSpaceToView(scrollview,titilBgviewTopMargin).rightSpaceToView(scrollview,titilBgviewTopMargin).heightIs(50).topSpaceToView(topDescView,titilBgviewTopMargin);
    titilBgview.sd_cornerRadius = @7;
    

    CGFloat labelMargin = 13;
    UILabel *label = [[UILabel alloc] init];
    label.text = @"潮报标题:";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = CUSTOMCOLOR(16, 16, 16);
    [scrollview addSubview:label];
    label.sd_layout.leftEqualToView(titilBgview).offset(labelMargin).centerYEqualToView(titilBgview).widthIs(80).heightRatioToView(titilBgview,0.8);

    UITextField *titleInputView = [[UITextField alloc] init];
    titleInputView.placeholder = @"请输入标题(建议15字以内)";
    titleInputView.returnKeyType = UIReturnKeyDone;
    titleInputView.delegate = self;
    [titleInputView setValue:UIColorFromRGB(0xb5b5b5) forKeyPath:@"_placeholderLabel.textColor"];
    titleInputView.font = [UIFont systemFontOfSize:14];
    titleInputView.textColor = UIColorFromRGB(0x333333);
    titleInputView.tintColor =  UIColorFromRGB(0xb5b5b5);
    titleInputView.borderStyle = UITextBorderStyleNone;
    [scrollview addSubview:titleInputView];
    titleInputView.sd_layout.leftSpaceToView(label,0).centerYEqualToView(titilBgview).widthRatioToView(titilBgview,0.7).heightIs(33);
    self.titleInputView = titleInputView;
    
    UIView *middleSeparatorView = [[UIView alloc] init];
    middleSeparatorView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    [scrollview addSubview:middleSeparatorView];
    middleSeparatorView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(topTitleView,0).rightEqualToView(self.scrollView).heightIs(10);
    self.topTitleView = middleSeparatorView;

    
}

/**
 *  创建内容视图
 */
- (void)createContentView
{
    
    //设置模型
    if (self.mode) {
        
        //记录最后添加的控件
        __block UIView *lastView = nil;
        
        CGFloat margin = 13;
        
        //保存标题
        self.resultDatas[@"title"] = self.titleInputView;
        
        //创建内容数组保存所有的控件
        NSMutableArray *contentArray =  [NSMutableArray array];
        
        NSLog(@"self.mode.configList======%@",self.mode.configList);
        
        for (int i = 0 ; i< self.mode.configList.count ; i++) {
            
            //获取当前这一页的配置
            NSDictionary *configDict = self.mode.configList[i];
            
            if (configDict==nil || ![configDict isKindOfClass:[NSDictionary class]]) {
                return;
            }
            
            //创建单个的结果字典 保存控件
            NSMutableDictionary *sigleResult =  [NSMutableDictionary dictionary];
            
            
                //判断当前的顺序对应的健 如果是标题
                //=================================处理标题部分=======================================================
                if (configDict[@"title"]) {
                    
                    UIView *titilBgview = [[UIView alloc] init];
                
                    [self.scrollView addSubview:titilBgview];
                    
                    UILabel *oldTitleLabel = nil;
                    
                    if (lastView) {
                        
                        titilBgview.sd_layout.leftSpaceToView(self.scrollView,0).rightSpaceToView(self.scrollView,0).heightIs(40).topSpaceToView(lastView,0);
                        
                        UILabel *titleLabel = [[UILabel alloc] init];
                        titleLabel.textAlignment = NSTextAlignmentCenter;
                        titleLabel.textColor = UIColorFromRGB(0x333333);
                        titleLabel.font = [UIFont systemFontOfSize:15];
                        titleLabel.text = configDict[@"title"];
                        [self.scrollView addSubview:titleLabel];
                        titleLabel.sd_layout.leftEqualToView(titilBgview).bottomEqualToView(titilBgview).rightEqualToView(titilBgview).topEqualToView(titilBgview).offset(8);
                        oldTitleLabel = titleLabel;
                        
                        
                    }else{
                        
                        titilBgview.sd_layout.leftSpaceToView(self.scrollView,0).rightSpaceToView(self.scrollView,0).heightIs(40).topSpaceToView(self.topTitleView,0);
                        
                        UILabel *titleLabel = [[UILabel alloc] init];
                        titleLabel.textAlignment = NSTextAlignmentCenter;
                        titleLabel.textColor = UIColorFromRGB(0x333333);
                        titleLabel.font = [UIFont systemFontOfSize:15];
                        titleLabel.text = configDict[@"title"];
                        [self.scrollView addSubview:titleLabel];
                        titleLabel.sd_layout.leftEqualToView(titilBgview).bottomEqualToView(titilBgview).rightEqualToView(titilBgview).topEqualToView(titilBgview).offset(10);
                        oldTitleLabel = titleLabel;
                        
                    }
                    
                    lastView = titilBgview;
                    
                }else{ //没有标题就创建一个空的标题
                    
                    sigleResult[@"title"] = @"";
                    
                }
                //=================================处理标题部分结束=======================================================
                
                //=================================处理短文本部分=======================================================
                if (configDict[@"shortText"]) {
                    
                    UITextField *lastInputText = nil;
                    
                    NSMutableArray *inputTexts = [NSMutableArray array];
                    
                    NSArray *shortTexts = (NSArray*)configDict[@"shortText"];
                    
                    for (int i = 0 ; i<shortTexts.count ; i++) {
                        
                        
                        //如果是时间直接添加按钮
                        if ([shortTexts[i] rangeOfString:@"时间"].length >0) {
                            
                            
                        }
                        
                        UITextField *inputText = [[UITextField alloc] init];
                        inputText.placeholder = shortTexts[i];
                        inputText.delegate = self;
                        inputText.returnKeyType = UIReturnKeyDone;
                        inputText.borderStyle = UITextBorderStyleNone;
                        inputText.font = [UIFont systemFontOfSize:14];
                        inputText.backgroundColor = UIColorFromRGB(0xf1f1f1);
                        [inputText setValue:UIColorFromRGB(0xb5b5b5) forKeyPath:@"_placeholderLabel.textColor"];
                        [inputText setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];

                        inputText.tintColor = UIColorFromRGB(0xb5b5b5);
                        inputText.textColor = UIColorFromRGB(0x333333);
                        inputText.sd_cornerRadius = @8;
                        inputText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, kCellBottomInputH)];
                        inputText.leftViewMode = UITextFieldViewModeAlways;
                        [self.scrollView addSubview:inputText];
                      
                        
                        if (lastInputText) {
                            
                            inputText.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(lastInputText,10).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomInputH);
                        
                            
                        }else{
                            
                            if (lastView) {
                                
                                inputText.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(lastView,15).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomInputH);
                                
                            }else{
                                
                                inputText.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(self.topTitleView,15).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomInputH);
                                
                            }
                            
                        }
                        
                        
                        
                        //如果是时间文本框 在上面添加一个按钮
                        NSLog(@"range == %@",NSStringFromRange([inputText.placeholder rangeOfString:@"时间"]));
                        
                        if ([inputText.placeholder rangeOfString:@"时间"].length >0) {
                            inputText.enabled = NO;
                            TMSCreatTideDateButton *selDatePickerBtn = [[TMSCreatTideDateButton alloc] init];
                            selDatePickerBtn.textField = inputText;
                            selDatePickerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                            selDatePickerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                            [selDatePickerBtn setTitleColor:UIColorFromRGB(0xb5b5b5) forState:UIControlStateNormal];
                            selDatePickerBtn.backgroundColor = [UIColor clearColor];
                            [self.scrollView addSubview:selDatePickerBtn];
                            [selDatePickerBtn addTarget:self action:@selector(selDatePickerBtn:) forControlEvents:UIControlEventTouchDown];
                            selDatePickerBtn.sd_layout.leftEqualToView(inputText).topEqualToView(inputText).rightEqualToView(inputText).bottomEqualToView(inputText);
                            
                            
                            
                        }
                        
                        lastInputText = inputText;
                        
                        lastView = inputText;
                        
                        [inputTexts addObject:inputText];
                        
                    }
                    
                    //如果有短文本再保存
                    sigleResult[@"shortText"] = inputTexts;
                    
                    
                }else{ //如果没有短文本就创建一个空的短文本
                    
                    //如果有短文本再保存
                    sigleResult[@"shortText"] = [NSArray array];
                    
                    
                }
                //=================================处理短文本部分结束=======================================================
                
                //=================================处理长文本部分开始=======================================================
                if (configDict[@"longText"]) {
                    
                    UITextView *lastTextView = nil;
                    
                    NSMutableArray *textViews = [NSMutableArray array];
                    
                    NSArray *longTexts = (NSArray*)configDict[@"longText"];
                    
                    for (int i = 0 ; i<longTexts.count ; i++) {
                        
                        TMSPlaceholderTextView *textView = [[TMSPlaceholderTextView alloc] init];
                        textView.textContainerInset = UIEdgeInsetsMake(8, 5, 8, 5);//设置页边距
                        textView.showsHorizontalScrollIndicator = NO;
                        textView.showsVerticalScrollIndicator = NO;
                        textView.bounces = NO;
                        textView.delegate = self;
                        textView.returnKeyType = UIReturnKeyDone;
                        textView.placeholder = longTexts[i];
                        textView.placeholderColor = UIColorFromRGB(0xb5b5b5);
                        textView.textColor = UIColorFromRGB(0x333333);
                        textView.font = [UIFont systemFontOfSize:14];
                        textView.backgroundColor = UIColorFromRGB(0xf1f1f1);
                        textView.tintColor = UIColorFromRGB(0xb5b5b5);
                        textView.sd_cornerRadius = @8;
                        [self.scrollView addSubview:textView];
                        
                        if (lastTextView) {
                            
                            textView.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(lastTextView,10).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomContentInputH);
                            
                        }else{
                            
                            
                            if (lastView) {
                                
                                textView.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(lastView,15).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomContentInputH);
                                
                            }else{
                                
                                textView.sd_layout.leftEqualToView(self.scrollView).offset(margin).topSpaceToView(self.topTitleView,15).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomContentInputH);
                                
                            }
                            
                            
                        }
                        lastTextView = lastTextView;
                        lastView = textView;
                        [textViews addObject:textView];
                    }
                    
                    sigleResult[@"longText"] = textViews;
                    
                }else{ //如果没有长文本就创建一个空的长文本
                    
                    sigleResult[@"longText"] = [NSArray array];

                }
                //=================================处理长文本部分结束=======================================================
                
                
                //=================================处理照片部分开始=======================================================
                
                if (configDict[@"picture"]) { //如果是图片
                    
                    //获取照片数组
                    NSArray *array = (NSArray*)configDict[@"picture"];
                    
                 
                    if ([array count]) { //如果有照片就创建
                        
                        //记录当前的picture 图片上传控件对应的图片模型的个数
                        [self.pictureModes  addObject:array];
                    
                        
                        NSMutableArray *picViews = [NSMutableArray array];
                        
                        //创建照片视图
                        for (int i = 0 ; i< array.count ; i++) {
                            
                            //内容视图
                            TMSCreateTideContentView *contentV = [[TMSCreateTideContentView alloc] init];
                            
                            [self.pictureViews addObject:contentV];
                            
                            [picViews addObject:contentV];
                            
                            [self.scrollView addSubview:contentV];
                            
                            
                            if (lastView) {
                                
                                contentV.sd_layout.topSpaceToView(lastView,0).leftEqualToView(self.scrollView).offset(margin).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomContentDefaultH);
                                
                            }else{
                                
                                contentV.sd_layout.topSpaceToView(self.topTitleView,15).leftEqualToView(self.scrollView).offset(margin).rightSpaceToView(self.scrollView,margin).heightIs(kCellBottomContentDefaultH);
                                
                            }
                            
                            lastView = contentV;
                            
   
                         
                            
                        }
                        
                        
                        //创建照片
                        sigleResult[@"picture"] = picViews;
                        
                        
            
    
                    }else{ //如果没有照片 就直接创建一个空的数组
                        
                        //创建照片
                        sigleResult[@"picture"] = [NSArray array];
                        
                    }
                
                 
                    
                }
              
                
//            }];
            
            
            //=================================处理照片部分结束=======================================================
           
            
            //前面所有的控件添加结束完成 添加分割线
            UIView *middleSeparatorLine = [[UIView alloc] init];
            middleSeparatorLine.backgroundColor = UIColorFromRGB(0xf1f1f1);
            [self.scrollView addSubview:middleSeparatorLine];
            middleSeparatorLine.sd_layout.topSpaceToView(lastView,15).leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(1);
            lastView = middleSeparatorLine;
            
            //添加当前这一组到总的组数组
            [contentArray addObject:sigleResult];
            
            
        }
    
        
        //创建控件结束
        //如果有音乐 就添加音乐控件
        if (self.mode.musicList.count) {
            
            
            UIView *middleSeparatorView = [[UIView alloc] init];
            middleSeparatorView.backgroundColor = UIColorFromRGB(0xf1f1f1);
            [self.scrollView addSubview:middleSeparatorView];
            
            if (lastView) {
                middleSeparatorView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(lastView,0).rightEqualToView(self.scrollView).heightIs(10);

            }else{
            
                self.scrollView.backgroundColor = UIColorFromRGB(0xf1f1f1);

                middleSeparatorView.sd_layout.leftEqualToView(self.scrollView).topSpaceToView(self.topTitleView,0).rightEqualToView(self.scrollView).heightIs(0);

            }
            lastView = middleSeparatorView;
            
            
            // 添加上传音乐view
            CGFloat titilBgviewTopMargin = 0;
            
            UIView *titilBgview = [[UIView alloc] init];
            titilBgview.backgroundColor = [UIColor whiteColor];
            [self.scrollView addSubview:titilBgview];
            
            
            titilBgview.sd_layout.leftSpaceToView(self.scrollView,0).rightSpaceToView(self.scrollView,0).heightIs(45).topSpaceToView(lastView,titilBgviewTopMargin);
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.textColor = UIColorFromRGB(0x333333);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.text = @"选择音乐";
            [self.scrollView addSubview:titleLabel];
            titleLabel.sd_layout.leftEqualToView(titilBgview).topEqualToView(titilBgview).offset(8).rightEqualToView(titilBgview).heightIs(40);
            
            lastView = titilBgview;
            
            
            //创建音乐的TablieView
            UITableView *musicTablieView = [[UITableView alloc] init];
            musicTablieView.scrollEnabled = NO;
            musicTablieView.separatorStyle = UITableViewCellSeparatorStyleNone;
            musicTablieView.dataSource = self;
            [self.scrollView addSubview:musicTablieView];
            self.musicTablieView = musicTablieView;
            
            if (lastView) {
                
                musicTablieView.sd_layout.topSpaceToView(lastView,0).leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(self.mode.musicList.count*45);
            }else{
                
                musicTablieView.sd_layout.topSpaceToView(titilBgview,0).leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(self.mode.musicList.count*45);
            }
            
            lastView = musicTablieView;
            
        }
        
        //添加底部view
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = UIColorFromRGB(0xf1f1f1);
        [self.scrollView addSubview:footerView];
        
        //解决键盘回移动上去问题
        if (self.mode.configList.count<=0) {
            
            //不要显示键盘上面的小工具条
            self.configuration.enableHeader = NO;
            
            //不准滑动
            self.scrollView.scrollEnabled = NO;
            
            //增加高度
            footerView.sd_layout.topSpaceToView(lastView,-5).leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(350);

        }else{
            
            footerView.sd_layout.topSpaceToView(lastView,-5).leftEqualToView(self.scrollView).rightEqualToView(self.scrollView).heightIs(250);

        }
        
        //添加生成按钮
        UIButton *createButton = [[UIButton alloc] init];
        createButton.backgroundColor = CUSTOMCOLOR(59, 204, 173);
        [createButton setTitle:@"预览潮报" forState:UIControlStateNormal];
        [createButton addTarget:self action:@selector(createTideBtnClick) forControlEvents:UIControlEventTouchDown];
        [createButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.scrollView addSubview:createButton];
        createButton.sd_layout.topSpaceToView(lastView,29).centerXEqualToView(self.scrollView).widthIs(150).heightIs(40);
        createButton.sd_cornerRadius = @20;
        lastView = footerView;
        
        //高度自动适应
        [self.scrollView setupAutoHeightWithBottomView:lastView bottomMargin:0];
    
        self.resultDatas[@"content"] = contentArray;

        //将所有的配置信息转换为相应的配置模型 方便处理
        NSArray *tempConfigList =  self.mode.configList;
        
        if (tempConfigList.count<=0) {
            return;
        }
        
        NSMutableArray *temp = [NSMutableArray array];
        
        for (NSDictionary *dict in tempConfigList) {
            TMSHomeConfig *mode = [TMSHomeConfig modalWithDict:dict];
            [temp addObject:mode];
        }
        
        tempConfigList = temp;
    
        //修改配置数组为配置模型数组
        self.mode.configModelList = [tempConfigList copy];
        
        
        //转换图片记录模型
        NSMutableArray *temp1 = [NSMutableArray array];
        for (NSArray *array in self.pictureModes) {
            for (NSDictionary *dict in array) {
                TMSHomeImageMode *mode = [TMSHomeImageMode modalWithDict:dict];
                [temp1 addObject:mode];
            }
        
        }
        self.pictureModes = [temp1 mutableCopy];
        
        
        //for循环遍历结束
        //遍历图片模型数组 设置图片控件的顺序
            for (TMSHomeImageMode *imageMode in self.pictureModes) {
                
                TMSCreateTideGroup *group = [[TMSCreateTideGroup alloc] init];
                //传递配置信息
                group.photoConfigs = imageMode;
                group.maxNum = imageMode.picNum;
                if (!group.title) {
                    group.title = imageMode.name?imageMode.name:@"上传图片";
                }
                
                [self.photos addObject:group];

    
            }
    

    
        for (int i = 0 ; i< self.photos.count ; i++) {
            
            TMSCreateTideGroup *group  = self.photos[i];
            TMSCreateTideContentView *contentV = self.pictureViews[i];
            [contentV configGroup:group];
            contentV.sd_layout.heightIs([TMSCreateTideHelper getContentViewHeight:group.photos maxNum:NO]) ;
            
        }
        
    }

    
}


#pragma mark  监听内容视图 删除按钮 和 添加按钮的点击发出的通知
- (void)addObservers
{
    //监听添加按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addBtnClick:) name:kCellContentViewCellAddBtnClickNotification object:nil];
    
    //监听删除按钮点击
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteBtnClick:) name:kCellContentViewCellDeleteBtnClickNotification object:nil];
    
    //添加照片选择完成发出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photosDidFinish:) name:KRAPI_PHOTOVIEWCONTROLLER_DIDFINISHPHOTOS object:nil];
    
    //监听预览图点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(watchPhotos:) name:KRAPI_PHOTOVIEWCONTROLLER_WATCHPHOTOS object:nil];
    
    //监听生成潮报完成的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createTideFinished:) name:KRAPI_CREATETIDE_FINISHEDNOTE object:nil];

    
    /*******只需要在要处理键盘的界面创建WHC_KeyboardManager对象即可无需任何其他设置*******/
   self.configuration =  [[WHC_KeyboardManager share] addMonitorViewController:self];

}

/**
 *  生成潮报完成的通知
 *
 *  @param note <#note description#>
 */

- (void)createTideFinished:(NSNotification*)note
{
    
//    [self.resultDatas removeAllObjects];
//    [self.pictureViews removeAllObjects];
//    [self.pictureModes removeAllObjects];
//    [self.photos removeAllObjects];
    
    TMSShareModel *mode = note.object;

    //4.上传成功 跳转到预览界面
    TMSDetailViewController *detail = [[TMSDetailViewController alloc] init];
    detail.watchTemplate = NO;
    detail.url = mode.h5url;
    detail.shareMode = mode;
    detail.mode = self.mode;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark event
/**
 *  点击了添加按钮
 */
- (void)addBtnClick:(NSNotification*)note
{
    //获取当前点击的组
    self.addPhotosGroup = (TMSCreateTideGroup*)note.object;
    
    //判断当前组的照片个数是否已经是最大的照片个数
    if (self.addPhotosGroup.photos.count >= self.addPhotosGroup.maxNum) {
        
        [self.view showError:[NSString stringWithFormat:@"最多只能选择%zd",self.addPhotosGroup.maxNum]];
        
        return;
    }
    
    
    //跳转到相册选择界面
    TMSPhotoGroupViewController *groupvc =  [[TMSPhotoGroupViewController alloc] init];
    
    //最大可以选择的照片等于 当前组能添加的最大的照片数 - 当前组已经添加的照片
    self.mode.picSize = (self.addPhotosGroup.maxNum - self.addPhotosGroup.photos.count);
    
    NSLog(@"还可以选择==%zd",self.addPhotosGroup.maxNum - self.addPhotosGroup.photos.count);
    
    groupvc.mode = self.mode;
    
    TMSNavigationController *nav = [[TMSNavigationController alloc] initWithRootViewController:groupvc];
    [self presentViewController:nav animated:YES completion:nil];
    
}

/**
 *  点击了删除按钮
 *
 *  @param note <#note description#>
 */
-(void) deleteBtnClick:(NSNotification*)note
{
    if ([note.object isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *info = (NSDictionary*)note.object;
        
        if (info[@"group"]!=nil && info[@"item"]!=nil && info[@"indexpath"]!=nil) {
           
            //遍历当前的所有的组
            TMSCreateTideGroup *deleteGroup = info[@"group"];
            PhotoItem *item = info[@"item"];
            
            //遍历当前所有的组
            for (TMSCreateTideGroup *group in self.photos) {
                
                if (group == deleteGroup) {
                    
                    [group.photos removeObject:item];
                    
                    if (group.photos.count==0) {
                        
                        PhotoItem *item = [[PhotoItem alloc] init];
                        item.defaultPlaceholder = YES;
                        [group.photos addObject:item];
                        
                       //删除当前组的最后一个占位图片
                        [group.photos removeLastObject];
                      
                    }
                    
                    //遍历所有的照片控件 找到对应的照片控件 更新高度
                    [self changeContentViewLayoutWithGroup:group];
                    
                    return;
                }
                
            }
            
        }
    }
}

/**
 *  添加照片选择完成发出的通知
 *
 *  @param note <#note description#>
 */
- (void)photosDidFinish:(NSNotification*)note
{
    
    
    //获取用户选中的照片
    NSArray *selectedImages = (NSArray*)note.object;
    
    if (selectedImages.count<=0) {
        return;
    }
    
    // 去除重复的照片
    NSMutableArray *temp = [NSMutableArray array];

    for (PhotoItem *item1 in self.addPhotosGroup.photos) {
        
        for (PhotoItem *item2 in selectedImages) {
            
            if (item1.asset == item2.asset) {
                
                [temp addObject:item1];
            }
        }
    }
  
    
    /*
      img w  h
      scr w  h
     
     
     */
    
    NSLog(@"self.addPhotosGroup.photos====%@",self.addPhotosGroup.photos);

    //删除重复的照片
    [self.addPhotosGroup.photos removeObjectsInArray:temp];
    
    //给当前的组添加照片
    [self.addPhotosGroup.photos addObjectsFromArray:[selectedImages mutableCopy]];
    
    //遍历所有的照片控件 找到对应的照片控件 更新高度
    [self changeContentViewLayoutWithGroup:self.addPhotosGroup];
}

/**
 *  改变内容视图的布局
 *
 *  @param group <#group description#>
 */
- (void)changeContentViewLayoutWithGroup:(TMSCreateTideGroup*)group
{
    
//    NSInteger index = 0;
    
    for ( TMSCreateTideContentView *contentV in self.pictureViews) {
        
        if (contentV.group == group) {

#warning 错误信息提示 需要调试===========
//            //传递配置信息
//            group.photoConfigs = self.pictureModes[index];
            
            [contentV configGroup:group];
            
            contentV.sd_layout.heightIs([TMSCreateTideHelper getContentViewHeight:group.photos maxNum:group.photos.count==group.maxNum]) ;
            
            return;
        }
        
//        index++;
    }
}


/**
 *  预览图片发出的通知
 */
- (void)watchPhotos:(NSNotification*)note
{
    if ([note.object isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *info = (NSDictionary*)note.object;
        
        if (info[@"group"]!=nil && info[@"item"]!=nil && info[@"indexpath"]!=nil && info[@"view"]!=nil) {
            
            TMSCreateTideGroup *group = info[@"group"];
            NSIndexPath *indexpath = info[@"indexpath"];
    
            NSMutableArray *temp = [NSMutableArray array];
            
            for (int i = 0 ; i< group.photos.count ; i++) {
                    
                PhotoItem *photoitem = group.photos[i];
                
                PhotoBrowserItem *item = [[PhotoBrowserItem alloc] init];
                item.asset  = photoitem.asset;
                [temp addObject:item];
                    
            }

    
            PhotoBrowserController *photoBrowser =[[PhotoBrowserController alloc] init];
            photoBrowser.images = temp;
            photoBrowser.animating = NO;
            photoBrowser.currentIndex = indexpath.row;
            [self.navigationController pushViewController:photoBrowser animated:YES];

            
        }
    }
    
}


/**
 * 验证所有的文本框
 */
- (BOOL)checkAllTextResult
{
    if (self.resultDatas.count<=0) {
        return NO;
    }
    
    //处理标题
    if ([self.resultDatas[@"title"] isKindOfClass:[UITextField class]]) {
        
        UITextField *textfield = self.resultDatas[@"title"] ;
        
        if (textfield.text.length<=0) {
            
            [self.view showError:@"请输入潮报标题" position:CSToastPositionTop];
            
            [textfield becomeFirstResponder];
            
            return NO;
            
        }
        
    }

    
    //遍历内容数组
    if ([self.resultDatas[@"content"] isKindOfClass:[NSArray class]]) {
        
        //一组一组的处理 遍历验证
        for (NSDictionary *dict in self.resultDatas[@"content"]) {

                    //处理短文本
                    if ([dict[@"shortText"] isKindOfClass:[NSArray class]]) {
                        
                        for (UITextField *textfield in dict[@"shortText"]) {
                            
                            if (textfield.text.length<=0) {
                            
                                
                                if ([textfield.placeholder rangeOfString:@"时间"].length >0) {
                                    
                                    
                                    [self.view showError:@"请输入编辑内容" position:CSToastPositionTop];
                                    
                                    //直接让scrollview滚动到当前的textview
                                    [self.scrollView setContentOffset:CGPointMake(0, textfield.origin.y-10) animated:YES];

                                }else{
                                    
                                    [textfield becomeFirstResponder];
                                    
                                    [self.view showError:@"请输入编辑内容" position:CSToastPositionTop];

                                }

                                [textfield becomeFirstResponder];

                                
                                return NO;
                            }
                        }
                        
                    }
            
                //处理短文本========== end
            
                    //处理长文本
                    if ([dict[@"longText"] isKindOfClass:[NSArray class]]) {
                        
                        int index = 1;
                        for (TMSPlaceholderTextView *textview in dict[@"longText"]) {
                            
                            if (textview.text.length<=0) {
                                
                                [textview becomeFirstResponder];
                                
                                [self.view showError:@"请输入编辑内容" position:CSToastPositionTop];
                            
                                return NO;
                            }
                            
                            index++;
                        }
                        
                    }

                //处理长文本==========end
                
                
                
                //处理照片==========
                    if ([dict[@"picture"] isKindOfClass:[NSArray class]]) {
                        
                        //如果相册类目 就设置当前组为相册类目 最多选择81张
                        if (!self.mode.isPhotoCategory) {
       
                            for (TMSCreateTideContentView *contentV in dict[@"picture"]) {
                                
                                
                                if (contentV.group.photos.count<contentV.group.maxNum) {
                                    
                                    [self.view showError:@"请上传照片"];
                                    
                                    //直接让scrollview滚动到当前的相册位置
                                    [self.scrollView setContentOffset:CGPointMake(0, contentV.origin.y) animated:NO];
                                    
                                    return NO;
                                }
                            }
                            
                        }
                    
                        
                        
                    }
                //处理照片==========end

            //遍历key========== end

            
            }
        
        
        
    }
    

    //如果相册类目 就设置当前组为相册类目 最多选择81张
    if (self.mode.isPhotoCategory) {
    
        NSInteger photos = 0;
        //获取用户选择的所有的图片
        //1.获取每一个图片视图里面的图片
        for (TMSCreateTideContentView *contentV in self.pictureViews) {
            
            photos+= contentV.group.photos.count;
 
        }
        
        if (photos<self.picSize) {
            
            [self.view showError:[NSString stringWithFormat:@"请至少上传%zd张照片",self.picSize]];
            
            return NO;
            
        }
        
    }
    
    
    return YES;
}


/**
 *  处理结果集
 *
 *  @return q
 */
- (NSMutableDictionary*)disposeResult
{
    
    //保存json 结果字典
    NSMutableDictionary *datas = [NSMutableDictionary dictionary];
    
    //处理标题
    if ([self.resultDatas[@"title"] isKindOfClass:[UITextField class]]) {
        
        UITextField *textfield = self.resultDatas[@"title"] ;
        
        if (textfield.text) {
            datas[@"title"] = textfield.text;
        }
        
    }
    
    //音乐
    datas[@"music"] = self.resultDatas[@"music"];
    
    //短文本数组
    NSMutableArray *textArray = [NSMutableArray array];
    
    //照片数组
    NSMutableArray *pictureArray = [NSMutableArray array];
    
    //遍历内容数组
    if ([self.resultDatas[@"content"] isKindOfClass:[NSArray class]]) {
        
        
        for (NSDictionary *dict in self.resultDatas[@"content"]) {
            
            //处理短文本
            if ([dict[@"shortText"] isKindOfClass:[NSArray class]]) {
                
                for (UITextField *textfield in dict[@"shortText"]) {
                    
                    if (textfield.text) {
                        [textArray addObject:textfield.text];
                        
                    }
                }
                
            }
            
            //处理长文本
            if ([dict[@"longText"] isKindOfClass:[NSArray class]]) {
                
                for (UITextView *textview in dict[@"longText"]) {
                    
                    if (textview.text) {
                        
                        [textArray addObject:textview.text];
                        
                    }
                }
                
            }
        }
        
        datas[@"textArray"] = textArray;
        datas[@"picture"] = pictureArray;
        
        
    }
    
    return datas;
}

/**
 *  创建潮报按钮点击
 */
- (void)createTideBtnClick
{
    
    //验证所有的文本框
    if ([self checkAllTextResult] == NO) {
        return;
    }
    
    //显示加载动画
    [SYLoadingView showLoadingView:self.view.superview type:loadingViewCircle];
    
    
    //开启子线程处理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        
        //遍历结果集对象
        //保存json 结果字典
        NSMutableDictionary *datas = [self disposeResult];
        
        if (datas.count<=0) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [SYLoadingView dismiss];
                
                [self.view showError:@"生成潮报失败"];
                
            });
            
     
            
            return;
        }
        
        //获取用户选择的所有的图片
        //1.获取每一个图片视图里面的图片
        NSMutableArray *photoItems = [NSMutableArray array];
        for (TMSCreateTideContentView *contentV in self.pictureViews) {
            if (contentV.group.photos) {
                [photoItems addObjectsFromArray:[contentV.group.photos copy]];
            }
            
        }
        
        
        //如果有图片就上传图片
        if (photoItems.count) {
            
            //获取每一个图片控件下面的图片对象
            self.helper.mode = self.mode;
            self.helper.creatTideDatas = datas;
            [self.helper uploadPhotoItems:photoItems view:self.view];
            
        }else{ //没有图片就直接生成潮报
            
            [self createTideDidFinish:datas];
            
        }
        
        
        
    });


    
}


#pragma mark 生成潮报处理
- (void)createTideDidFinish:(NSMutableDictionary*)datas
{
    //1.生成h5
    NSDictionary *parames = @{@"userid":[TMSCommonInfo Openid],@"content":datas?datas:@"",@"templateId":self.mode.ID?self.mode.ID:@"",@"catalogName":self.mode.catalog?self.mode.catalog:@""};
    [[APIAgent sharedInstance] postToUrl:KRAPI_CreateH5 bodyParams:parames withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        
        if (![responseObject[@"rst"] isKindOfClass:[NSNull class]]) {
            
            if ([responseObject[@"rst"] isKindOfClass:[NSDictionary class]]) {
                
                
//                [self.resultDatas removeAllObjects];
//                [self.pictureViews removeAllObjects];
//                [self.pictureModes removeAllObjects];
//                [self.photos removeAllObjects];
                
                [self.view showSucess:@"生成潮报成功"];
                
                [SYLoadingView dismiss];
                
                TMSShareModel *mode = [TMSShareModel modalWithDict:responseObject[@"rst"]];
                
                //生成成功 直接跳转到预览界面
                TMSDetailViewController *detail = [[TMSDetailViewController alloc] init];
                detail.watchTemplate = NO;
                detail.url = mode.h5url;
                detail.shareMode = mode;
                detail.mode = self.mode;
                [self.navigationController pushViewController:detail animated:YES];
                
                
                
            }
            
        }else{
            
            [self.view showError:@"生成潮报出错 服务器出错"];
            [SYLoadingView dismiss];
            
        }
        
        
    } withFailure:^(NSString *error) {
        
        
        //如果超时提示
        if ([error rangeOfString:@"The request timed out"].length != NSNotFound) {
            [self.view showError:@"请求超时"];
            
        }
        
        [SYLoadingView dismiss];
        
        
    }];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mode.musicList.count?self.mode.musicList.count:0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TMSCreateTideMusicCell *cell = [TMSCreateTideMusicCell cellWithTableView:tableView];
    cell.music = self.mode.musicList[indexPath.row];
    cell.delegate = self;
    if (indexPath.row==0) {
        [cell selectedBtnClick];
    }
    return cell;
}


#pragma mark - TMSCreateTideMusicCellDelegate

/**
 *  选中了当前音乐
 *
 *  @param view  <#view description#>
 *  @param music <#music description#>
 */
- (void)createTideMusicView:(TMSCreateTideMusicCell *)view didClickedSelectedbtn:(TMSHomeMusic *)music
{
    self.resultDatas[@"music"] = music.url?music.url:@"";
    
    if ([self.lastSelMusicView.music.name isEqualToString:music.name]) {
        return;
    }
    
    self.lastSelMusicView.iconButton.selected = NO;
    
    self.lastSelMusicView = view;
        
}


/**
 *  点击了播放按钮
 *
 *  @param view  <#view description#>
 *  @param music <#music description#>
 */
- (void)createTideMusicView:(TMSCreateTideMusicCell *)view didClickedPlaybtn:(TMSHomeMusic *)music
{
    
    if (view.musicPlay==self.musicPlay) {
        
        self.musicPlay.selected = YES;
        
    }else{
        self.musicPlay.selected = NO;

    }
    
    self.musicPlay = view.musicPlay;
    
    [TMSMusicTool playerWithMusicUrl:music.url];


}

/**
 *  日期按钮的选择事件
 */
- (void)selDatePickerBtn:(TMSCreatTideDateButton*)btn
{
    [self.view endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        calendarPicker.frame = CGRectMake(0, 100, self.view.frame.size.width, CreateTideCanlenderHeight);
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year,NSString*hour,NSString* minute){
            btn.textField.placeholder = @"";
            
            //如果之前已经选择过日期 直接拼接
            if (btn.textField.text) {
                
                //如果之前已经选择过日期 直接拼接
                if ([btn.textField.text rangeOfString:@"-"].length>0) {
                    
                    
                    
                    //已经有时间了
                    if ([btn.textField.text rangeOfString:@":"].length>0) {
                        
                        if (![hour isEqualToString:@""] && ![minute isEqualToString:@""]) {
                            
                            NSArray *strs = [btn.textField.text componentsSeparatedByString:@" "];
                            
                            
                            NSString *years = [strs firstObject];
                            
                            if (year>0&&month>0&&day>0) {
                                
                                btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd %@:%@", year,month,day,hour,minute];
                                
                            }else{
                                
                                NSLog(@"years========%@",years);
                                
                                if (![hour isEqualToString:@""] && ![minute isEqualToString:@""]) {
                                    
                                    btn.textField.text = [NSString stringWithFormat:@"%@ %@:%@",years,hour,minute];
                                    
                                }else{
                                    
                                    btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd", year,month,day];
                                    
                                }
                                
                            }
                            
                            
                        }else{
                            
                            btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd", year,month,day];
                            
                        }
                        
                        
                        
                    }else{
                        
                        
                        
                        //如果没有选择日期 直接显示时间
                        if (day>0 && month>0 && year>0) {
                            
                            if (![hour isEqualToString:@""]) {
                                
                                btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd %@:%@", year,month,day,hour,minute];
                                
                            }else{
                                
                                btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd", year,month,day];
                                
                            }
                            
                            
                        }else{
                            
                            
                            btn.textField.text = [NSString stringWithFormat:@"%@ %@:%@", btn.textField.text,hour,minute];
                            
                            
                        }
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                }else{
                    
                    //如果都选择了 都显示
                    if (day>0 && month>0 && year>0) {
                        
                        if (![hour isEqualToString:@""]) {
                            btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd %@:%@", year,month,day,hour,minute];
                            
                        }else{
                            btn.textField.text = [NSString stringWithFormat:@"%zd-%zd-%zd", year,month,day];
                        }
                        return;
                        
                    }else{
                        
                        if (![hour isEqualToString:@""]) {
                            
                            btn.textField.text = [NSString stringWithFormat:@"%@:%@",hour,minute];
                            
                        }
                        
                    }
                    
                    
                    
                }
                
                
                
            }
            
            
        };

        
        
    });
    
}

#pragma mark UITextviewDelegate   用户按了return键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    
    return YES;
}

#pragma mark UITextFieldDelegate   开始编辑 记录 ---- 记录开始编辑的文本框


//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

/**
 *  textField 取消选中状态
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [TMSMusicTool stopMusic];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [TMSMusicTool rePlayeMusic];

}

#pragma mark
- (void)backItemClick
{
    [self.view endEditing:YES];
    
    //提示内容
    TMSLoginView *loginView = [TMSLoginView loginViewTitle:@"提示" message:@"您确定放弃本次编辑吗？" delegate:self cancelButtonTitle:@"放弃" otherButtonTitle:@"继续编辑" boldTag:1];
    
    [loginView show];
    
}
#pragma mark TMSLoginViewDelegate
- (void)loginView:(TMSLoginView *)view didClickedbuttonIndex:(NSInteger)index
{
    if (index==0) {
        [view hide];
        //销毁音乐
        [TMSMusicTool invaildeMusic];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (index==1){
        [view hide];
    }
}

- (void)dealloc
{
    [TMSMusicTool stopMusic];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[WHC_KeyboardManager share] removeMonitorViewController:self];
}



@end
