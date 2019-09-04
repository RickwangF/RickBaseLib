//
//  NSDictionary+Tool.h
//  RickBaseLib
//
//  Created by Rick on 2019/9/4.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Tool)

#pragma mark - Property

@property (nonatomic, copy, readonly) NSString *jsonString;

#pragma mark - Plist

+ (instancetype)dictionaryWithPlist:(NSString *)plist;

+ (instancetype)dictionaryWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle;

@end

NS_ASSUME_NONNULL_END
