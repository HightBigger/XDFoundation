//
//  NSString+XDExtension.h
//  XDFoundation
//
//  Created by xiaoda on 2020/8/16.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XDExtension)

/**
 查找String,找不到返回-1

 @param findString 查询的string
 @param startPos 开始位置
 @return 查询结果的位置
 */
- (int)indexOf:(NSString*)findString startPos:(int)startPos;

/**
substring扩展

@param startPos 开始位置
@param endPos 结束位置
@return return value
*/
- (NSString*)subString:(int)startPos endPos:(int)endPos;

/**
 去除无用字符

 @return return value
 */
- (NSString*)trim;

/**
 字符串分割，返回结果去除空字符串或nil

 @param string 分割字符
 @return return value
 */
- (NSArray*)splitStr:(NSString*)string;

/**
 不区分大小写比较字符串

 @param text text
 @return return value
 */
- (BOOL)equalsIgnoreCase:(NSString*)text;
@end

NS_ASSUME_NONNULL_END
