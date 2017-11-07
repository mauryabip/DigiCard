//
//  DigiCardModel.m
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import "DigiCardModel.h"
#import "SVProgressHUD.h"

@implementation DigiCardModel



+(DigiCardModel*)sharedInstance
{
    static DigiCardModel*__instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [[DigiCardModel alloc] init];
    });
    return __instance;
}
-(BOOL)Isnetweork
{
    BOOL internetActive;
    Reachability  * internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
            
            NSLog(@"The internet is down.");
            internetActive = NO;
            
            break;
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            internetActive = YES;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            internetActive = YES;
            
            break;
        }
    }
    return internetActive;
    // check if a pathway to a random host exists
    //hostReachable = [Reachability reachabilityWithHostName:@"www.apple.com"];
    //[hostReachable startNotifier];
}
- (MBProgressHUD *)ShowWaiting:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    [hud hide:YES afterDelay:20.0];
    return hud;
}
- (MBProgressHUD *)ShowWaitingforDirection:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    [hud hide:YES afterDelay:10.0];
    return hud;
}
- (MBProgressHUD *)ShowWaitingLongtime:(NSString *)title {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    // [hud hide:YES afterDelay:20.0];
    return hud;
}
- (void)HideWaiting {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideHUDForView:window animated:YES];
}


-(void)show{
    [SVProgressHUD setBackgroundLayerColor:[[UIColor whiteColor] colorWithAlphaComponent:0.4]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD show];
}
-(void)Hide{
    [SVProgressHUD dismiss];
}
-(id)Storyboard :(NSString*)ControllerId
{
    UIViewController *vv=  [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:ControllerId];
    return vv;
    
}

- (void)errorWithTitle:(NSString*)title detailMessage:(NSString*)detail view:(UIView*)view {
    [HHAlertView showAlertWithStyle:HHAlertStyleError inView:view Title:title detail:detail cancelButton:nil Okbutton:nil];
}

- (void)success:(NSString*)title detailMessage:(NSString*)detail view:(UIView*)view {
    [HHAlertView showAlertWithStyle:HHAlertStyleOk inView:view Title:title detail:detail cancelButton:nil Okbutton:nil block:^(HHAlertButton buttonindex) {
        if (buttonindex == HHAlertButtonOk) {
            //            NSLog(@"ok Button is seleced use block");
            
        }
        else
        {
            //            NSLog(@"cancel Button is seleced use block");
            
        }
    }];
}

#pragma mark - No Network Slider

-(void)ViewSlideDown:(NSString*)Message{
    
    [HDNotificationView showNotificationViewWithImage:[UIImage imageNamed:@"icon.png"]
                                                title:APPNAME
                                              message:Message
                                           isAutoHide:YES
                                              onTouch:^{
                                                  
                                                  /// On touch handle. You can hide notification view or do something
                                                  [HDNotificationView hideNotificationViewOnComplete:nil];
                                              }];
    
    
    
}


@end
