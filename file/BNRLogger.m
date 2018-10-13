//
//  BNRLogger.m
//  file
//
//  Created by Zach Eriksen on 10/13/18.
//  Copyright © 2018 oneleif. All rights reserved.
//

#import "BNRLogger.h"


@implementation BNRLogger

- (NSString *)lastTimeString {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        NSLog(@"Created lastTimeString");
    }
    return [dateFormatter stringFromDate: [self lastTime]];
}

- (void)updateLastTime:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    [self setLastTime:now];
    NSLog(@"Just set time to %@", [self lastTimeString]);
}

@end
