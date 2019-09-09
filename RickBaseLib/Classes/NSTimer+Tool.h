//
//  NSTimer+Tool.h
//  StringDemo
//
//  Created by Rick on 2019/9/9.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (Tool)

+ (instancetype)timerWithInterval:(NSTimeInterval)interval Repeat:(BOOL)repeat Block:(void(^)(NSTimer *))block;

+ (instancetype)scheduledTimerWithInterval:(NSTimeInterval)interval Repeat:(BOOL)repeat Block:(void(^)(NSTimer *))block;

@end

NS_ASSUME_NONNULL_END
