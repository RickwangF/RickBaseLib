//
//  NSArray+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/5.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Tool)

#pragma mark - Property

@property (nonatomic, copy, readonly) NSString *jsonString;

#pragma mark - Common

+ (BOOL)isEmptyArray:(id)array;

#pragma mark - Plist

+ (instancetype)arrayWithPlist:(NSString *)plist;

+ (instancetype)arrayWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle;

@end

NS_ASSUME_NONNULL_END