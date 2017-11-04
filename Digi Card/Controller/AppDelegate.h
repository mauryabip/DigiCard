//
//  AppDelegate.h
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarDelegate,UITabBarControllerDelegate>{
    NSArray *tabbarray;
}

@property (strong, nonatomic) UIWindow *window;



-(void)SetNavigationBar;
@property (strong, nonatomic) UITabBarController *maintab;

@end

