//
//  XDUtil+File.h
//  XDFoundation
//
//  Created by xiaoda on 2020/8/17.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface XDUtil (File)

/// Documents目录下文件路径
+ (NSString *)getDocumentsFilePath:(NSString *)relativePath;

/// Caches目录下文件路径
+ (NSString *)getCachesFilePath:(NSString *)relativePath;

/// 文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path;

/// 获取文件所在目录
+ (NSString *)getCurrentDirectory:(NSString *)path;

/// 目录是否存在
+ (BOOL)directoryExistsAtPath:(NSString *)path;

/// 获取文件大小
+ (int64_t)getFileSize:(NSString *)filePath;

/// 获取文件块数
+ (int)getFileBlocksWithSize:(int64_t)fileSize;

/// 获取文件块数 NSRange
+ (NSArray<NSValue *> *)getFileBlockInfosWithPath:(NSString *)filePath;
+ (NSArray<NSValue *> *)getFileBlockInfosWithSize:(int64_t)fileSize;

/// 生成指定目录下指定文件名文件路径
+ (NSString *)generateFilePath:(NSString *)directory filename:(NSString *)filename;

/// 读文件
+ (NSData *)readFileFromPath:(NSString *)path range:(NSRange)range;

/// 写文件
+ (BOOL)writeFileToPath:(NSString *)path data:(NSData *)data;

/// 创建目录
+ (BOOL)createDirectoryAtPath:(NSString *)path;

/// 移动文件
+ (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
+ (BOOL)moveFileAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL;

/// 拷贝文件
+ (BOOL)copyFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
+ (BOOL)copyFileAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL;

/// 删除文件
+ (BOOL)removeFileAtPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
