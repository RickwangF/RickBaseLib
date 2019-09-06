//
//  NSDate+Tool.m
//  BaseLib
//
//  Created by Rick on 2019/9/2.
//  Copyright © 2019 Rick. All rights reserved.
//

#import "NSDate+Tool.h"

@implementation NSDate (Tool)

#pragma mark - Property Get

- (NSInteger)year{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSInteger)month{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)day{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)hour{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return components.hour;
}

- (NSInteger)minute{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return components.minute;
}

- (NSInteger)second{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return components.second;
}

- (NSInteger)nanoSecond{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self];
    return components.nanosecond;
}

+ (NSDateFormatter *)defaultFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return formatter;
}

+ (NSDateFormatter *)timeFormatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm:ss";
    return formatter;
}

#pragma mark - String To Date

+ (NSDate * _Nullable)dateFromDateString:(NSString *)string WithFormatter:(NSDateFormatter*)formatter{
    if (string == nil || ![string isKindOfClass:NSString.class] || [string isEqualToString:@""]) {
        return nil;
    }
    
    if (formatter == nil || ![formatter isKindOfClass:NSDateFormatter.class]) {
        return nil;
    }
    
    NSDate *date = [formatter dateFromString:string];
    return date;
}

#pragma mark - Date To String

+ (NSString *)nowDateString{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)dateStringWithDate:(NSDate *)date Formatter:(NSDateFormatter *)formatter{
    if (date == nil || ![date isKindOfClass:NSDate.class]) {
        return @"";
    }
    
    if (formatter == nil || ![formatter isKindOfClass:NSDateFormatter.class]) {
        return @"";
    }
    
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

- (NSString *)dateStringWithDateFormatter:(NSDateFormatter *)formatter{
    if (formatter == nil || ![formatter isKindOfClass:NSDateFormatter.class]) {
        return @"";
    }
    
    NSString *dateString = [formatter stringFromDate:self];
    return dateString;
}

+ (NSString *)chDescWithDate:(NSDate *)date{
    if (date == nil || ![date isKindOfClass:NSDate.class]) {
        return @"未知时间";
    }
    NSString *descString;
    NSString *dateString = [NSDate.defaultFormatter stringFromDate:date];
    NSString *timeString = [NSDate.timeFormatter stringFromDate:date];

    NSDate *now = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    NSString *zeroClockString = [NSString stringWithFormat:@"%ld-%ld-%ld 00:00:00", (long)components.year, (long)components.month, (long)components.day];
    NSDate *today0Clock = [NSDate.defaultFormatter dateFromString:zeroClockString];
    NSDate *yestoday0Clock = [today0Clock dateByAddingTimeInterval:-24*60*60];
    
    NSTimeInterval interval = [now timeIntervalSinceDate:date];
    
    if (interval < 24*60*60) {
        if ([date compare:today0Clock] == kCFCompareLessThan || [date compare:yestoday0Clock] == kCFCompareEqualTo) {
            descString = [NSString stringWithFormat:@"昨天 %@", timeString];
        }
        else {
            descString = [NSString stringWithFormat:@"今天 %@", timeString];
        }
    }
    else if (interval < 2*24*60*60) {
        if ([date compare:yestoday0Clock] == kCFCompareGreaterThan || [date compare:yestoday0Clock] == kCFCompareEqualTo) {
            descString = [NSString stringWithFormat:@"昨天 %@", timeString];
        }
        else {
            descString = dateString;
        }
    }
    else {
        descString = dateString;
    }
    
    return descString;
}

- (NSString *)chDescString{
    return [NSDate chDescWithDate:self];
}

#pragma mark - Caculate

- (NSDate * _Nullable)dateByAddingYears:(NSInteger)years{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = years;
    NSDate *date = [calender dateByAddingComponents:components toDate:self options:NSCalendarWrapComponents];
    return date;
}

- (NSDate * _Nullable)dateByAddingMonths:(NSInteger)months{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = months;
    NSDate *date = [calender dateByAddingComponents:components toDate:self options:NSCalendarWrapComponents];
    return date;
}

- (NSDate * _Nullable)dateByAddingWeeks:(NSInteger)weeks{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.weekOfYear = weeks;
    NSDate *date = [calender dateByAddingComponents:components toDate:self options:NSCalendarWrapComponents];
    return date;
}

- (NSDate * _Nullable)dateByAddingDays:(NSInteger)days{
    NSDate *date = [NSDate dateWithTimeInterval:days*24*60*60 sinceDate:self];
    return date;
}

- (NSDate * _Nullable)dateByAddingHours:(NSInteger)hours{
    NSDate *date = [NSDate dateWithTimeInterval:hours*60*60 sinceDate:self];
    return date;
}

- (NSDate * _Nullable)dateByAddingMinutes:(NSInteger)minutes{
    NSDate *date = [NSDate dateWithTimeInterval:minutes*60 sinceDate:self];
    return date;
}

- (NSDate * _Nullable)dateByAddingSeconds:(NSInteger)seconds{
    NSDate *date = [NSDate dateWithTimeInterval:seconds sinceDate:self];
    return date;
}

#pragma mark - Judge

- (BOOL)isLeapYear{
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isLeapMonth{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

@end
