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

#pragma mark - Create

+ (BOOL)createFileAtPath:(NSString *)path Content:(NSData * _Nullable)content Attributes:(NSDictionary<NSFileAttributeKey, id> * _Nullable )attributes{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    NSError *dirError;
    NSString *dirPath = [path stringByDeletingLastPathComponent];
    
    if (![fileManager fileExistsAtPath:dirPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&dirError];
    }
    
    if (dirError) {
        Log(@"创建文件夹时出错, %@", dirError.localizedDescription);
        return NO;
    }
    
    if ([NSString isEmptyString:path]) {
        Log(@"需要创建的文件地址为空");
        return NO;
    }
    
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
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:fromPath]) {
        Log(@"需要移动的文件不存在");
        return NO;
    }
    
    BOOL isDir;
    NSError *dirError;
    NSString *toDirPath = [toPath stringByDeletingLastPathComponent];
    if (![fileManager fileExistsAtPath:toDirPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:toDirPath withIntermediateDirectories:YES attributes:nil error: &dirError];
    }
    
    if (dirError) {
        Log(@"创建文件夹时出错");
        return NO;
    }
    
    NSError *error;
    BOOL result = [fileManager moveItemAtPath:fromPath toPath:toPath error:&error];
    if (error) {
        Log(@"移动文件时出错, %@", error.localizedDescription);
        return NO;
    }
    
    return result;
}

#pragma mark - Read

+ (NSData * _Nullable)readFileWithDataFromPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return nil;
    }
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (NSString * _Nullable)readFileWithStringFromPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
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
        }else if ([content isKindOfClass:[NSArray class]]) {
            [(NSArray *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableData class]]) {
            [(NSMutableData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSData class]]) {
            [(NSData *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableDictionary class]]) {
            [(NSMutableDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSDictionary class]]) {
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSJSONSerialization class]]) {
            [(NSDictionary *)content writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSMutableString class]]) {
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[NSString class]]) {
            [[((NSString *)content) dataUsingEncoding:NSUTF8StringEncoding] writeToFile:path atomically:YES];
        }else if ([content isKindOfClass:[UIImage class]]) {
            [UIImagePNGRepresentation((UIImage *)content) writeToFile:path atomically:YES];
        }else if ([content conformsToProtocol:@protocol(NSCoding)]) {
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

@end
