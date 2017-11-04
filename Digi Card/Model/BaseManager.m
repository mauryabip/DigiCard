//
//  BaseManager.m
//  Floovr-based
//
//  Created by umenit on 7/21/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "BaseManager.h"
@interface BaseManager ()
@end
@implementation BaseManager

+ (BaseManager *)sharedInstance {
    static BaseManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BaseManager alloc] init];
    });
    return __instance;
}


static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}
@end
