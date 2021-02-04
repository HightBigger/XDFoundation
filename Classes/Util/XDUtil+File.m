//
//  XDUtil+File.m
//  XDFoundation
//
//  Created by xiaoda on 2020/8/17.
//  Copyright © 2020 XDFoundation. All rights reserved.
//

#import "XDUtil+File.h"
#import <sys/stat.h>

@implementation XDUtil (File)

// Documents目录下文件路径
+ (NSString *)getDocumentsFilePath:(NSString *)relativePath
{
    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    return [documents stringByAppendingPathComponent:relativePath];
}

// Caches目录下文件路径
+ (NSString *)getCachesFilePath:(NSString *)relativePath
{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    return [caches stringByAppendingPathComponent:relativePath];
}

// 文件是否存在
+ (BOOL)fileExistsAtPath:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL isExisted = [[NSFileManager defaultManager]fileExistsAtPath:path isDirectory:&isDirectory];
    if (isExisted && !isDirectory)
    {
        return YES;
    }
    
    return NO;
}

// 获取文件所在目录
+ (NSString *)getCurrentDirectory:(NSString *)path
{
    return [path stringByDeletingLastPathComponent];
}

// 目录是否存在
+ (BOOL)directoryExistsAtPath:(NSString *)path
{
    BOOL isDirectory = NO;
    BOOL isExisted = [[NSFileManager defaultManager]fileExistsAtPath:path isDirectory:&isDirectory];
    if (isExisted && isDirectory)
    {
        return YES;
    }
    
    return NO;
}

// 获取文件大小
+ (int64_t)getFileSize:(NSString *)filePath
{
    struct stat fileStat;
    int64_t fileSize = 0;
    if(lstat(filePath.UTF8String, &fileStat) == 0)
    {
        fileSize = fileStat.st_size;
    }
    
    return fileSize;
}

// 获取文件块数
+ (int)getFileBlocksWithSize:(int64_t)fileSize
{
    int size = 1024 * 1024;
    int blocks = (int)(fileSize / size);
    int remainder = fileSize % size;
    
    return remainder == 0 ? blocks : blocks + 1;
}

// 获取文件块数
+ (NSArray<NSValue *> *)getFileBlockInfosWithPath:(NSString *)filePath;
{
    if ([self fileExistsAtPath:filePath])
    {
        int64_t fileSize = [self getFileSize:filePath];
        
        return [self getFileBlockInfosWithSize:fileSize];
    }
    
    return nil;
}

+ (NSArray<NSValue *> *)getFileBlockInfosWithSize:(int64_t)fileSize
{
    return [self getSectionInfos:1024 * 1024 number:fileSize];
}

// 将一个数按每行colomn个进行分区
+ (NSArray<NSValue *> *)getSectionInfos:(NSUInteger)colomn number:(int64_t)number
{
    if (number > 0)
    {
        int rows = (int)(number / colomn);
        int remainder = (int)(number % colomn);
        if (remainder != 0)
        {
            rows++;
        }
        NSMutableArray<NSValue *> *blocks = [NSMutableArray array];
        for (int i = 0; i < rows; i++)
        {
            NSValue *range = nil;
            if (i < rows - 1)
            {
                range = [NSValue valueWithRange:NSMakeRange(i * colomn, colomn)];
            }
            else
            {
                range = [NSValue valueWithRange:NSMakeRange(i * colomn, remainder == 0 ? colomn : remainder)];
            }
            [blocks addObject:range];
        }
        
        return blocks;
    }
    
    return nil;
}

// 生成指定目录下指定文件名文件路径
+ (NSString *)generateFilePath:(NSString *)directory filename:(NSString *)filename
{
    // 获取文件扩展名
    NSString *extension = filename.pathExtension;
    // 文件名(除去扩展名)
    NSString *name = filename.stringByDeletingPathExtension;
    // 文件全名
    NSString *fullName = filename;
    NSString *filePath = [directory stringByAppendingPathComponent:fullName];
    int index = 0;
    while ([self fileExistsAtPath:filePath])
    {
        index++;
        if (extension.length > 0)
        {
            fullName = [NSString stringWithFormat:@"%@(%d).%@", name, index, extension];
        }
        else
        {
            fullName = [NSString stringWithFormat:@"%@(%d)", name, index];
        }
        filePath = [directory stringByAppendingPathComponent:fullName];
    }
    
    return filePath;
}

