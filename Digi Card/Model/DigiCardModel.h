//
//  DigiCardModel.h
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface DigiCardModel : NSObject


+(DigiCardModel*)sharedInstance;
-(BOOL)Isnetweork;
-(id)Storyboard :(NSString*)ControllerId;
@end
