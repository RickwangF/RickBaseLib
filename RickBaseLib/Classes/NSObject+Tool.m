//
//  NSObject+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/4.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSObject+Tool.h"
#import "NSString+Tool.h"

@implementation NSObject (Tool)

#pragma mark - Common

+ (BOOL)isNil:(id)obj{
    if (obj == nil || obj == [NSNull null]) {
        return YES;
    }
    
    if ([obj isKindOfClass:NSNull.class] || [obj class] == Nil || obj == NULL) {
        return YES;
    }
    
    return NO;
}

@end
