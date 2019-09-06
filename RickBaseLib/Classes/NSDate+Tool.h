//
//  NSDate+Tool.h
//  BaseLib
//
//  Created by Rick on 2019/9/2.
//  Copyright © 2019 Rick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Tool)

#pragma mark - Property

/// 年份
@property (nonatomic, assign, readonly) NSInteger year;

/// 月份
@property (nonatomic, assign, readonly) NSInteger month;

/// 日期
@property (nonatomic, assign, readonly) NSInteger day;

/// 小时
@property (nonatomic, assign, readonly) NSInteger hour;

/// 分钟
@property (nonatomic, assign, readonly) NSInteger minute;

/// 秒
@property (nonatomic, assign, readonly) NSInteger second;

/// 纳秒
@property (nonatomic, assign, readonly) NSInteger nanoSecond;

/// 闰年标志位
@property (nonatomic, assign, readonly) BOOL isLeapYear;

/// 闰月标志位
@property (nonatomic, assign, readonly) BOOL isLeapMonth;

/// 中文的描述日期
@property (nonatomic, copy, readonly) NSString *chDescString;

/// 默认的日期格式
@property (nonatomic, strong, class, readonly) NSDateFormatter *defaultFormatter;

/// 默认的时间格式
@property (nonatomic, strong, class, readonly) NSDateFormatter *timeFormatter;

#pragma mark - String To Date

+ (NSDate * _Nullable)dateFromDateString:(NSString *)string WithFormatter:(NSDateFormatter*)formatter;

#pragma mark - Date To String

+ (NSString *)nowDateString;

+ (NSString *)dateStringWithDate:(NSDate *)date Formatter:(NSDateFormatter *)formatter;

- (NSString *)dateStringWithDateFormatter:(NSDateFormatter *)formatter;

+ (NSString *)chDescWithDate:(NSDate *)date;

#pragma mark - Calculate

- (NSDate * _Nullable)dateByAddingYears:(NSInteger)years;

- (NSDate * _Nullable)dateByAddingMonths:(NSInteger)months;

- (NSDate * _Nullable)dateByAddingWeeks:(NSInteger)weeks;

- (NSDate * _Nullable)dateByAddingDays:(NSInteger)days;

- (NSDate * _Nullable)dateByAddingHours:(NSInteger)hours;

- (NSDate * _Nullable)dateByAddingMinutes:(NSInteger)minutes;

- (NSDate * _Nullable)dateByAddingSeconds:(NSInteger)seconds;

#pragma mark - Judge

- (BOOL)isLeapYear;

- (BOOL)isLeapMonth;

@end

NS_ASSUME_NONNULL_END
