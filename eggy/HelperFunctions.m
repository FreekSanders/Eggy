//
//  HelperFunctions.m
//  Easy Annotate
//
//  Created by Freek Sanders on 22-12-14.
//  Copyright (c) 2014 Freek Sanders. All rights reserved.
//

#import "HelperFunctions.h"

@implementation HelperFunctions

+ (BOOL)isIOS8 {
    BOOL ios8 = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[NSProcessInfo processInfo] respondsToSelector:@selector(operatingSystemVersion)]) {
        ios8 = YES;
    }
#endif
    return ios8;
}

@end
