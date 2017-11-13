//
//  Macro.h
//  Floover
//
//  Created by umenit on 11/9/16.
//  Copyright © 2016 test. All rights reserved.
//

#ifndef Macro_h
#define Macro_h
#define APPDELEGATE  ((AppDelegate *) [[UIApplication sharedApplication] delegate])
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define NSUSERDEFAULTS [NSUserDefaults standardUserDefaults]

#define APPNAME @"Digi Card"
#define APPIMAGEURL @"http://card.nmtronics.in/"

#define NETWORKUNAVILABLE @"It seems that some error in your connection. Please check your network connection and try again."
//"Some error in your Connection. Please try again."

#define NETWORKAVILABLE @"Connected to network"


#define NAVCOLR [UIColor  colorWithRed:1.0f/255.0f green:77.0f/255.0f blue:64.0f/255.0f alpha:1.0f]
#define NAVSECONDCOLOR [UIColor  colorWithRed:9.0f/255.0f green:150.0f/255.0f blue:136.0f/255.0f alpha:1.0f]
//[UIColor  colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f]
#define NAVCOLBASE [UIColor whiteColor]
#define FONT [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0f]
#define STORYBOARD @"Main"



#define FTDefaultMenuTextMargin             6.f
#define FTDefaultMenuIconMargin             6.f
#define FTDefaultAnimationDuration          0.2
#define FTDefaultTintColor                  [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.f]
#define FTDefaultMenuFont                   [UIFont fontWithName:@"HelveticaNeue" size:16.f]
#define FTDefaultMenuBorderWidth            0.8



#endif /* Macro_h */
