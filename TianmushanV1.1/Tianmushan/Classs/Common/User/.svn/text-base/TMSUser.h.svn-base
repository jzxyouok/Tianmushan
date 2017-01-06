//
//  TMSUser.h
//  Tianmushan
//
//  Created by shushaoyong on 2016/11/7.
//  Copyright © 2016年 踏潮. All rights reserved.
/**
 city = Ankang;
 country = CN;
 headimgurl = "http://wx.qlogo.cn/mmopen/sRia3Hib35CaztcaxQAEKo2CiarhibcchmjsVWSHA879ticen4DQp3ly6fXvequibaZEjQcWeQGsC8DoQ8swRsLC3ncaHpPTo4rbVy/0";
 language = "zh_CN";
 nickname = "\U6bcf\U5929\U8fdb\U6b65\U4e00\U70b9\U70b9";
 openid = "o7lGiwZhSO9BQFjHk-Lgk90XWxo0";
 privilege =     (
 );
 province = Shaanxi;
 sex = 1;
 unionid = "ot8G1uOp50Vuoa-H8A1pWfTge7K8";
 
 */

#import <Foundation/Foundation.h>

@interface TMSUser : NSObject<NSCoding>

/**普通用户的标识，对当前开发者帐号唯一*/
@property(nonatomic,copy)NSString *openid;

/**普通用户昵称*/
@property(nonatomic,copy)NSString *nickname;

/**普通用户性别，1为男性，2为女性*/
@property(nonatomic,assign)NSInteger sex;

/**普通用户个人资料填写的省份*/
@property(nonatomic,copy)NSString *province;

/**普通用户个人资料填写的城市*/
@property(nonatomic,copy)NSString *city;

/**国家，如中国为CN*/
@property(nonatomic,copy)NSString *country;

/**用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空*/
@property(nonatomic,copy)NSString *headimgurl;

/**用户特权信息，json数组，如微信沃卡用户为（chinaunicom）*/
@property(nonatomic,strong)NSArray *privilege;

/**用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。*/
@property(nonatomic,strong)NSString *unionid;

/**获取用户信息保存的路径*/
+ (NSString*)getSaveInfoPath;

@end
