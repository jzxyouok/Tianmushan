//
//  TMSLoginWXModel.h
//  Tianmushan
//
//  Created by shushaoyong on 2016/11/7.
//  Copyright © 2016年 踏潮. All rights reserved.
/**
 
 {
 "access_token" = "UuBhL2d0VzdLSGvWW8jK-kQHgTOVHvPYMFYG04G1wBpLGnZI7-Djfvq3TlcynfbqISWoCwxyisRVDESc-rb_p2MR5EfdWI5C6QDyFaKblY0";
 "expires_in" = 7200;
 openid = "o7lGiwZhSO9BQFjHk-Lgk90XWxo0";
 "refresh_token" = "NcVWpQpE748ihZY_gK8AevnRhm0e_z_bKEcp70KqWRuz0TJ7gQkOM_wpThQurRvaLUrtB9QMteagCCwxD4bgoqkFF9_3kfEQXwupjf-K-Ns";
 scope = "snsapi_userinfo";
 unionid = "ot8G1uOp50Vuoa-H8A1pWfTge7K8";
 }
 
 
 **/

#import <Foundation/Foundation.h>

@interface TMSLoginWXModel : NSObject

/**access_token*/
@property(nonatomic,copy)NSString *access_token;

/**超时时间*/
@property(nonatomic,assign)NSInteger expires_in;

/**授权用户唯一标识*/
@property(nonatomic,copy)NSString *openid;

/**用户刷新access_token*/
@property(nonatomic,copy)NSString *refresh_token;

/**用户授权的作用域，使用逗号（,）分隔*/
@property(nonatomic,copy)NSString *scope;

/**当且仅当该移动应用已获得该用户的userinfo授权时，才会出现该字段*/
@property(nonatomic,copy)NSString *unionid;

@end
