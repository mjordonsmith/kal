//
//  NSDate+TodayTomorrow.h
//  KAL
//
//  Created by Jinyoung Kim on 10/20/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TodayTomorrow)

- (NSDate *)endOfToday;
- (NSDate *)beginningOfTomorrow;
- (NSDate *)endOfTomorrow;

@end
