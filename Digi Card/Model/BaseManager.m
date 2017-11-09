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


@synthesize callbackBlock,callbackBlockArray;
- (id)init
{
    self = [super init];
    if (self) {
        responseData = [[NSMutableData alloc] init];
    }
    return self;
}

+ (BaseManager *)sharedInstance {
    static BaseManager *__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[BaseManager alloc] init];
    });
    return __instance;
}
//withCallback: (void(^) (NSString* response)) callback;



-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [responseData  setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData  appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Some error in your Connection. Please try again.");
    
     [[DigiCardModel sharedInstance]HideWaiting];
    //    self.alertView = [[UIAlertView alloc] initWithTitle:NoInternetConnection message:TryAgainLater delegate:self cancelButtonTitle:OK otherButtonTitles:nil];
    //    [self.alertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //        UIApplication *app = [UIApplication sharedApplication];
        //        [app performSelector:@selector(suspend)];
        // [NSThread sleepForTimeInterval:2.0];
        // exit(0);
    }
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //    NSLog(@"Received %lu Bytes", (unsigned long)[responseData length]);
    //    NSString *json = [[NSString alloc] initWithBytes:
    //                      [responseData mutableBytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    //callback(nil,nil);
 
    NSString *resultStringOne = [[NSMutableString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSString *one = [self stringBystrippingxml:resultStringOne];
    NSError *jsonError;
    NSData *jsonData = [one dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *resArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
    if ([[DigiCardModel sharedInstance].customerList length]>0) {
        callbackBlockArray(resArray);

    }else{
        NSDictionary *jsonObject;
        if ([resArray count]>1) {
            jsonObject=[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
        }
        else{
            jsonObject=[[NSDictionary alloc]initWithDictionary:[resArray objectAtIndex:0]];
        }
        callbackBlock(jsonObject);

    }

   // NSLog(@"%@   %lu",resArray, (unsigned long)[resArray count]);
    //NSDictionary *jsonObject=[[NSDictionary alloc]initWithDictionary:[resArray objectAtIndex:0]];
//
   // NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    // NSLog(@"jsonObject is %@",jsonObject);
    
    // NSLog(@"%@",json);
}
- (NSString *)stringBystrippingxml:(NSString *)provideString
{
    NSRange range;
    while ((range = [provideString rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        provideString = [provideString stringByReplacingCharactersInRange:range withString:@""];
    
    return provideString;
}


-(void) AppLoginStatusCheck:(NSString *) UserID AuthCode:(NSString*)AuthCode  withCallback: (void(^) (NSDictionary* response)) callback
{
    //  LoginCount===0

    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppLoginStatusCheck xmlns=\"http://tempuri.org/\">"
                             "<UserID>%@</UserID>"
                             "<AuthCode>%@</AuthCode>"
                             "</AppLoginStatusCheck>"
                             "</soap:Body>"
                             "</soap:Envelope>",UserID,AuthCode];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/LoginService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppLoginStatusCheck" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppUserLogin:(NSString *)UserName Password:(NSString*)Password AuthCode:(NSString*)AuthCode ClientVersion:(NSString*)ClientVersion withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppUserLogin xmlns=\"http://tempuri.org/\">"
                             "<UserName>%@</UserName>"
                             "<Password>%@</Password>"
                             "<AuthCode>%@</AuthCode>"
                             "<ClientName>%@</ClientName>"
                             "<ClientVersion>%@</ClientVersion>"
                             "</AppUserLogin>"
                             "</soap:Body>"
                             "</soap:Envelope>",UserName,Password,AuthCode,@"ios",ClientVersion];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/LoginService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppUserLogin" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppUserDetail:(NSString*)AuthCode UserID:(NSString*)UserID withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppUserDetail xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "</AppUserDetail>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/LoginService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppUserDetail" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppUserForgetPassword:(NSString*)UserName withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppUserForgetPassword xmlns=\"http://tempuri.org/\">"
                             "<UserName>%@</UserName>"
                             "</AppUserForgetPassword>"
                             "</soap:Body>"
                             "</soap:Envelope>",UserName];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/LoginService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppUserForgetPassword" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppUserChangePassword:(NSString*)UserID OldPassword:(NSString*)OldPassword NewPassword:(NSString*)NewPassword AuthCode:(NSString*)AuthCode  withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppUserForgetPassword xmlns=\"http://tempuri.org/\">"
                             "<UserID>%@</UserID>"
                             "<OldPassword>%@</OldPassword>"
                             "<NewPassword>%@</NewPassword>"
                             "<AuthCode>%@</AuthCode>"
                             "</AppUserForgetPassword>"
                             "</soap:Body>"
                             "</soap:Envelope>",UserID,OldPassword,NewPassword,AuthCode];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/LoginService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppUserChangePassword" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppddlList:(NSString*)AuthCode UserID:(NSString*)UserID withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppddlList xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "</AppddlList>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID];
    
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/DigiCardScannerService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppddlList" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}


-(void) AppCustomerList:(NSString*)AuthCode UserID:(NSString*)UserID CustomerName:(NSString*)CustomerName PrincipleID:(NSString*)PrincipleID BusinessVerticalID:(NSString*)BusinessVerticalID IndustrySegmentID:(NSString*)IndustrySegmentID IndustryTypeID:(NSString*)IndustryTypeID ZoneID:(NSString*)ZoneID withCallback:(void(^) (NSArray* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppCustomerList xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "<CustomerName>%@</CustomerName>"
                             "<PrincipleID>%@</PrincipleID>"
                             "<BusinessVerticalID>%@</BusinessVerticalID>"
                             "<IndustrySegmentID>%@</IndustrySegmentID>"
                             "<IndustryTypeID>%@</IndustryTypeID>"
                             "<ZoneID>%@</ZoneID>"
                             "</AppCustomerList>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID,CustomerName,PrincipleID,BusinessVerticalID,IndustrySegmentID,IndustryTypeID,ZoneID];
    

    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/DigiCardScannerService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue: @"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppCustomerList" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlockArray=callback;
    
}


-(void) AppCustomerDetail:(NSString*)AuthCode UserID:(NSString*)UserID CustomerID:(NSString*)CustomerID withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppCustomerDetail xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "<CustomerID>%@</CustomerID>"
                             "</AppCustomerDetail>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID,CustomerID];

    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/DigiCardScannerService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppCustomerDetail" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

-(void) AppCustomerDelete:(NSString*)AuthCode UserID:(NSString*)UserID CustomerID:(NSString*)CustomerID withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppCustomerDelete xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "<CustomerID>%@</CustomerID>"
                             "</AppCustomerDelete>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID,CustomerID];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/DigiCardScannerService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppCustomerDelete" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

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
              withCallback:(void(^) (NSDictionary* response)) callback
{
    NSString * soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                             "<soap:Body>"
                             "<AppCustomerInsUpdt xmlns=\"http://tempuri.org/\">"
                             "<AuthCode>%@</AuthCode>"
                             "<UserID>%@</UserID>"
                             "<CustomerID>%@</CustomerID>"
                             "<Title>%@</Title>"
                             "<CustomerName>%@</CustomerName>"
                             "<DOB>%@</DOB>"
                             "<Designation>%@</Designation>"
                             "<CompanyName>%@</CompanyName>"
                             "<Website>%@</Website>"
                             "<ContactTypeID>%@</ContactTypeID>"
                             "<ManagementTypeID>%@</ManagementTypeID>"
                             "<ZoneID>%@</ZoneID>"
                             "<EmailID>%@</EmailID>"
                             "<EmailID2>%@</EmailID2>"
                             "<NumberType1>%@</NumberType1>"
                             "<Number1>%@</Number1>"
                             "<NumberType2>%@</NumberType2>"
                             "<Number2>%@</Number2>"
                             "<NumberType3>%@</NumberType3>"
                             "<Number3>%@</Number3>"
                             "<NumberType4>%@</NumberType4>"
                             "<Number4>%@</Number4>"
                             "<NumberType5>%@</NumberType5>"
                             "<Number5>%@</Number5>"
                             "<CardFrontImageString>%@</CardFrontImageString>"
                             "<CardFrontImageExtension>%@</CardFrontImageExtension>"
                             "<CardBackImageString>%@</CardBackImageString>"
                             "<CardBackImageExtension>%@</CardBackImageExtension>"
                             "<Remark>%@</Remark>"
                             "<OfficeAddress>%@</OfficeAddress>"
                             "<OfficePin>%@</OfficePin>"
                             "<FactoryAddress>%@</FactoryAddress>"
                             "<FactoryPin>%@</FactoryPin>"
                             "<ResidenceAddress>%@</ResidenceAddress>"
                             "<ResidencePin>%@</ResidencePin>"
                             "<PrincipleList>%@</PrincipleList>"
                             "<BusinessVerticalList>%@</BusinessVerticalList>"
                             "<IndustrySegmentList>%@</IndustrySegmentList>"
                             "<IndustryTypeList>%@</IndustryTypeList>"
                             "</AppCustomerInsUpdt>"
                             "</soap:Body>"
                             "</soap:Envelope>",AuthCode,UserID,CustomerID,Title,CustomerName,DOB,Designation,CompanyName,Website,ContactTypeID,ManagementTypeID,ZoneID,EmailID,EmailID2,NumberType1,Number1,NumberType2,Number2,NumberType3,Number3, NumberType4,Number4, NumberType5,Number5,CardFrontImageString,CardFrontImageExtension,CardBackImageString,CardBackImageExtension,Remark,OfficeAddress,OfficePin,FactoryAddress,FactoryPin,ResidenceAddress,ResidencePin, PrincipleList,BusinessVerticalList,IndustrySegmentList,IndustryTypeList];
    
    //Now create a request to the URL
    NSURL *url = [NSURL URLWithString:@"http://cfcsitservices.co.in/card/WebApi/DigiCardScannerService.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //ad required headers to the request
    [theRequest addValue:@"cfcsitservices.co.in" forHTTPHeaderField:@"Host"];
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://tempuri.org/AppCustomerInsUpdt" forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //initiate the request
    connection =[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if(connection)
    {
        responseData = [NSMutableData data] ;
    }
    else
    {
        NSLog(@"Connection is NULL");
    }
    callbackBlock=callback;
    
}

@end
