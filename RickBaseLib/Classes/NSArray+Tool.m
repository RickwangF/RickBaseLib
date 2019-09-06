//
//  NSArray+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/5.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSArray+Tool.h"
#import "NSString+Tool.h"

@implementation NSArray (Tool)

#pragma mark - Property Get

- (NSString * _Nullable)jsonString{
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (error) {
        return nil;
    }
    
    return jsonString;
}

#pragma mark - Common

+ (BOOL)isEmptyArray:(id)array{
    if (array == nil || array == [NSNull null] || ![array isKindOfClass:NSArray.class]) {
        return YES;
    }
    
    if ([(NSArray*)array count] == 0) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Plist

+ (instancetype)arrayWithPlist:(NSString *)plist{
    return [self arrayWithPlist:plist Bundle:nil];
}

+ (instancetype)arrayWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle{
    if ([NSString isEmptyString:plist]) {
        return [NSArray array];
    }
    
    NSString *path;
    if ([NSString isEmptyString:bundle]) {
        path = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    }
    else {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"];
        path = [NSString stringWithFormat:@"%@/%@.plist", bundlePath, plist];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return [NSArray array];;
    }
    
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

@end
