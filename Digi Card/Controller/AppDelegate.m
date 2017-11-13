//
//  AppDelegate.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize remoteHostStatus,isInternet;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // [NSThread sleepForTimeInterval:2.0];
    
    reachability = [Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    [reachability startNotifier];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    IsNoInternetAppear=false;
    
    if(remoteHostStatus == NotReachable) {
        isInternet = false;
        
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = true;
        //    NSLog(@"Connected via wifi");
        
        
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = true;
        //   NSLog(@"connected via cell");
        IsNoInternetAppear = false;
        
    }
    
    if (APPDELEGATE.isInternet){
        
    }
    else{
        [self performSelector:@selector(handle) withObject:nil afterDelay:2.000];
        
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)SetNavigationBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setBarTintColor:NAVCOLR];
    [[UINavigationBar appearance] setTintColor:NAVCOLBASE];
    [[UINavigationBar appearance] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:NAVCOLBASE,NSFontAttributeName:FONT }];
    _maintab=[[UITabBarController alloc]init];
    _maintab.delegate=self;
    [[UITabBar appearance] setTintColor:NAVCOLR];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController: [[DigiCardModel sharedInstance]Storyboard:@"CardListVC"]];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController: [[DigiCardModel sharedInstance]Storyboard:@"ScannerVC"]];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController: [[DigiCardModel sharedInstance]Storyboard:@"MyProfileVC"]];
    
    tabbarray=[[NSArray alloc]initWithObjects:nav1,nav2,nav3,nil];
    
    _maintab.viewControllers=tabbarray;
    self.window.rootViewController = _maintab;
    
    [[_maintab.tabBar.items objectAtIndex:0] setTitle:@"Card"];
    [[_maintab.tabBar.items objectAtIndex:1] setTitle:@"Scanner"];
    [[_maintab.tabBar.items objectAtIndex:2] setTitle:@"Profile"];
    
    [[_maintab.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"cam_icon.png"]];
    [[_maintab.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"card_icon.png"]];
    [[_maintab.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"pro_icon.png"]];
    
    
    //    [[_maintab.tabBar.items objectAtIndex:0] setTitlePositionAdjustment:UIOffsetMake(0, -7)];
    //    [[_maintab.tabBar.items objectAtIndex:1] setTitlePositionAdjustment:UIOffsetMake(0, -7)];
    //    [[_maintab.tabBar.items objectAtIndex:2] setTitlePositionAdjustment:UIOffsetMake(0, -7)];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:15]                                                        }
                                             forState:UIControlStateNormal];
    
    self.window.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:234.0/255.0f blue:234.0/255.0f alpha:1.0f];
    [self.window makeKeyAndVisible];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
    NSUInteger indexOfTab = [_maintab.viewControllers indexOfObject:viewController];
    if (indexOfTab==0) {
        [self resetValue];
    }
    [[_maintab.viewControllers objectAtIndex:indexOfTab] popToRootViewControllerAnimated:YES];
    
    
}

-(void)resetValue{
    
    NSDictionary *dictionary = @{
                                 @"PrincipleID": @{
                                         @"PrincipleID": @"0"
                                         },
                                 @"BusinessVerticalID": @{
                                         @"BusinessVerticalID": @"0"
                                         },
                                 @"IndustryTypeID": @{
                                         @"IndustryTypeID": @"0"
                                         },
                                 @"IndustrySegmentID": @{
                                         @"IndustrySegmentID": @"0"
                                         },
                                 @"ZoneID": @{
                                         @"ZoneID": @"0"
                                         },
                                 };
    
    [DigiCardModel sharedInstance].PrincipleMasterIDArray=[dictionary objectForKey:@"PrincipleID"];
    [DigiCardModel sharedInstance].BusinessVerticalIDMasterArray=[dictionary objectForKey:@"BusinessVerticalID"];
    [DigiCardModel sharedInstance].IndustryTypeMasterIDArray=[dictionary objectForKey:@"IndustryTypeID"];
    [DigiCardModel sharedInstance].IndustrySegmentMasterIDArray=[dictionary objectForKey:@"IndustrySegmentID"];
    [DigiCardModel sharedInstance].zoneIDArray=[dictionary objectForKey:@"ZoneID"];
}

-(void)handle{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    // UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    // UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"NoInternetViewController"];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        isInternet = false;
        if (!IsNoInternetAppear) {
            IsNoInternetAppear = YES;
            [[DigiCardModel sharedInstance]Hide];
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKUNAVILABLE];
            // [self addNoNetworkView];
            // [navController presentViewController:vc animated:YES completion:nil];
        }
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = true;
        if (IsNoInternetAppear) {
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKAVILABLE];

            //[self removeNoNetworkView];
            // [navController dismissViewControllerAnimated:YES completion:nil];
            IsNoInternetAppear = false;
        }
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = true;
        if (IsNoInternetAppear) {
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKAVILABLE];

            //  [self removeNoNetworkView];
            // [navController dismissViewControllerAnimated:YES completion:nil];
            IsNoInternetAppear = false;
        }
        
    }
    
}

- (void)handleNetworkChange:(NSNotification *)notice
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    // UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
    //  UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"NoInternetViewController"];
    remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        isInternet = false;
        if (!IsNoInternetAppear) {
            IsNoInternetAppear = YES;
            [[DigiCardModel sharedInstance]Hide];
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKUNAVILABLE];

            // [self addNoNetworkView];
            // [navController presentViewController:vc animated:YES completion:nil];
        }
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = true;
        if (IsNoInternetAppear) {
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKAVILABLE];
            // [self removeNoNetworkView];
            // [navController dismissViewControllerAnimated:YES completion:nil];
            IsNoInternetAppear = false;
        }
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = true;
        if (IsNoInternetAppear) {
            [[DigiCardModel sharedInstance]ViewSlideDown:NETWORKAVILABLE];
            // [self removeNoNetworkView];
            ///  [navController dismissViewControllerAnimated:YES completion:nil];
            IsNoInternetAppear = false;
        }
        
    }
    
    
}


@end
