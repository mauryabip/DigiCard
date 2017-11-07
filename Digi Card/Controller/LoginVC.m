//
//  LoginVC.m
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import "LoginVC.h"
#import "ForgotPasswordVC.h"

@interface LoginVC ()<UITextFieldDelegate>{
    UITextField* activeField;
    UIView *inputAccessoryView;
    UIButton *Done;
    UIButton *Privious;
    UIButton *Next;
    NSString *nextBtnName;
    NSString *previousBtnName;
}
@property (strong, nonatomic) IBOutlet UITextField *userNameTxt;
@property (strong, nonatomic) IBOutlet UITextField *passwordTxt;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation LoginVC

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
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginAction:(id)sender {
    
    //    BOOL isValid=[self CheckForValidation];
    //    if (isValid){
    //
    //    }
    [[DigiCardModel sharedInstance]ShowWaitingLongtime:@""];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSTimeInterval  today = [[NSDate date] timeIntervalSince1970];
    NSString *intervalString = [NSString stringWithFormat:@"%f", today];
    [[BaseManager sharedInstance]AppUserLogin:@"super" Password:@"cfcs" AuthCode:intervalString ClientVersion:appVersion withCallback:^(NSDictionary *response) {
        
        NSLog(@"%@",[response objectForKey:@"MsgNotification"]);
        
        NSString *statusValue=[response objectForKey:@"status"];
        if ([statusValue isEqualToString:@"failed"]) {
            [[DigiCardModel sharedInstance]HideWaiting];
            [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
        }
        else{
            [NSUSERDEFAULTS setObject:@"1" forKey:@"Status"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"AuthCode"] forKey:@"AuthCode"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"EmailID"] forKey:@"EmailID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"MobileNo"] forKey:@"UserMobileNumber"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"Name"] forKey:@"Name"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"RoleID"] forKey:@"UserRoleID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"UserID"] forKey:@"UserUserID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"RoleName"] forKey:@"UserRoleNameUserType"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"ZoneID"] forKey:@"UserZoneID"];
            [NSUSERDEFAULTS setObject:[response objectForKey:@"ZoneName"] forKey:@"UserZoneName"];
            
            [NSUSERDEFAULTS synchronize];
            
            [self AppddlList:[response objectForKey:@"AuthCode"] UserID:[response objectForKey:@"UserID"]];
            
        }
        
    }];
    
    
}

