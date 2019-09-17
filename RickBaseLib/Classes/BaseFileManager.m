//
//  BaseFileManager.m
//  StringDemo
//
//  Created by Rick on 2019/9/16.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "BaseFileManager.h"
#import "NSString+Tool.h"
#import "LibDebug.h"

@implementation BaseFileManager

#pragma mark - Directory

+ (NSString * _Nonnull)homeDirectory{
    return NSHomeDirectory();
}

+ (NSString * _Nonnull)documentDirectory{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString * _Nonnull)libraryDirectory{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString * _Nonnull)cachesDirectory{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [pathArray objectAtIndex:0];
}

+ (NSString * _Nonnull)tmpDirectory{
    return NSTemporaryDirectory();
}

#pragma mark - Common

+ (BOOL)isExistsAtPath:(NSString *)path{
    return [NSFileManager.defaultManager fileExistsAtPath:path];
}

+ (BOOL)isExistDirectoryAtPath:(NSString *)path{
    BOOL isDir;
    return [NSFileManager.defaultManager fileExistsAtPath:path isDirectory:&isDir] && isDir;
}

#pragma mark - Create

+ (BOOL)createFileAtPath:(NSString *)path Content:(NSData * _Nullable)content Attributes:(NSDictionary<NSFileAttributeKey, id> * _Nullable )attributes{
    
    if ([NSString isEmptyString:path]) {
        Log(@"需要创建的文件地址为空");
        return NO;
    }
    
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    if (![self isExistsAtPath:dirPath]) {
        BOOL createResult = [self createDirectoryAtPath:dirPath];
        if (!createResult) {
            Log(@"创建文件夹时出错");
            return NO;
        }
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager createFileAtPath:path contents:content attributes:attributes];
    return result;
}

+ (BOOL)createDirectoryAtPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    NSError *dirError;
    BOOL result = NO;
    
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        result = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&dirError];
    }
    
    if (dirError) {
        Log(@"创建文件夹时出错, %@", dirError.localizedDescription);
        return NO;
    }
    
    return result;
}

#pragma mark - Move

+ (BOOL)moveItemFromPath:(NSString *)fromPath ToPath:(NSString *)toPath{
    
    if (![self isExistsAtPath:fromPath]) {
        Log(@"需要移动的文件不存在");
        return NO;
    }
    
    NSError *dirError;
    NSString *toDirPath = [toPath stringByDeletingLastPathComponent];
    if ([self isExistsAtPath:toDirPath]) {
        BOOL createResult = [self createDirectoryAtPath:toDirPath];
        if (!createResult) {
            Log(@"创建文件夹时出错");
            return NO;
        }
    }
    
    if (dirError) {
        Log(@"创建文件夹时出错");
        return NO;
    }
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager moveItemAtPath:fromPath toPath:toPath error:&error];
    if (error) {
        Log(@"移动文件时出错, %@", error.localizedDescription);
        return NO;
    }
    
    return result;
}

#pragma mark - Copy

+ (BOOL)copyItemFromPath:(NSString *)fromPath ToPath:(NSString *)toPath{
    
    if (![self isExistsAtPath:fromPath]) {
        Log(@"需要复制的路径不存在");
        return NO;
    }
    
    NSString *toDirPath = [toPath stringByDeletingLastPathComponent];
    if (![self isExistsAtPath:toDirPath]) {
        BOOL createResult = [self createDirectoryAtPath:toDirPath];
        if (!createResult) {
            Log(@"创建文件夹时出错");
            return NO;
        }
    }
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager copyItemAtPath:fromPath toPath:toPath error:&error];
    
    if (error) {
        Log(@"复制文件时出错");
        return NO;
    }
    
    return result;
}

#pragma mark - Read

+ (NSData * _Nullable)readFileWithDataFromPath:(NSString *)path{
    if (![self isExistsAtPath:path]) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSString * _Nullable)readFileWithStringFromPath:(NSString *)path{
    if (![self isExistsAtPath:path]) {
        return nil;
    }
    
    NSError *error;
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        Log(@"读取文件时出错");
        return nil;
    }
    
    return string;
}

#pragma mark - Write

+ (BOOL)writeFileToPath:(NSString *)path Content:(id)content{
    if (!content) {
        Log(@"没有需要写入的内容");
        return NO;
    }
    if ([self isExistsAtPath:path]) {
        if ([content isKindOfClass:[NSMutableArray class]]) {
            [(NSMutableArray *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSArray class]]) {
            [(NSArray *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSMutableData class]]) {
            [(NSMutableData *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSData class]]) {
            [(NSData *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSMutableDictionary class]]) {
            [(NSMutableDictionary *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSDictionary class]]) {
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSJSONSerialization class]]) {
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSMutableString class]]) {
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[NSString class]]) {
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }
        else if ([content isKindOfClass:[UIImage class]]) {
            [UIImagePNGRepresentation((UIImage *)content) writeToFile:path atomically:YES];
        }
        else if ([content conformsToProtocol:@protocol(NSCoding)]) {
            [NSKeyedArchiver archiveRootObject:content toFile:path];
        }else {
            Log(@"不支持的文件类型");
            return NO;
        }
    }else {
        return NO;
    }
    
    return YES;
}

#pragma mark - Delete

+ (BOOL)deleteItemAtPath:(NSString *)path{
    if (![self isExistsAtPath:path]) {
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL result = [fileManager removeItemAtPath:path error:&error];
    
    if (error) {
        Log(@"删除文件时出错");
        return NO;
    }
    
    return result;
}

#pragma mark - Foreach

+ (NSArray * _Nullable)foreachItemInPath:(NSString *)path DeepSearch:(BOOL)deepSearch{
    if (![self isExistsAtPath:path]) {
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (deepSearch) {
        NSError *error;
        NSArray *subPathArray = [fileManager subpathsOfDirectoryAtPath:path error:&error];
        
        if (error) {
            Log(@"遍历子路径时出错");
            return nil;
        }
        
        return subPathArray;
    }
    else {
        NSError *error;
        NSArray *subPathArray = [fileManager contentsOfDirectoryAtPath:path error:&error];
        
        if (error) {
            Log(@"遍历子路径时出错");
            return nil;
        }
        
        return subPathArray;
    }
}

@end
