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

//Development key  @"AIzaSyDEYHJ1klSThJJAvKKNfuGD794SebsdyM8"

//Live Key: @"AIzaSyANQIQGZMGmYWQ4Wt6h49ll_vuSEh3l0YM"
#define NAVCOLR [UIColor  colorWithRed:255.0f/255.0f green:90.0f/255.0f blue:95.0f/255.0f alpha:1.0f]//[UIColor  colorWithRed:230.0f/255.0f green:230.0f/255.0f blue:230.0f/255.0f alpha:1.0f]
#define NAVCOLBASE [UIColor whiteColor]
#define FONT [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f]
#define STORYBOARD @"Main"


#endif /* Macro_h */
