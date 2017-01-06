//
//  NSObject+TMSModel.m
//  Tianmushan
//
//  Created by shushaoyong on 2016/11/1.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import "NSObject+TMSModel.h"

@implementation NSObject (TMSModel)

+ (instancetype)modalWithDict:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    id model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    //模板id
    if ([key isEqualToString:@"id"]) {
        
        [self setValue:value forKey:@"ID"];
        
    }

}

@end
