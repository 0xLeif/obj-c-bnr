//
//  BNRLogger.h
//  file
//
//  Created by Zach Eriksen on 10/13/18.
//  Copyright © 2018 oneleif. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNRLogger : NSObject

@property (nonatomic) NSDate *lastTime;
- (NSString *)lastTimeString;
- (void)updateLastTime:(NSTimer *)timer;

@end

NS_ASSUME_NONNULL_END
