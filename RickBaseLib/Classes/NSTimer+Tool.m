//
//  NSTimer+Tool.m
//  StringDemo
//
//  Created by Rick on 2019/9/9.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSTimer+Tool.h"

@implementation NSTimer (Tool)

+ (instancetype)timerWithInterval:(NSTimeInterval)interval Repeat:(BOOL)repeat Block:(void (^)(NSTimer * _Nonnull))block{
    
    if (@available(iOS 10.0, *)) {
        return [self timerWithTimeInterval:interval repeats:repeat block:block];
    }
    else {
        return [self timerWithTimeInterval:interval target:self selector:@selector(timerBlockAction:) userInfo:[block copy] repeats:repeat];
    }
}

+ (instancetype)scheduledTimerWithInterval:(NSTimeInterval)interval Repeat:(BOOL)repeat Block:(void (^)(NSTimer * _Nonnull))block{
    if (@available(iOS 10.0, *)) {
        return [self scheduledTimerWithTimeInterval:interval repeats:repeat block:block];
    }
    else {
        return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerBlockAction:) userInfo:[block copy] repeats:repeat];
    }
}

#pragma mark - Action

- (void)timerBlockAction:(NSTimer *)sender {
    if (sender.userInfo) {
        void(^block)(NSTimer *) = (void(^)(NSTimer *))[sender userInfo];
        !block?:block(sender);
    }
}

@end
