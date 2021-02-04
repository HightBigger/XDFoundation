//
//  XDUtil+Css.h
//  XDFoundation
//
//  Created by xiaoda on 2020/8/16.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDUtil (Css)

/// 字符串转颜色支持 #FFFFFF,#AAFFFFFF RGBA(255,255,255,255) RGB(255,255,255)格式
/// @param cssValue 解析的字符串
+ (UIColor *)parseColor:(NSString*)cssValue;

/// 黑暗模式支持
/// @param color 普通模式颜色
/// @param darkColor 黑暗模式颜色
+ (UIColor*)parseColor:(NSString*)color darkMode:(NSString*)darkColor;

/// 黑暗模式支持
/// @param color 普通模式颜色
/// @param darkColor 黑暗模式颜色
+ (UIColor*)setDynamicColor:(UIColor*)color darkMode:(UIColor*)darkColor;

/// 根据颜色创建图片
/// @param color 颜色值
/// @param size 图片大小
+ (UIImage *)createImageWithColor:(UIColor*)color size:(CGSize)size;

/// 根据size获取等比例的高度
/// @param srcSize 原始大小
/// @param width 宽度
+ (float)getProportionHeight:(CGSize)srcSize width:(float)width;

/// 根据size获取等比例的宽度
/// @param srcSize 原始大小
/// @param height 高度
+ (float)getProportionWidth:(CGSize)srcSize height:(float)height;


@end

NS_ASSUME_NONNULL_END
