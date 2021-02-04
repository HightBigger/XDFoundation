//
//  XDUtil+Device.h
//  XDFoundation
//
//  Created by xiaoda on 2020/8/18.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDUtil (Device)

/// 底部安全高度
+ (CGFloat)safeAreaHeight;

/// 获取系统版本
+ (NSString*)getOsVersion;

/// 获取客户端版本号
+ (NSString*)getClientVersion;

/// 获取应用build号
+ (NSString*)getBuildVersion;

/// 是否是IPhoneX
+ (BOOL)isIPhoneX;

/// 获取客户端bundleid
+ (NSString*)getClientID;

/// 获取系统版本号
+ (NSString*)getSystemVersion;

@end

NS_ASSUME_NONNULL_END
