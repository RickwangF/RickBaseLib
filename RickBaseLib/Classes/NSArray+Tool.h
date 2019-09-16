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

@property (nonatomic, copy, readonly) NSString* _Nullable jsonString;

#pragma mark - Common

+ (BOOL)isEmptyArray:(id)array;

#pragma mark - Plist

+ (instancetype _Nullable)arrayWithPlist:(NSString *)plist;

+ (instancetype _Nullable)arrayWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle;

@end

NS_ASSUME_NONNULL_END
