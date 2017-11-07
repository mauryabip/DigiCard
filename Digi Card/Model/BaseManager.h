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


-(void) AppCustomerList:(NSString*)AuthCode
                 UserID:(NSString*)UserID
           CustomerName:(NSString*)CustomerName
            PrincipleID:(NSString*)PrincipleID
     BusinessVerticalID:(NSString*)BusinessVerticalID
      IndustrySegmentID:(NSString*)IndustrySegmentID
         IndustryTypeID:(NSString*)IndustryTypeID
                 ZoneID:(NSString*)ZoneID
           withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppCustomerDetail:(NSString*)AuthCode
                   UserID:(NSString*)UserID
               CustomerID:(NSString*)CustomerID
             withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppCustomerDelete:(NSString*)AuthCode
                   UserID:(NSString*)UserID
               CustomerID:(NSString*)CustomerID
             withCallback:(void(^) (NSDictionary* response)) callback;


-(void) AppCustomerInsUpdt:(NSString*)AuthCode
                    UserID:(NSString*)UserID
                CustomerID:(NSString*)CustomerID
                     Title:(NSString*)Title
              CustomerName:(NSString*)CustomerName
                       DOB:(NSString*)DOB
               Designation:(NSString*)Designation
               CompanyName:(NSString*)CompanyName
                   Website:(NSString*)Website
             ContactTypeID:(NSString*)ContactTypeID
          ManagementTypeID:(NSString*)ManagementTypeID
                    ZoneID:(NSString*)ZoneID
                   EmailID:(NSString*)EmailID
                  EmailID2:(NSString*)EmailID2
               NumberType1:(NSString*)NumberType1
                   Number1:(NSString*)Number1
               NumberType2:(NSString*)NumberType2
                   Number2:(NSString*)Number2
               NumberType3:(NSString*)NumberType3
                   Number3:(NSString*)Number3
               NumberType4:(NSString*)NumberType4
                   Number4:(NSString*)Number4
               NumberType5:(NSString*)NumberType5
                   Number5:(NSString*)Number5
      CardFrontImageString:(NSString*)CardFrontImageString
   CardFrontImageExtension:(NSString*)CardFrontImageExtension
       CardBackImageString:(NSString*)CardBackImageString
    CardBackImageExtension:(NSString*)CardBackImageExtension
                    Remark:(NSString*)Remark
             OfficeAddress:(NSString*)OfficeAddress
                 OfficePin:(NSString*)OfficePin
            FactoryAddress:(NSString*)FactoryAddress
                FactoryPin:(NSString*)FactoryPin
          ResidenceAddress:(NSString*)ResidenceAddress
              ResidencePin:(NSString*)ResidencePin
             PrincipleList:(NSString*)PrincipleList
      BusinessVerticalList:(NSString*)BusinessVerticalList
       IndustrySegmentList:(NSString*)IndustrySegmentList
          IndustryTypeList:(NSString*)IndustryTypeList
              withCallback:(void(^) (NSDictionary* response)) callback;



@end