// 读文件
+ (NSData *)readFileFromPath:(NSString *)path range:(NSRange)range
{
    NSData *data = nil;
    if ([self fileExistsAtPath:path])
    {
        // 打开文件
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
        if (fileHandle)
        {
            [fileHandle seekToFileOffset:range.location];
            data = [fileHandle readDataOfLength:range.length];
            [fileHandle closeFile];
        }
    }
    
    return data;
}

// 写文件
+ (BOOL)writeFileToPath:(NSString *)path data:(NSData *)data
{
    BOOL result = NO;
    // 文件不存在，直接写入文件
    if (![self fileExistsAtPath:path])
    {
        NSString *parentDir = [path stringByDeletingLastPathComponent];
        // 上层目录不存在创建目录
        if (![self directoryExistsAtPath:parentDir])
        {
            [self createDirectoryAtPath:parentDir];
        }
        result = [data writeToFile:path atomically:YES];
    } // 文件存在，定位到文件末端，追加数据
    else
    {
        // 打开文件
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        if (fileHandle)
        {
            // 定位到文件末端
            [fileHandle seekToEndOfFile];
            // 追加数据
            [fileHandle writeData:data];
            // 关闭文件
            [fileHandle closeFile];
            
            result = YES;
        }
    }
    
    return result;
}

// 创建目录
+ (BOOL)createDirectoryAtPath:(NSString *)path
{
    NSString *dirPath = [self directoryExistsAtPath:path] ? path : [self getCurrentDirectory:path];
    if ([self directoryExistsAtPath:dirPath])
    {
        return YES;
    }
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager]createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!result && error)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return result;
}

// 移动文件
+ (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath
{
    if ([self fileExistsAtPath:srcPath])
    {
        NSString *parentDir = [self getCurrentDirectory:dstPath];
        // 上层目录不存在创建目录
        if (![self directoryExistsAtPath:parentDir])
        {
            [self createDirectoryAtPath:parentDir];
        }
        NSError *error = nil;
        BOOL result = [[NSFileManager defaultManager]moveItemAtURL:[NSURL fileURLWithPath:srcPath] toURL:[NSURL fileURLWithPath:dstPath] error:&error];
        if (result)
        {
            return YES;
        }
        else if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }
    
    return NO;
}

+ (BOOL)moveFileAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL
{
    NSString *parentDir = [self getCurrentDirectory:dstURL.path];
    // 上层目录不存在创建目录
    if (![self directoryExistsAtPath:parentDir])
    {
        [self createDirectoryAtPath:parentDir];
    }
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager]moveItemAtURL:srcURL toURL:dstURL error:&error];
    if (error)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return result;
}

// 拷贝文件
+ (BOOL)copyFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath;
{
    if ([self fileExistsAtPath:srcPath])
    {
        NSString *parentDir = [self getCurrentDirectory:dstPath];
        // 上层目录不存在创建目录
        if (![self directoryExistsAtPath:parentDir])
        {
            [self createDirectoryAtPath:parentDir];
        }
        NSError *error = nil;
        BOOL result = [[NSFileManager defaultManager]copyItemAtURL:[NSURL fileURLWithPath:srcPath] toURL:[NSURL fileURLWithPath:dstPath] error:&error];
        if (result)
        {
            return YES;
        }
        else if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }
    
    return NO;
}

+ (BOOL)copyFileAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL
{
    NSString *parentDir = [self getCurrentDirectory:dstURL.path];
    // 上层目录不存在创建目录
    if (![self directoryExistsAtPath:parentDir])
    {
        [self createDirectoryAtPath:parentDir];
    }
    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager]copyItemAtURL:srcURL toURL:dstURL error:&error];
    if (error)
    {
        NSLog(@"%@", error.localizedDescription);
    }
    
    return result;
}

// 删除文件
+ (BOOL)removeFileAtPath:(NSString *)path
{
    if ([self fileExistsAtPath:path])
    {
        NSError *error = nil;
        BOOL result = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
        if (result)
        {
            return YES;
        }
        else if (error)
        {
            NSLog(@"%@", error.localizedDescription);
        }
    }
    
    return NO;
}

@end
