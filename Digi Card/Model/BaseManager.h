//
//  BaseManager.h
//  Floovr-based
//
//  Created by umenit on 7/21/16.
//  Copyright © 2016 test. All rights reserved.
//


#define BASEURL @"http://138.68.175.0/sandbox-floovr/fapi/v2/index.php"

#import <Foundation/Foundation.h>
#import "NSObject+JSON.h"


@interface BaseManager : NSObject
+ (BaseManager *)sharedInstance;

@end
