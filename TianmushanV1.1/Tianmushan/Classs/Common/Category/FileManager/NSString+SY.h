//
//  NSString+SY.h
//  photo
//
//  Created by shushaoyong on 2016/10/24.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (SY)


/**
 *  将阿拉伯数字转换为汉字
 *
 *  @return <#return value description#>
 */
+ (NSString *)numberToChineseCharacter:(NSInteger)num;


/**
 *  获取一个文件的md5
 *
 *  @param path <#path description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *) stringWithMD5OfFile: (NSString *) path;


/**
 *  获取一个文件的sha1值
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)sha1HashOfFileAtPath:(NSString *)filePath;

/**
 *  获取一个文件的sha512值
 *
 *  @param filePath <#filePath description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)sha512HashOfFileAtPath:(NSString *)filePath;



/**
 *  获取一个字符串的md5值
 *
 *  @return <#return value description#>
 */
- (NSString *) MD5Hash;

/**
 *  获取文件的大小
 *
 *  @return 返回文件的大小
 */
- (unsigned long long)getFileSize;

/**
 *  获取缓存根目录
 *
 *  @return <#return value description#>
 */
+ (NSString*)cacheDirectory;

/**
 *  获取一个文件在沙盒中的caches路径
 *
 *  @return <#return value description#>
 */
- (NSString*)cachePath;



/**
 *
 *将数组转换为json字符串
 */
+ (NSString*)jsonWithArray:(NSArray*)array;

/**
 *
 *将json字符串转换为数组
 */
+ (NSArray*)arrayWithJson:(NSString*)json;

/**
 *
 * 通过转好的json格式的data获取数组
 */
+ (NSArray*)arrayWithData:(NSData*)data;


/**
 *
 *将字典转换为json字符串
 */
+ (NSString*)jsonWithDictionary:(NSDictionary*)dict;

/**
 *
 *将json字符串转换为字典
 */
+ (NSDictionary*)dictionaryWithJson:(NSString*)json;


/**
 *
 * 通过转好的json格式的data获取字典
 */
+ (NSDictionary*)dictionaryWithData:(NSData*)data;

/**
 *  计算文字的宽度
 *
 *  @param height 最大的高度
 *  @param size   字体大小
 *
 *  @return 文字的宽度
 */
- (CGFloat)getTextWidthWithMaxHeight:(CGFloat)height fontSize:(CGFloat)size;

/**
 *  计算文字的高度
 *
 *  @param width 最大的宽度
 *  @param size   字体大小
 *
 *  @return 文字的高度
 */
- (CGFloat)getTextWidthWithMaxWidth:(CGFloat)width fontSize:(CGFloat)size;


@end
