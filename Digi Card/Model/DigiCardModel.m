//
//  DigiCardModel.m
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import "DigiCardModel.h"

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
-(id)Storyboard :(NSString*)ControllerId
{
    UIViewController *vv=  [[UIStoryboard storyboardWithName:STORYBOARD bundle:nil] instantiateViewControllerWithIdentifier:ControllerId];
    return vv;
    
}

@end
