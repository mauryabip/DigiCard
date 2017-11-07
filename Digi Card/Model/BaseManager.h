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


@interface BaseManager : NSObject<NSURLConnectionDelegate, NSXMLParserDelegate,UIAlertViewDelegate>{
    NSURLConnection *connection;
    NSMutableData *responseData;
    NSMutableDictionary *model;
    
}
@property (strong, nonatomic) UIAlertView *alertView;
@property (nonatomic, copy) void (^ callbackBlock)(NSDictionary *response);

+ (BaseManager *)sharedInstance;




-(void) AppLoginStatusCheck:(NSString *)UserID
                   AuthCode:(NSString*)AuthCode
               withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppUserLogin:(NSString *)UserName
            Password:(NSString*)Password
            AuthCode:(NSString*)AuthCode
       ClientVersion:(NSString*)ClientVersion
        withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppUserDetail:(NSString*)AuthCode
               UserID:(NSString*)UserID
         withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppUserForgetPassword:(NSString*)UserName
                 withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppUserChangePassword:(NSString*)UserID
                  OldPassword:(NSString*)OldPassword
                  NewPassword:(NSString*)NewPassword
                     AuthCode:(NSString*)AuthCode
                 withCallback:(void(^) (NSDictionary* response)) callback;



-(void) AppddlList:(NSString*)AuthCode
            UserID:(NSString*)UserID
      withCallback:(void(^) (NSDictionary* response)) callback;



@end
