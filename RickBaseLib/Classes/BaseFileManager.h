//
//  BaseFileManager.h
//  StringDemo
//
//  Created by Rick on 2019/9/16.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseFileManager : NSObject

/// App根目录
@property (nonatomic, copy, readonly) NSString *homeDirectory;

/// Document目录
@property (nonatomic, copy, readonly) NSString *documentDirectory;

/// Library目录
@property (nonatomic, copy, readonly) NSString *libraryDirectory;

/// Library/Caches目录
@property (nonatomic, copy, readonly) NSString *cachesDirectory;

/// tem目录
@property (nonatomic, copy, readonly) NSString *tempDirectory;

#pragma mark - Directory

+ (NSString * _Nonnull)homeDirectory;

+ (NSString * _Nonnull)documentDirectory;

+ (NSString * _Nonnull)libraryDirectory;

+ (NSString * _Nonnull)cachesDirectory;

+ (NSString * _Nonnull)tmpDirectory;

#pragma mark - Common

+ (BOOL)isExistsAtPath:(NSString *)path;

+ (BOOL)isExistDirectoryAtPath:(NSString *)path;

#pragma mark - Create

+ (BOOL)createFileAtPath:(NSString *)path Content:(NSData * _Nullable)content Attributes:(NSDictionary<NSFileAttributeKey, id> * _Nullable )attributes;

+ (BOOL)createDirectoryAtPath:(NSString *)path;

#pragma mark - Move

+ (BOOL)moveItemFromPath:(NSString *)fromPath ToPath:(NSString *)toPath;

#pragma mark - Copy

+ (BOOL)copyItemFromPath:(NSString *)fromPath ToPath:(NSString *)toPath;

#pragma mark - Read

+ (NSData * _Nullable)readFileWithDataFromPath:(NSString *)path;

+ (NSString * _Nullable)readFileWithStringFromPath:(NSString *)path;

#pragma mark - Write

+ (BOOL)writeFileToPath:(NSString *)path Content:(id)content;

#pragma mark - Delete

+ (BOOL)deleteItemAtPath:(NSString *)path;

#pragma mark - Foreach

+ (NSArray * _Nullable)foreachItemInPath:(NSString *)path DeepSearch:(BOOL)deepSearch;

@end

NS_ASSUME_NONNULL_END
