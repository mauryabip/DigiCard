//
//  BaseManager.m
//  Floovr-based
//
//  Created by umenit on 7/21/16.
//  Copyright © 2016 test. All rights reserved.
//

#import "BaseManager.h"
@interface BaseManager () {

        RKObjectMapping*    _LoginOM;
 
}
@end
@implementation BaseManager

@synthesize MANAGERBASEURL;
+ (BaseManager *)sharedInstance {
    static BaseManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BaseManager alloc] init];
    });
    return __instance;
}
-(void)BaseManager{
    NSURL *baseURL = [NSURL URLWithString:BASEURL];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
    [RKObjectManager setSharedManager:objectManager];
    MANAGERBASEURL=objectManager;
}
- (void)ResponseObjectMappingConfiguration
{
    
}


static id ObjectOrNull(id object)
{
    return object ?: [NSNull null];
}
@end