-(void)AppddlList:(NSString*)authCode UserID:(NSString*)UserID{
    
    [[BaseManager sharedInstance]AppddlList:authCode UserID:UserID withCallback:^(NSDictionary *response) {
        [[DigiCardModel sharedInstance]HideWaiting];
        
        NSString *statusValue=[response objectForKey:@"status"];
        if ([statusValue isEqualToString:@"failed"]) {
            [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
        }
        else{
            
            [DigiCardModel sharedInstance].NumberTypeMasterDic=[response objectForKey:@"NumberTypeMaster"];
            [DigiCardModel sharedInstance].PrincipleMasterDic=[response objectForKey:@"PrincipleMaster"];
            [DigiCardModel sharedInstance].BusinessVerticalMasterDic=[response objectForKey:@"BusinessVerticalMaster"];
            [DigiCardModel sharedInstance].IndustryTypeMasterDic=[response objectForKey:@"IndustryTypeMaster"];
            [DigiCardModel sharedInstance].IndustrySegmentMasterDic=[response objectForKey:@"IndustrySegmentMaster"];
            [DigiCardModel sharedInstance].TitleMasterDic=[response objectForKey:@"TitleMaster"];
            [DigiCardModel sharedInstance].ZoneMasterDic=[response objectForKey:@"ZoneMaster"];
            [DigiCardModel sharedInstance].ManagementTypeMasterDic=[response objectForKey:@""];
            [DigiCardModel sharedInstance].ContactTypeMasterDic=[response objectForKey:@"ContactTypeMaster"];
            [DigiCardModel sharedInstance].TierMasterDic=[response objectForKey:@"TierMaster"];
            
            [[DigiCardModel sharedInstance]success:APPNAME detailMessage:@"Successfully Logged in!" view:self.view];
            
            [self performSelector:@selector(GotoScannerScreen) withObject:nil afterDelay:2.0000];
        }
        
    }];
}
-(void)GotoScannerScreen{
    [APPDELEGATE SetNavigationBar];
    [APPDELEGATE.maintab setSelectedIndex:1];
    [[APPDELEGATE.maintab.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:YES];
}

- (IBAction)forgotPassAction:(id)sender {
    ForgotPasswordVC *ForgotPasswordVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:ForgotPasswordVC animated:YES];
}
- (IBAction)tabGestureAction:(id)sender {
    [self.view endEditing:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


#pragma mark UITextFieldDelegate methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location == 0 && [string isEqualToString:@" "]) {
        return NO;
    }
    
    if([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    activeField=textField;
    
    if (activeField==self.userNameTxt) {
        Privious.userInteractionEnabled=NO;
        Next.userInteractionEnabled=YES;
        nextBtnName=@"nextk.png";
        previousBtnName=@"previousDisable.png";
    }
    else if(activeField==self.passwordTxt) {
        nextBtnName=@"nextDisable.png";
        previousBtnName=@"previous.png";
        Privious.userInteractionEnabled=YES;
        Next.userInteractionEnabled=NO;
    }
    else{
        nextBtnName=@"nextk.png";
        previousBtnName=@"previous.png";
        Privious.userInteractionEnabled=YES;
        Next.userInteractionEnabled=YES;
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 265.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    [textField setInputAccessoryView:[self inputAccessoryViews]];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (!self.passwordTxt.hasText) {
        // self.showhideBtn.hidden=YES;
    }
    
    activeField=nil;
    
}

#pragma mark - inputAccessoryViews & Delegate

- (UIView *)inputAccessoryViews {
    
    CGRect accessFrame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 40.0);
    inputAccessoryView = [[UIView alloc] initWithFrame:accessFrame];
    inputAccessoryView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    
    Privious = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Privious.frame = CGRectMake(5.0 , 8.0, 24.0, 24.0);
    [Privious setImage:[UIImage imageNamed:previousBtnName] forState:UIControlStateNormal];
    if ([previousBtnName isEqualToString:@"previous.png"])
        [Privious setTintColor:[UIColor blueColor]];
    else
        [Privious setTintColor:[UIColor lightGrayColor]];
    [Privious addTarget:self action:@selector(previousButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:Privious];
    
    
    Next = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Next.frame = CGRectMake(50.0 , 8.0, 24.0, 24.0);
    [Next setImage:[UIImage imageNamed:nextBtnName] forState:UIControlStateNormal];
    if ([nextBtnName isEqualToString:@"nextk.png"])
        [Next setTintColor:[UIColor blueColor]];
    else
        [Next setTintColor:[UIColor lightGrayColor]];
    [Next addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:Next];
    
    
    
    Done = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    Done.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -[UIScreen mainScreen].bounds.size.width/5 , 5.0, [UIScreen mainScreen].bounds.size.width/5, 30.0);
    [Done setTitle: @"Done" forState:UIControlStateNormal];
    [Done setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    Done.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [Done addTarget:self action:@selector(DoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:Done];
    
    return inputAccessoryView;
}
-(void)DoneButtonClick{
    
    activeField=nil;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    
    [self.view endEditing:YES];
}
-(void)previousButtonClick{
    if ([self.passwordTxt isFirstResponder])
    {
        
        [_passwordTxt resignFirstResponder];
        activeField = self.userNameTxt;
    }
    
    [activeField becomeFirstResponder];
    
    
}
-(void)nextButtonClick{
    if ([self.userNameTxt isFirstResponder])
    {
        
        [self.userNameTxt resignFirstResponder];
        activeField = self.passwordTxt;
    }
    
    [activeField becomeFirstResponder];
    
}


#pragma mark - Validation Method
-(BOOL)CheckForValidation
{
    BOOL valid=YES;
    
    if([self.userNameTxt.text isEqualToString:@""] && [self.userNameTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]])
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter user name"];
    }
    else if(([self.passwordTxt.text isEqualToString:@""]&& [self.passwordTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter password"];
    }
    
    return valid;
}

/*
 
 {
 "NumberTypeMaster": [
 {
 "NumberType": "Home"
 },
 {
 "NumberType": "Home Fax"
 },
 {
 "NumberType": "Main"
 },
 {
 "NumberType": "Mobile No"
 },
 {
 "NumberType": "Work"
 },
 {
 "NumberType": "Work Fax"
 }
 ],
 "PrincipleMaster": [
 {
 "PrincipleID": 7,
 "Principle": "ANDA"
 },
 {
 "PrincipleID": 13,
 "Principle": "BOFA"
 },
 {
 "PrincipleID": 15,
 "Principle": "CIRCUIT MASTER"
 },
 {
 "PrincipleID": 11,
 "Principle": "DIC"
 },
 {
 "PrincipleID": 10,
 "Principle": "EUROPLASMA"
 },
 {
 "PrincipleID": 1,
 "Principle": "FUJI"
 },
 {
 "PrincipleID": 8,
 "Principle": "INERTEC"
 },
 {
 "PrincipleID": 2,
 "Principle": "ITWEAE"
 },
 {
 "PrincipleID": 6,
 "Principle": "JT ELECTRONICS"
 },
 {
 "PrincipleID": 3,
 "Principle": "KOH YOUNG"
 },
 {
 "PrincipleID": 4,
 "Principle": "MENTOR"
 },
 {
 "PrincipleID": 9,
 "Principle": "TANAC"
 },
 {
 "PrincipleID": 14,
 "Principle": "THINKY"
 },
 {
 "PrincipleID": 12,
 "Principle": "VISION ENGINEERING"
 },
 {
 "PrincipleID": 5,
 "Principle": "YJ LINK"
 }
 ],
 "BusinessVerticalMaster": [
 {
 "BusinessVerticalID": 5,
 "BusinessVertical": "ACADEMY"
 },
 {
 "BusinessVerticalID": 4,
 "BusinessVertical": "AUTOMATION"
 },
 {
 "BusinessVerticalID": 1,
 "BusinessVertical": "SMT"
 },
 {
 "BusinessVerticalID": 2,
 "BusinessVertical": "Solar"
 },
 {
 "BusinessVerticalID": 3,
 "BusinessVertical": "SOLAR"
 }
 ],
 "IndustryTypeMaster": [
 {
 "IndustryTypeID": 1,
 "IndustryType": "Industry 1"
 }
 ],
 "IndustrySegmentMaster": [
 {
 "IndustrySegmentID": 1,
 "IndustrySegment": "Segment 1"
 },
 {
 "IndustrySegmentID": 2,
 "IndustrySegment": "Segment 2"
 }
 ],
 "TitleMaster": [
 {
 "TitleID": 1,
 "TitleName": ""
 },
 {
 "TitleID": 2,
 "TitleName": "Mr."
 },
 {
 "TitleID": 3,
 "TitleName": "Ms."
 },
 {
 "TitleID": 4,
 "TitleName": "Mrs."
 },
 {
 "TitleID": 5,
 "TitleName": "M/S"
 }
 ],
 "ZoneMaster": [
 {
 "ZoneID": 4,
 "ZoneName": "East"
 },
 {
 "ZoneID": 2,
 "ZoneName": "North"
 },
 {
 "ZoneID": 3,
 "ZoneName": "South"
 }
 ],
 "ManagementTypeMaster": [
 {
 "ManagementTypeID": 3,
 "ManagementType": "Junior Level"
 },
 {
 "ManagementTypeID": 2,
 "ManagementType": "Middle Level"
 },
 {
 "ManagementTypeID": 1,
 "ManagementType": "Top Level"
 }
 ],
 "ContactTypeMaster": [
 {
 "ContactTypeID": 1,
 "ContactType": "Contact Type 1"
 },
 {
 "ContactTypeID": 2,
 "ContactType": "Contact Type 2"
 }
 ],
 "TierMaster": [
 {
 "TierID": 1,
 "Tier": "Tier 1"
 },
 {
 "TierID": 2,
 "Tier": "Tier 2"
 }
 ]
 }
 */

@end
