//
//  DigiCardModel.h
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "HHAlertView.h"
#import "HDNotificationView.h"

@interface DigiCardModel : NSObject

@property (strong,nonatomic) NSDictionary  *NumberTypeMasterDic;
@property (strong,nonatomic) NSDictionary  *PrincipleMasterDic;
@property (strong,nonatomic) NSDictionary  *BusinessVerticalMasterDic;
@property (strong,nonatomic) NSDictionary  *IndustryTypeMasterDic;
@property (strong,nonatomic) NSDictionary  *IndustrySegmentMasterDic;
@property (strong,nonatomic) NSDictionary  *TitleMasterDic;
@property (strong,nonatomic) NSDictionary  *ZoneMasterDic;
@property (strong,nonatomic) NSDictionary  *ManagementTypeMasterDic;
@property (strong,nonatomic) NSDictionary  *ContactTypeMasterDic;
@property (strong,nonatomic) NSDictionary  *TierMasterDic;

@property (strong,nonatomic) NSString  *customerList;


+(DigiCardModel*)sharedInstance;
-(BOOL)Isnetweork;
-(id)Storyboard :(NSString*)ControllerId;


-(void)show;
-(void)Hide;

- (MBProgressHUD *)ShowWaiting:(NSString *)title ;
- (MBProgressHUD *)ShowWaitingforDirection:(NSString *)title ;
- (MBProgressHUD *)ShowWaitingLongtime:(NSString *)title ;
- (void)HideWaiting ;


-(void)ViewSlideDown:(NSString*)Message;
- (void)errorWithTitle:(NSString*)title detailMessage:(NSString*)detail view:(UIView*)view;
- (void)success:(NSString*)title detailMessage:(NSString*)detail view:(UIView*)view;


@end
