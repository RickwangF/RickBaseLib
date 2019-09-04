//
//  NSDictionary+Tool.m
//  RickBaseLib
//
//  Created by Rick on 2019/9/4.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSDictionary+Tool.h"
#import "NSString+Tool.h"

@implementation NSDictionary (Tool)

#pragma mark - Property Get

- (NSString *)jsonString{
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

#pragma mark - Plist

+ (instancetype)dictionaryWithPlist:(NSString *)plist{
    return [self dictionaryWithPlist:plist Bundle:nil];
}

+ (instancetype)dictionaryWithPlist:(NSString *)plist Bundle:(NSString * _Nullable)bundle{
    if ([NSString isEmpty:plist]) {
        return [NSDictionary dictionary];
    }
    
    NSString *path;
    if ([NSString isEmpty:bundle]) {
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
