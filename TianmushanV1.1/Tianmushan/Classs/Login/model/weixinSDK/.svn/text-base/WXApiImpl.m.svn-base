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


#import "WXApiImpl.h"
#import "WXApiObject.h"
#import "APIAgent.h"
#import "TianmushanAPI.h"
#import "TMSLoginWXModel.h"
#import "TMSUser.h"
#import "SYLoadingView.h"

NSString* const WX_APP_ID = @"wxa54dd0b8694767dc";
NSString* const WX_APP_SECRET = @"937053cbc27856ead7b1a3ee82a08278";

@interface WXApiImpl()

/**登录模型*/
@property(nonatomic,strong)TMSLoginWXModel *loginModel;

@end

@implementation WXApiImpl

+ (WXApiImpl *) sharedInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [WXApi registerApp:WX_APP_ID withDescription:@"xx"];
    }
    return self;
}

- (void)registerAppid
{
    [WXApi registerApp:WX_APP_ID withDescription:@"xx"];
}

-(void) requestOAuth {
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"0744" ;
    [WXApi sendReq:req];
}

-(void) requestOAuth:(NSString *)wallet {
    _walletString = wallet;
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"0744" ;
    [WXApi sendReq:req];
}

- (BOOL) handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:self];
}

-(void) onResp:(BaseResp*)resp{
    
    
    //分享
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
             
        if (resp.errCode == 0) {
            
            //分享成功
            [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_WEIXINSHARESUCCESSNOTIFICATION object:nil];
            
        }else{
            
            //分享失败
            [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_WEIXINSHAREERRORNOTIFICATION object:nil];

            
        }
        
    
    //授权
    } else if ([resp isKindOfClass:[SendAuthResp class]]) {
      
        SendAuthResp *aresp = (SendAuthResp *)resp;
        
        [SYLoadingView showLoadingView:[UIApplication sharedApplication].keyWindow.rootViewController.view type:loadingViewCircle];
        
        //用户点击了登录
        if (aresp.errCode== 0) {
            
            
            //通过code获取access_token
            NSString *code = aresp.code;
            if (code) {
                
                NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WX_APP_ID,WX_APP_SECRET,code];
                [[APIAgent sharedInstance] getFromfullUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
                    
                    if (![responseObject objectForKey:@"errcode"]) {
                        
                        //刷新accesstoken
                        [self refreshAccessToken:[TMSLoginWXModel modalWithDict:responseObject]];
                        
                        
                    }
                    
                } withFailure:^(NSString *error) {
                    
                    NSLog(@"%@",error);
                    
                }];
                
            }
        
        //用户点击了取消
        }else if (aresp.errCode ==  WXErrCodeUserCancel)
        {
            [SYLoadingView dismiss];
        }
        
        
    } else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
       
    } else if ([resp isKindOfClass:[WXChooseCardResp class]]) {
        
    }

    
    
    
 
}

#pragma mark 刷新用户的accesstoken
- (void)refreshAccessToken:(TMSLoginWXModel*)model
{
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@",WX_APP_ID,model.refresh_token];
    [[APIAgent sharedInstance] getFromfullUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
       
        if (![responseObject objectForKey:@"errcode"]) {
            
            //获取用户个人信息
            [self getWXUserInfo:[TMSLoginWXModel modalWithDict:responseObject]];
        }
       
        
    } withFailure:^(NSString *error) {
        
    }];
    
    
}


#pragma mark 获取用户个人信息
- (void)getWXUserInfo:(TMSLoginWXModel*)model
{
  
    self.loginModel = model;
    
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",model.access_token,model.openid];
    [[APIAgent sharedInstance] getFromfullUrl:url params:nil withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
       
        NSLog(@"%@",responseObject);
        
        //获取成功保存用户信息
        if (!responseObject[@"errcode"]) {
            
            
            TMSUser *user = [TMSUser modalWithDict:responseObject];
            
            //保存用户信息
            [NSKeyedArchiver archiveRootObject:user toFile:[TMSUser getSaveInfoPath]];
            
            //将当前信息发送给服务器
            [self saveWeixinInfo:user];
            
            
        }else{
            
            //登录失败的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINERRORNOTIFICATION object:nil];
            
        }
        
    } withFailure:^(NSString *error) {
        
        //登录失败的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINERRORNOTIFICATION object:nil];
        [SYLoadingView dismiss];

    }];
}


#pragma mark 保存用户登录信息
- (void)saveWeixinInfo:(TMSUser*)user
{
    
    NSString *str = [user.nickname lowercaseString];
    NSDictionary *parapmes=@{@"openid": user.openid,@"nickname":[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],@"headimgurl":user.headimgurl,@"sex":@(user.sex),@"province":user.province,@"city":user.city,@"country":user.country,@"privilege":user.privilege,@"unionid":user.unionid};

    [[APIAgent sharedInstance] postToUrl:KRAPI_WXlogin bodyParams:parapmes withCompletionBlockWithSuccess:^(NSDictionary *responseObject) {
        
        //保存用户信息成功
        if ([responseObject[@"code"] longLongValue] ==0) {
            
            [SYLoadingView dismiss];
            
            //保存用户信息
            [TMSCommonInfo setAccessToken:self.loginModel.access_token];
            [TMSCommonInfo setExpiration:self.loginModel.expires_in];
            [TMSCommonInfo setOpenid:self.loginModel.openid];
            
            //登录成功的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];

        }else{
            
            //登录失败的通知
            [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];
            

        }
        
    } withFailure:^(NSString *error) {
        
        //登录失败的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KRAPI_MEMBER_LOGINNOTIFICATION object:nil];
        
        [SYLoadingView dismiss];
        
    }];

}



-(void) onReq:(BaseReq*)req{
    if([req isKindOfClass:[GetMessageFromWXReq class]]){
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }else if([req isKindOfClass:[ShowMessageFromWXReq class]]){
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%ld bytes\n\n", msg.title, msg.description, obj.extInfo, (long)msg.thumbData.length];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else if([req isKindOfClass:[LaunchFromWXReq class]]){
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
