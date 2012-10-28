//
//  NSDateTodayTomorrowTests.m
//  KAL
//
//  Created by Jinyoung Kim on 10/22/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSDate+TodayTomorrow.h"

@interface NSDateTodayTomorrowTests : SenTestCase

@end

@implementation NSDateTodayTomorrowTests

- (void)testTodayTomorrowDates {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:2012];
    [comps setMonth:12];
    [comps setDay:31];
    [comps setHour:12];
    [comps setMinute:34];
    [comps setSecond:56];
    NSDate *now = [calendar dateFromComponents:comps];
    [comps setYear:2012];
    [comps setMonth:12];
    [comps setDay:31];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    NSDate *eoToday = [calendar dateFromComponents:comps];
    [comps setYear:2013];
    [comps setMonth:1];
    [comps setDay:1];
    [comps setHour:00];
    [comps setMinute:00];
    [comps setSecond:00];
    NSDate *boTomorrow = [calendar dateFromComponents:comps];
    [comps setYear:2013];
    [comps setMonth:1];
    [comps setDay:1];
    [comps setHour:23];
    [comps setMinute:59];
    [comps setSecond:59];
    NSDate *eoTomorrow = [calendar dateFromComponents:comps];

    NSLog(@"now: %@", now);
    NSLog(@"endOfToday: %@", [now endOfToday]);
    NSLog(@"beginningOfTomorrow: %@", [now beginningOfTomorrow]);
    NSLog(@"endOfTomorrow: %@", [now endOfTomorrow]);
    
    STAssertTrue([eoToday compare:[now endOfToday]] == NSOrderedSame, @"End of today.");
    STAssertTrue([boTomorrow compare:[now beginningOfTomorrow]] == NSOrderedSame, @"Beginning of tomorrow.");
    STAssertTrue([eoTomorrow compare:[now endOfTomorrow]] == NSOrderedSame, @"End of tomorrow.");
}

@end
