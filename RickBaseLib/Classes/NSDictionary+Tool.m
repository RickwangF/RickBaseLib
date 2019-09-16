//
//  NSDictionary+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/4.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSDictionary+Tool.h"
#import "NSString+Tool.h"

@implementation NSDictionary (Tool)

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

+ (BOOL)isEmptyDictionary:(id)dic{
    if (dic == nil || dic == [NSNull null] || ![dic isKindOfClass:NSDictionary.class]) {
        return YES;
    }
    
    NSDictionary *dictionary = (NSDictionary *)dic;
    if (dictionary.count == 0) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Plist

+ (instancetype _Nullable)dictionaryWithPlist:(NSString *)plist{
    return [self dictionaryWithPlist:plist Bundle:nil];
}

+ (instancetype _Nullable)dictionaryWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle{
    if ([NSString isEmptyString:plist]) {
        return [NSDictionary dictionary];
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
        return [NSDictionary dictionary];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
    return dic;
}

@end
