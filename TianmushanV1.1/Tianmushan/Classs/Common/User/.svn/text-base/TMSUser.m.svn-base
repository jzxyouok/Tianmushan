//
//  TMSUser.m
//  Tianmushan
//
//  Created by shushaoyong on 2016/11/7.
//  Copyright © 2016年 踏潮. All rights reserved.


#import "TMSUser.h"

@implementation TMSUser

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
     
       _openid = [aDecoder decodeObjectForKey:@"openid"];
       _nickname =   [aDecoder decodeObjectForKey:@"nickname"];
       _sex = [aDecoder decodeIntegerForKey:@"sex"];
       _province =  [aDecoder decodeObjectForKey:@"province"];
       _city =  [aDecoder decodeObjectForKey:@"city"];
       _country =  [aDecoder decodeObjectForKey:@"country"];
       _headimgurl =  [aDecoder decodeObjectForKey:@"headimgurl"];
       _privilege =  [aDecoder decodeObjectForKey:@"privilege"];
       _unionid =  [aDecoder decodeObjectForKey:@"unionid"];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_openid forKey:@"openid"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeInteger:_sex forKey:@"sex"];
    [aCoder encodeObject:_province forKey:@"province"];
    [aCoder encodeObject:_city forKey:@"city"];
    [aCoder encodeObject:_country forKey:@"country"];
    [aCoder encodeObject:_headimgurl forKey:@"headimgurl"];
    [aCoder encodeObject:_privilege forKey:@"privilege"];
    [aCoder encodeObject:_unionid forKey:@"unionid"];
}


+ (NSString *)getSaveInfoPath
{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"TMSUser.data"];
}


@end
