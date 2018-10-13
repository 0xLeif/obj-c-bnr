//
//  main.m
//  file
//
//  Created by Zach Eriksen on 10/11/18.
//  Copyright © 2018 oneleif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNRLogger.h"

BOOL writeToFileExample() {
    NSMutableString *str = NSMutableString.new;
    NSError *writeError;
    for (int i = 0; i < 10; i++) {
        [str appendString:@"Zach is cool!\n"];
    }
    
    BOOL success = [str writeToFile:@"/tmp/cool.txt"
                         atomically:true
                           encoding:NSUTF8StringEncoding
                              error:&writeError];
    
    if (success) {
        NSLog(@"Done writing /tmp/cool.txt");
    } else {
        NSLog(@"Error writing to /tmp/cool.txt: %@", [writeError localizedDescription]);
    }
    
    return success;
}

void readFromFileExample() {
    NSLog(@"Reading file...\n");
    
    NSError *readError;
    NSString *readStr = [[NSString alloc] initWithContentsOfFile:@"/etc/resolv.conf"
                                                        encoding:NSUTF8StringEncoding
                                                           error:&readError];
    
    if (!readError) {
        NSLog(@"FILE READ:\n%@\n", readStr);
    } else {
        NSLog(@"Error reading from /etc/resolv.conf: %@", [readError localizedDescription]);
    }
}

void writeToFileFromURLExample() {
    NSURL *url = [NSURL URLWithString:@"https://media2.giphy.com/media/fedryX7dMGMe6lgqDm/giphy.gif"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    BOOL __block hasCompleted = false;
    NSData __block *gif;
//     [NSURLSession dataTaskWithRequest:completionHandler:]
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:^(NSData *data,
                                                         NSURLResponse *response,
                                                         NSError *error) {
                                         gif = data;
                                         hasCompleted = true;
                                     }] resume];
    
    while (!hasCompleted){}
    
    NSLog(@"GIF Data: %@\n", gif);
    
    BOOL written = [gif writeToFile:@"/tmp/cool.gif" atomically:true];
    
    if (!written) {
        NSLog(@"Error writing to file for gif");
    }
    
    NSLog(@"Wrote gif to file!");
}

void findMyDesktop() {
    NSLog(@"HERE: %@",[NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, true) firstObject]);
}

void testLogger() {
    BNRLogger *logger = [BNRLogger new];
    __unused NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:logger
                                                    selector:@selector(updateLastTime:)
                                                    userInfo:nil
                                                     repeats:true];
    
    [[NSRunLoop currentRunLoop] run];
}

void blockTest() {
    ^(int i, NSString *str){
        for (int x = 0; x < i; x++) {
            NSLog(@"%@ ", str);
        }
    }(5, @"Hello! ");
}

void voidBlockTest() {
    ^{
        NSLog(@"Hello World");
    }();
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Writing Example
        writeToFileExample();
        // Reading Example
        readFromFileExample();
        // Writing to File from URL Example
        writeToFileFromURLExample();
        // Where is my Desktop Example
        findMyDesktop();
        // Logger Example
        testLogger();
        // Block Tests Examples
        voidBlockTest();
        blockTest();
    }
    return 0;
}
