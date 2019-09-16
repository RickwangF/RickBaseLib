//
//  NSDictionary+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/4.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Tool)

#pragma mark - Property

@property (nonatomic, copy, readonly) NSString* _Nullable jsonString;

#pragma mark - Common

+ (BOOL)isEmptyDictionary:(id)dic;

#pragma mark - Plist

+ (instancetype _Nullable)dictionaryWithPlist:(NSString *)plist;

+ (instancetype _Nullable)dictionaryWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle;

@end

NS_ASSUME_NONNULL_END
