//
//  MyProfileVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "MyProfileVC.h"

@interface MyProfileVC ()
@property (strong, nonatomic) IBOutlet UITextField *nameTxt;
@property (strong, nonatomic) IBOutlet UITextField *designationTxt;
@property (strong, nonatomic) IBOutlet UITextField *phoneTxt;
@property (strong, nonatomic) IBOutlet UITextField *emailTxt;

@end

@implementation MyProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    [self updateData];
    
    NSString *AuthCode=[NSUSERDEFAULTS objectForKey:@"AuthCode"];
    NSString *UserID=[NSUSERDEFAULTS objectForKey:@"UserUserID"];
    [self getUserDetail:AuthCode UserID:UserID];
}

-(void)updateData{
    NSString *UserNameStr=[NSUSERDEFAULTS objectForKey:@"Name"];
    NSString *UserMobileNumber=[NSUSERDEFAULTS objectForKey:@"UserMobileNumber"];
    NSString *UserEmailID=[NSUSERDEFAULTS objectForKey:@"EmailID"];
    NSString *UserRoleNameUserType=[NSUSERDEFAULTS objectForKey:@"UserRoleNameUserType"];
    
    self.nameTxt.text=UserNameStr;
    self.designationTxt.text=UserRoleNameUserType;
    self.phoneTxt.text=UserMobileNumber;
    self.emailTxt.text=UserEmailID;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moreBtnAction:(id)sender {
    
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    
    configuration.menuRowHeight = 45;
    configuration.menuWidth = 160;
    configuration.textColor = [UIColor whiteColor];
    configuration.textFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.f];
    configuration.tintColor = FTDefaultTintColor;
    configuration.borderColor = FTDefaultTintColor;
    configuration.borderWidth = FTDefaultMenuBorderWidth;
    configuration.textAlignment = NSTextAlignmentCenter;
    configuration.ignoreImageOriginalColor = NO;
    configuration.allowRoundedArrow = NO;
    configuration.menuTextMargin = FTDefaultMenuTextMargin;
    configuration.menuIconMargin = FTDefaultMenuIconMargin;
    configuration.animationDuration = FTDefaultAnimationDuration;
    
    NSArray *statustype=@[@"Change Password",  @"Logout"];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:statustype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           if (selectedIndex==0) {
                               ChangePasswordVC *ChangePasswordVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordVC"];
                               [self.navigationController pushViewController:ChangePasswordVC animated:YES];
                           }else{
                               [NSUSERDEFAULTS setObject:@"0" forKey:@"Status"];
                               [NSUSERDEFAULTS synchronize];
                               
                               UINavigationController *controller = (UINavigationController*)[self.storyboard instantiateViewControllerWithIdentifier: @"RootNavigationController"];
                               
                               LoginVC *LoginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
                               [controller setViewControllers:[NSArray arrayWithObject:LoginVC] animated:YES];
                               APPDELEGATE.window.rootViewController=controller;
                           }
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
    
}

-(void)getUserDetail:(NSString*)authCode UserID:(NSString*)UserID{
    
    [[BaseManager sharedInstance]AppUserDetail:authCode UserID:UserID withCallback:^(NSDictionary *response) {
        
        NSString *statusValue=[response objectForKey:@"status"];
        if ([statusValue isEqualToString:@"failed"]) {
            [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
        }
        else{
            
            [NSUSERDEFAULTS setObject:[response objectForKey:@"EmailID"] forKey:@"EmailID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"MobileNo"] forKey:@"UserMobileNumber"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"Name"] forKey:@"Name"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"RoleID"] forKey:@"UserRoleID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"UserID"] forKey:@"UserUserID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"UserType"] forKey:@"UserRoleNameUserType"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"UserName"] forKey:@"UserName"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"Password"] forKey:@"UserPassword"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"LastUpdate"] forKey:@"UserLastUpdate"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"OtherMobileNo1"] forKey:@"UserOtherMobileNo1"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"Active"] forKey:@"UserActive"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"Theme"] forKey:@"UserTheme"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"DesiName"] forKey:@"UserDesiName"];
            
            [NSUSERDEFAULTS synchronize];
            [self updateData];
            
        }
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
