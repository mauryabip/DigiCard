//
//  AppDelegate.h
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import <UIKit/UIKit.h>
#import "FTPopOverMenu.h"
#import "ChangePasswordVC.h"
#import "LoginVC.h"
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarDelegate,UITabBarControllerDelegate>{
    NSArray *tabbarray;
    
    Reachability* reachability;
    BOOL IsNoInternetAppear;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic) BOOL isInternet;
@property (nonatomic)NetworkStatus remoteHostStatus;

-(void)SetNavigationBar;
@property (strong, nonatomic) UITabBarController *maintab;

@end

