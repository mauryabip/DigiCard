//
//  ScannerVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ScannerVC.h"
@import Contacts;

@interface ScannerVC (){
    NSString *cardSideFlag;
    
    NSString *BusinessVerticalID;
    NSString *IndustrySegmentID;
    NSString *IndustryTypeID;
    NSString *PrincipleID;
    
    NSString *saveContactFlag;
    
    NSString *addressType1;
    NSString *addressType2;
    NSString *addressType3;
    NSString *addressType4;
    
    NSString *phoneNumber1;
    NSString *phoneNumber2;
    NSString *phoneNumber3;
    NSString *phoneNumber4;
    NSString *phoneNumber5;
    
    NSString *ContactTypeID;
    NSString *ManagementTypeID;
    NSString *ZoneID;
    
}

@end


@implementation ScannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    phoneNumbertype=[[NSArray alloc]init];
    phoneNumbertype=[NSUSERDEFAULTS objectForKey:@"NumberTypeMaster"];
    addresstype=@[@"Office", @"Factory", @"Residence"];
    
    
    self.ContactTypeBtn.layer.borderWidth=1.0;
    self.ContactTypeBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.ManagementTypeBtn.layer.borderWidth=1.0;
    self.ManagementTypeBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.BusinessVerticalBtn.layer.borderWidth=1.0;
    self.BusinessVerticalBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.IndustrySegmentBtn.layer.borderWidth=1.0;
    self.IndustrySegmentBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.IndustryTypeBtn.layer.borderWidth=1.0;
    self.IndustryTypeBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.PrincipleTypeBtn.layer.borderWidth=1.0;
    self.PrincipleTypeBtn.layer.borderColor=NAVCOLR.CGColor;
    
    self.ZoneTypeBtn.layer.borderWidth=1.0;
    self.ZoneTypeBtn.layer.borderColor=NAVCOLR.CGColor;
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([[DigiCardModel sharedInstance].BusinessVerticalMasterArray count]) {
        
        NSString * result = [[[[DigiCardModel sharedInstance].BusinessVerticalMasterArray valueForKey:@"BusinessVertical"] valueForKey:@"description"] componentsJoinedByString:@","];
        self.BusinessVerticalLbl.text=result;
        BusinessVerticalID=[[[[DigiCardModel sharedInstance].BusinessVerticalMasterArray valueForKey:@"BusinessVerticalID"] valueForKey:@"description"] componentsJoinedByString:@","];
        
    }else{
        self.BusinessVerticalLbl.text=@"Please Select the Business Vertical";
        BusinessVerticalID=@"";
    }
    
    
    if ([[DigiCardModel sharedInstance].IndustrySegmentMasterArray count]) {
        
        NSString * result = [[[[DigiCardModel sharedInstance].IndustrySegmentMasterArray valueForKey:@"IndustrySegment" ]valueForKey:@"description"] componentsJoinedByString:@","];
        self.IndustrySegmentLbl.text=result;
        IndustrySegmentID=[[[[DigiCardModel sharedInstance].IndustrySegmentMasterArray valueForKey:@"IndustrySegmentID" ]valueForKey:@"description"] componentsJoinedByString:@","];
    }else{
        self.IndustrySegmentLbl.text=@"Please Select the Industry Segment";
        IndustrySegmentID=@"";
        
    }
    
    
    if ([[DigiCardModel sharedInstance].IndustryTypeMasterArray count]) {
        
        NSString * result = [[[[DigiCardModel sharedInstance].IndustryTypeMasterArray valueForKey:@"IndustryType" ] valueForKey:@"description"] componentsJoinedByString:@","];
        self.IndustryTypeLbl.text=result;
        IndustryTypeID=[[[[DigiCardModel sharedInstance].IndustryTypeMasterArray valueForKey:@"IndustryTypeID" ] valueForKey:@"description"] componentsJoinedByString:@","];
    }else{
        self.IndustryTypeLbl.text=@"Please Select the Industry Type";
        IndustryTypeID=@"";
    }
    
    
    if ([[DigiCardModel sharedInstance].PrincipleMasterArray count]) {
        
        NSString * result = [[[[DigiCardModel sharedInstance].PrincipleMasterArray valueForKey:@"Principle" ]valueForKey:@"description"] componentsJoinedByString:@","];
        self.PrincipleTypeLbl.text=result;
        PrincipleID=[[[[DigiCardModel sharedInstance].PrincipleMasterArray valueForKey:@"PrincipleID" ]valueForKey:@"description"] componentsJoinedByString:@","];
        
    }else{
        self.PrincipleTypeLbl.text=@"Please Select the Principle Type";
        PrincipleID=@"";
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)moreBtnAction:(id)sender {
    
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)selectAddressLine1Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:addresstype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectAddressLine1btn setTitle:[addresstype objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                           addressType1=[addresstype objectAtIndex:selectedIndex];
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectAddressLine2Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:addresstype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectAddressLine2btn setTitle:[addresstype objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                           addressType2=[addresstype objectAtIndex:selectedIndex];
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectAddressLine3Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:addresstype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectAddressLine3btn setTitle:[addresstype objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                           addressType3=[addresstype objectAtIndex:selectedIndex];
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectAddressLine4Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:addresstype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectAddressLine4btn setTitle:[addresstype objectAtIndex:selectedIndex] forState:UIControlStateNormal];
                           addressType4=[addresstype objectAtIndex:selectedIndex];
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}


- (IBAction)selectPhonenumber1Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:[phoneNumbertype valueForKey:@"NumberType"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber1btn setTitle:[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"] forState:UIControlStateNormal];
                           phoneNumber1=[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"];
                           
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber2Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:[phoneNumbertype valueForKey:@"NumberType"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber2btn setTitle:[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"] forState:UIControlStateNormal];
                           phoneNumber2=[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"];
                           
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber3Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:[phoneNumbertype valueForKey:@"NumberType"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber3btn setTitle:[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"] forState:UIControlStateNormal];
                           phoneNumber3=[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"];
                           
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber4Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:[phoneNumbertype valueForKey:@"NumberType"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber4btn setTitle:[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"] forState:UIControlStateNormal];
                           phoneNumber4=[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"];
                           
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber5Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:[phoneNumbertype valueForKey:@"NumberType"]
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber5btn setTitle:[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"] forState:UIControlStateNormal];
                           phoneNumber5=[[phoneNumbertype objectAtIndex:selectedIndex] valueForKey:@"NumberType"];
                           
                           
                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}

-(void)OpenPopOver:(id)sender {
    configuration.menuRowHeight = 45;
    configuration.menuWidth = 120;
    configuration.textColor = [UIColor blackColor];
    configuration.textFont = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    configuration.tintColor = [UIColor whiteColor];
    configuration.borderColor = [UIColor lightGrayColor];
    configuration.borderWidth = FTDefaultMenuBorderWidth;
    configuration.textAlignment = NSTextAlignmentCenter;
    configuration.ignoreImageOriginalColor = NO;
    configuration.allowRoundedArrow = NO;
    configuration.menuTextMargin = FTDefaultMenuTextMargin;
    configuration.menuIconMargin = FTDefaultMenuIconMargin;
    configuration.animationDuration = FTDefaultAnimationDuration;
    
}



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
    else if(activeField==self.remarkTxt) {
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
    
    
    if (textField==self.ContactTypeTxt) {
        pickerArray=[[NSMutableArray alloc]init];
        [pickerArray addObjectsFromArray:[NSUSERDEFAULTS objectForKey:@"ContactTypeMaster"]];
        [self setval];
    }else if (textField==self.managementTypeTxt){
        pickerArray=[[NSMutableArray alloc]init];
        [pickerArray addObjectsFromArray:[NSUSERDEFAULTS objectForKey:@"ManagementTypeMaster"]];
        [self setval];
    }else if (textField==self.zoneTxt){
        pickerArray=[[NSMutableArray alloc]init];
        [pickerArray addObjectsFromArray:[NSUSERDEFAULTS objectForKey:@"ZoneMaster"]];
        [self setval];
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
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
    if ([self.remarkTxt isFirstResponder])
    {
        
        [self.remarkTxt resignFirstResponder];
        activeField = self.webURLtxt;
    }
    else if ([self.webURLtxt isFirstResponder])
    {
        
        [self.webURLtxt resignFirstResponder];
        activeField = self.emailId2Txt;
    }
    else if ([self.emailId2Txt isFirstResponder])
    {
        
        [self.emailId2Txt resignFirstResponder];
        activeField = self.emailIdTxt;
    }
    else if ([self.emailIdTxt isFirstResponder])
    {
        
        [self.emailIdTxt resignFirstResponder];
        activeField = self.phoneNumber5txt;
    }
    else if ([self.phoneNumber5txt isFirstResponder])
    {
        
        [self.phoneNumber5txt resignFirstResponder];
        activeField = self.phoneNumber4txt;
    }
    else if ([self.phoneNumber4txt isFirstResponder])
    {
        
        [self.phoneNumber4txt resignFirstResponder];
        activeField = self.phoneNumber3txt;
    }
    else if ([self.phoneNumber3txt isFirstResponder])
    {
        
        [self.phoneNumber3txt resignFirstResponder];
        activeField = self.phoneNumber2txt;
    }
    else if ([self.phoneNumber2txt isFirstResponder])
    {
        
        [self.phoneNumber2txt resignFirstResponder];
        activeField = self.phoneNumber1txt;
    }
    else if ([self.phoneNumber1txt isFirstResponder])
    {
        
        [self.phoneNumber1txt resignFirstResponder];
        activeField = self.postalCodetxt;
    }
    else if ([self.postalCodetxt isFirstResponder])
    {
        
        [self.postalCodetxt resignFirstResponder];
        activeField = self.addressLine4txt;
    }
    else if ([self.addressLine4txt isFirstResponder])
    {
        
        [self.addressLine4txt resignFirstResponder];
        activeField = self.addressLine3txt;
    }
    else if ([self.addressLine3txt isFirstResponder])
    {
        
        [self.addressLine3txt resignFirstResponder];
        activeField = self.addressLine2txt;
    }
    else if ([self.addressLine2txt isFirstResponder])
    {
        
        [self.addressLine2txt resignFirstResponder];
        activeField = self.addressLine1txt;
    }
    else if ([self.addressLine1txt isFirstResponder])
    {
        
        [self.addressLine1txt resignFirstResponder];
        activeField = self.companyName2Txt;
    }
    else if ([self.companyName2Txt isFirstResponder])
    {
        
        [self.companyName2Txt resignFirstResponder];
        activeField = self.companyName1Txt;
    }
    else if ([self.companyName1Txt isFirstResponder])
    {
        
        [self.companyName1Txt resignFirstResponder];
        activeField = self.designationtxt;
    }
    else if ([self.designationtxt isFirstResponder])
    {
        
        [self.designationtxt resignFirstResponder];
        activeField = self.userNameTxt;
    }
    
    [activeField becomeFirstResponder];
    
}


-(void)nextButtonClick{
    if ([self.userNameTxt isFirstResponder])
    {
        
        [self.userNameTxt resignFirstResponder];
        activeField = self.designationtxt;
    }
    else if ([self.designationtxt isFirstResponder])
    {
        
        [self.designationtxt resignFirstResponder];
        activeField = self.companyName1Txt;
    }
    else if ([self.companyName1Txt isFirstResponder])
    {
        
        [self.companyName1Txt resignFirstResponder];
        activeField = self.companyName2Txt;
    }
    else if ([self.companyName2Txt isFirstResponder])
    {
        
        [self.companyName2Txt resignFirstResponder];
        activeField = self.addressLine1txt;
    }
    else if ([self.addressLine1txt isFirstResponder])
    {
        
        [self.addressLine1txt resignFirstResponder];
        activeField = self.addressLine2txt;
    }
    else if ([self.addressLine2txt isFirstResponder])
    {
        
        [self.addressLine2txt resignFirstResponder];
        activeField = self.addressLine3txt;
    }
    else if ([self.addressLine3txt isFirstResponder])
    {
        
        [self.addressLine3txt resignFirstResponder];
        activeField = self.addressLine4txt;
    }
    else if ([self.addressLine4txt isFirstResponder])
    {
        
        [self.addressLine4txt resignFirstResponder];
        activeField = self.postalCodetxt;
    }
    else if ([self.postalCodetxt isFirstResponder])
    {
        
        [self.postalCodetxt resignFirstResponder];
        activeField = self.phoneNumber1txt;
    }
    else if ([self.phoneNumber1txt isFirstResponder])
    {
        
        [self.phoneNumber1txt resignFirstResponder];
        activeField = self.phoneNumber2txt;
    }
    else if ([self.phoneNumber2txt isFirstResponder])
    {
        
        [self.phoneNumber2txt resignFirstResponder];
        activeField = self.phoneNumber3txt;
    }
    else if ([self.phoneNumber3txt isFirstResponder])
    {
        
        [self.phoneNumber3txt resignFirstResponder];
        activeField = self.phoneNumber4txt;
    }
    else if ([self.phoneNumber4txt isFirstResponder])
    {
        
        [self.phoneNumber4txt resignFirstResponder];
        activeField = self.phoneNumber5txt;
    }
    else if ([self.phoneNumber5txt isFirstResponder])
    {
        
        [self.phoneNumber5txt resignFirstResponder];
        activeField = self.emailIdTxt;
    }
    else if ([self.emailIdTxt isFirstResponder])
    {
        
        [self.emailIdTxt resignFirstResponder];
        activeField = self.emailId2Txt;
    }
    else if ([self.emailId2Txt isFirstResponder])
    {
        
        [self.emailId2Txt resignFirstResponder];
        activeField = self.webURLtxt;
    }
    else if ([self.webURLtxt isFirstResponder])
    {
        
        [self.webURLtxt resignFirstResponder];
        activeField = self.remarkTxt;
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
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter name"];
    }
    else if(([self.designationtxt.text isEqualToString:@""]&& [self.designationtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter designation"];
    }else if(([self.companyName1Txt.text isEqualToString:@""]&& [self.companyName1Txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter company name"];
    }
    
    return valid;
}


-(BOOL)addressValidation{
    BOOL valid=YES;
     if(([self.addressLine1txt.text length]) || ([self.addressLine2txt.text length]) || ([self.addressLine3txt.text length]) || ([self.addressLine4txt.text length]))
    {
        if ([self.addressLine1txt.text length]) {
            if ([addressType1 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter address type"];
            }
        }else if ([self.addressLine2txt.text length]) {
            if ([addressType2 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter address type"];
            }
        }else if ([self.addressLine3txt.text length]) {
            if ([addressType3 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter address type"];
            }
        }else if ([self.addressLine4txt.text length]) {
            if ([addressType4 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter address type"];
            }
        }
    }else{
         valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter address"];
     }
    return valid;
}


-(BOOL)phoneNumberValidation{
    BOOL valid=YES;
    if(([self.phoneNumber1txt.text length]) || ([self.phoneNumber2txt.text length]) || ([self.phoneNumber3txt.text length]) || ([self.phoneNumber4txt.text length]) || ([self.phoneNumber5txt.text length]))
    {
        if ([self.phoneNumber1txt.text length]) {
            if([self.phoneNumber1txt.text containsString:@"+"]){
                if ([phoneNumber1 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
            
        }else if ([self.phoneNumber2txt.text length]) {
            if([self.phoneNumber2txt.text containsString:@"+"]){
                if ([phoneNumber2 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }

        }else if ([self.phoneNumber3txt.text length]) {
            if([self.phoneNumber3txt.text containsString:@"+"]){
                if ([phoneNumber3 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
        }else if ([self.phoneNumber4txt.text length]) {
            if([self.phoneNumber4txt.text containsString:@"+"]){
                if ([phoneNumber4 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }

        }else if ([self.phoneNumber5txt.text length]) {
            if([self.phoneNumber5txt.text containsString:@"+"]){
                if ([phoneNumber5 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
            
        }
    }else{
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number"];
    }
    return valid;
}


-(BOOL)emailAndOtherValidation{
    BOOL valid=YES;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];

    
    if([self.emailIdTxt.text isEqualToString:@""] && [self.emailIdTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]])
    {
        valid = NO;
        [self.emailIdTxt becomeFirstResponder];
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter email id"];
    }
    else if ([self.emailIdTxt.text length]>0) {
        if(![emailTest evaluateWithObject:self.emailIdTxt.text]){
            valid = NO;
            [self.emailIdTxt becomeFirstResponder];
            [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter valid email id"];
            
        }
    }else if(([self.webURLtxt.text isEqualToString:@""]&& [self.webURLtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter web url"];
    }else if(([ContactTypeID isEqualToString:@""]&& [ContactTypeID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select contact type"];
    }else if(([ManagementTypeID isEqualToString:@""]&& [ManagementTypeID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select management type"];
    }else if(([BusinessVerticalID isEqualToString:@""]&& [BusinessVerticalID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select business vertical"];
    }else if(([IndustrySegmentID isEqualToString:@""]&& [IndustrySegmentID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select industry segment"];
    }else if(([IndustryTypeID isEqualToString:@""]&& [IndustryTypeID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select industry type"];
    }else if(([PrincipleID isEqualToString:@""]&& [PrincipleID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select principle"];
    }else if(([ZoneID isEqualToString:@""]&& [ZoneID stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select zone"];
    }


    
       return valid;
}


-(void)OpenCamera{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //[self presentViewController:imagePicker animated:YES completion:nil];
    [self presentViewController:imagePicker animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        imagePicker.topViewController.title =  self.navigationItem.title;
        imagePicker.navigationBar.translucent = NO;
        imagePicker.navigationBar.barStyle = UIBarStyleDefault;
        
        [imagePicker setNavigationBarHidden:NO animated:NO];
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *orgimg = [info objectForKey:UIImagePickerControllerEditedImage];
    //UIImagePickerControllerOriginalImage
    //UIImage *scaledimage =[self imageWithImage:orgimg scaledToSize:CGSizeMake(100, 100)];
    UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(myImage);
    if ([cardSideFlag isEqualToString:@"Front"]) {
        self.frontCardImgView.image=[info objectForKey:UIImagePickerControllerOriginalImage];
    }
    else{
        self.backCardImgView.image=[info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
}



- (IBAction)ContactTypeBtnAction:(id)sender {
    
    
}
- (IBAction)ManagementTypeBtnAction:(id)sender {
}
- (IBAction)BusinessVerticalBtnAction:(id)sender {
    OptionVC *OptionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OptionVC"];
    OptionVC.selectedType=@"BusinessVertical";
    OptionVC.optionDataArray=[NSUSERDEFAULTS objectForKey:@"BusinessVerticalMaster"];
    [self presentViewController:OptionVC animated:YES completion:nil];
}
- (IBAction)IndustrySegmentBtnAction:(id)sender {
    OptionVC *OptionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OptionVC"];
    OptionVC.selectedType=@"IndustrySegment";
    OptionVC.optionDataArray=[NSUSERDEFAULTS objectForKey:@"IndustrySegmentMaster"];
    [self presentViewController:OptionVC animated:YES completion:nil];
}
- (IBAction)IndustryTypeBtnAction:(id)sender {
    OptionVC *OptionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OptionVC"];
    OptionVC.selectedType=@"IndustryType";
    OptionVC.optionDataArray=[NSUSERDEFAULTS objectForKey:@"IndustryTypeMaster"];
    [self presentViewController:OptionVC animated:YES completion:nil];
}
- (IBAction)PrincipleTypeBtnAction:(id)sender {
    OptionVC *OptionVC=[self.storyboard instantiateViewControllerWithIdentifier:@"OptionVC"];
    OptionVC.selectedType=@"PrincipleType";
    OptionVC.optionDataArray=[NSUSERDEFAULTS objectForKey:@"PrincipleMaster"];
    [self presentViewController:OptionVC animated:YES completion:nil];
}
- (IBAction)ZoneTypeBtnAction:(id)sender {
}
- (IBAction)saveContactAction:(UIButton*)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        saveContactFlag=@"YES";
        [self.saveContactBtn setImage:[UIImage imageNamed:@"checksquare.png"] forState:UIControlStateSelected];
    }else{
        saveContactFlag=@"";
        [self.saveContactBtn setImage:[UIImage imageNamed:@"square.png"] forState:UIControlStateNormal];
    }
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Access to contacts." message:@"This app requires access to contacts because ..." preferredStyle:UIAlertControllerStyleActionSheet];
        [alert addAction:[UIAlertAction actionWithTitle:@"Go to Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:TRUE completion:nil];
        return;
    }
}
- (IBAction)submitBtnAction:(id)sender {
    BOOL isValid=[self CheckForValidation];
    if (isValid){
        BOOL isValid=[self addressValidation];
        if (isValid){
            BOOL isValid=[self phoneNumberValidation];
            if (isValid){
                BOOL isValid=[self emailAndOtherValidation];
                if (isValid){
                    
                }
            }
        }
    }
}
- (IBAction)addFrontCardAction:(id)sender {
    cardSideFlag=@"Front";
    [self OpenCamera];
}
- (IBAction)addBackCardAction:(id)sender {
    cardSideFlag=@"";
    [self OpenCamera];
}


-(void)addContact{
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // user didn't grant access;
                // so, again, tell user here why app needs permissions in order  to do it's job;
                // this is dispatched to the main queue because this request could be running on background thread
            });
            return;
        }
        
        // create contact
        
        CNMutableContact *contact = [[CNMutableContact alloc] init];
        contact.familyName = @"Maurya";
        contact.givenName = @"Bipin";
        
        CNLabeledValue *homePhone = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:@"312-555-1212"]];
        contact.phoneNumbers = @[homePhone];
        
        CNSaveRequest *request = [[CNSaveRequest alloc] init];
        [request addContact:contact toContainerWithIdentifier:nil];
        
        // save it
        
        NSError *saveError;
        if (![store executeSaveRequest:request error:&saveError]) {
            NSLog(@"error = %@", saveError);
        }
    }];
}

-(void)setval
{
    
    myPickerView = [[UIPickerView alloc]init];
    myPickerView.dataSource = self;
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    
    myPickerView.backgroundColor=NAVSECONDCOLOR;

    _inputAccViewforsearch = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREENWIDTH, 44.0)];
    [_inputAccViewforsearch setBackgroundColor:[UIColor whiteColor]];
    [_inputAccViewforsearch setAlpha: 1.0];
    
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _searchone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donepicker)];
    [_keyboardToolbarforsearch removeFromSuperview];
    _keyboardToolbarforsearch = [[UIToolbar alloc] init];
    _keyboardToolbarforsearch.frame = CGRectMake(0.0, 0.0, SCREENWIDTH, 44.0);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH-100, 44)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.textColor=NAVCOLR;
    if (activeField==self.ContactTypeTxt) {
        titleLabel.text = @"Select Contact Type";
    }else if (activeField==self.managementTypeTxt){
        titleLabel.text = @"Select Management Type";
    }else{
        titleLabel.text = @"Select Zone Type";
    }
    
    
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Medium" size:16]];
   
    UIBarButtonItem *title = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
   
    _keyboardToolbarforsearch.items = [NSArray arrayWithObjects:spacer,_searchone,title, nil];
    [_keyboardToolbarforsearch setBarStyle:UIBarStyleDefault];
    [_keyboardToolbarforsearch setBackgroundColor:[UIColor clearColor]];
    
    [_inputAccViewforsearch addSubview:_keyboardToolbarforsearch];
    activeField.inputView = myPickerView;
    activeField.inputAccessoryView = _inputAccViewforsearch;
    
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}

#pragma mark- Picker View Delegate

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title;
    if (activeField==self.ContactTypeTxt) {
        title= [[pickerArray valueForKey:@"ContactType"]objectAtIndex:row];
    }else if (activeField==self.managementTypeTxt){
        title= [[pickerArray valueForKey:@"ManagementType"]objectAtIndex:row];
    }else{
        title= [[pickerArray valueForKey:@"ZoneName"]objectAtIndex:row];
    }
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (activeField==self.ContactTypeTxt) {
        [self.ContactTypeBtn setTitle:[[pickerArray valueForKey:@"ContactType"]objectAtIndex:row] forState:UIControlStateNormal];
        ContactTypeID=[[pickerArray valueForKey:@"ContactTypeID"]objectAtIndex:row];
    }else if (activeField==self.managementTypeTxt){
        [self.ManagementTypeBtn setTitle:[[pickerArray valueForKey:@"ManagementType"]objectAtIndex:row] forState:UIControlStateNormal];
        ManagementTypeID=[[pickerArray valueForKey:@"ManagementTypeID"]objectAtIndex:row];
        
    }else if (activeField==self.zoneTxt){
        [self.ZoneTypeBtn setTitle:[[pickerArray valueForKey:@"ZoneName"]objectAtIndex:row] forState:UIControlStateNormal];
        ZoneID=[[pickerArray valueForKey:@"ZoneID"]objectAtIndex:row];
        
        
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (activeField==self.ContactTypeTxt) {
        return [[pickerArray valueForKey:@"ContactType"]objectAtIndex:row];
    }else if (activeField==self.managementTypeTxt){
        return [[pickerArray valueForKey:@"ManagementType"]objectAtIndex:row];
    }else{
        return [[pickerArray valueForKey:@"ZoneName"]objectAtIndex:row];
    }
    
}
-(void)donepicker
{
    myPickerView.hidden=YES;
    [activeField resignFirstResponder];
}

@end
