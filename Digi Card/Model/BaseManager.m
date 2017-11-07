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


@synthesize callbackBlock;
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
    NSDictionary *jsonObject;
    if ([resArray count]>1) {
        jsonObject=[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
    }
    else{
        jsonObject=[[NSDictionary alloc]initWithDictionary:[resArray objectAtIndex:0]];
    }
   // NSLog(@"%@   %lu",resArray, (unsigned long)[resArray count]);
    //NSDictionary *jsonObject=[[NSDictionary alloc]initWithDictionary:[resArray objectAtIndex:0]];
//
   // NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    // NSLog(@"jsonObject is %@",jsonObject);
    
    // NSLog(@"%@",json);
    callbackBlock(jsonObject);
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


@end
