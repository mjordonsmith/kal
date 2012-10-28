//
//  NSDate+TodayTomorrow.m
//  KAL
//
//  Created by Jinyoung Kim on 10/20/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import "NSDate+TodayTomorrow.h"

@implementation NSDate (TodayTomorrow)

- (NSDate *)endOfToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:calendar];

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [dateFormatter setDateFormat:@"y"];
    [comps setYear:[[dateFormatter stringFromDate:self] intValue]];
    [dateFormatter setDateFormat:@"M"];
    [comps setMonth:[[dateFormatter stringFromDate:self] intValue]];
    [dateFormatter setDateFormat:@"d"];
    [comps setDay:[[dateFormatter stringFromDate:self] intValue]];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)beginningOfTomorrow {
    NSDate *tomorrow = [self dateByAddingTimeInterval:(60*60*24)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:calendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [dateFormatter setDateFormat:@"y"];
    [comps setYear:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [dateFormatter setDateFormat:@"M"];
    [comps setMonth:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [dateFormatter setDateFormat:@"d"];
    [comps setDay:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    
    return [calendar dateFromComponents:comps];
}

- (NSDate *)endOfTomorrow {
    NSDate *tomorrow = [self dateByAddingTimeInterval:(60*60*24)];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setCalendar:calendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [dateFormatter setDateFormat:@"y"];
    [comps setYear:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [dateFormatter setDateFormat:@"M"];
    [comps setMonth:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [dateFormatter setDateFormat:@"d"];
    [comps setDay:[[dateFormatter stringFromDate:tomorrow] intValue]];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    
    return [calendar dateFromComponents:comps];
}

@end
