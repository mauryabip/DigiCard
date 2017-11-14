//
//  ScannerVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ScannerVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

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
    
    NSMutableArray *phoneNumberArray;
    
    NSString *frontImgBase64;
    NSString *backImgBase64;
    
    NSString *frontImgName;
    NSString *backImgName;
    
    
}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end


@implementation ScannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    
    BusinessVerticalID=@"";
    IndustrySegmentID=@"";
    IndustryTypeID=@"";
    PrincipleID=@"";
    
    saveContactFlag=@"";
    
    addressType1=@"";
    addressType2=@"";
    addressType3=@"";
    addressType4=@"";
    
    phoneNumber1=@"";
    phoneNumber2=@"";
    phoneNumber3=@"";
    phoneNumber4=@"";
    phoneNumber5=@"";
    
    ContactTypeID=@"";
    ManagementTypeID=@"";
    ZoneID=@"";
    
    frontImgBase64=@"";
    backImgBase64=@"";
    
//    NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"Sample.jpg"]);
//    
//    backImgBase64=frontImgBase64=[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
  
    
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    //[self recognizeImageWithTesseract:[UIImage imageNamed:@"Sample.jpg"]];
    
    _frontCardViewHTConst.constant=50;
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
    [self.view endEditing:YES];
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
        activeField = self.addressLine3txt;
    }
    //    else if ([self.postalCodetxt isFirstResponder])
    //    {
    //
    //        [self.postalCodetxt resignFirstResponder];
    //        activeField = self.addressLine4txt;
    //    }
    //    else if ([self.addressLine4txt isFirstResponder])
    //    {
    //
    //        [self.addressLine4txt resignFirstResponder];
    //        activeField = self.addressLine3txt;
    //    }
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
        activeField = self.phoneNumber1txt;
    }
    //    else if ([self.addressLine4txt isFirstResponder])
    //    {
    //
    //        [self.addressLine4txt resignFirstResponder];
    //        activeField = self.postalCodetxt;
    //    }
    //    else if ([self.postalCodetxt isFirstResponder])
    //    {
    //
    //        [self.postalCodetxt resignFirstResponder];
    //        activeField = self.phoneNumber1txt;
    //    }
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
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select address type"];
            }
        }else if ([self.addressLine2txt.text length]) {
            if ([addressType2 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select address type"];
            }
        }else if ([self.addressLine3txt.text length]) {
            if ([addressType3 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select address type"];
            }
        }else if ([self.addressLine4txt.text length]) {
            if ([addressType4 length]==0) {
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select address type"];
            }
        }else  if([addressType1 isEqualToString:addressType2] || [addressType1 isEqualToString:addressType3]) {
            valid = NO;
            [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select diffrent address type"];
            
        }else if([addressType2 isEqualToString:addressType3]) {
            valid = NO;
            [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select diffrent address type"];
            
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
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
            
        }else if ([self.phoneNumber2txt.text length]) {
            if([self.phoneNumber2txt.text containsString:@"+"]){
                if ([phoneNumber2 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
            
        }else if ([self.phoneNumber3txt.text length]) {
            if([self.phoneNumber3txt.text containsString:@"+"]){
                if ([phoneNumber3 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter select number with + sign"];
            }
        }else if ([self.phoneNumber4txt.text length]) {
            if([self.phoneNumber4txt.text containsString:@"+"]){
                if ([phoneNumber4 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select phone number type"];
                }
            }else{
                valid = NO;
                [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter phone number with + sign"];
            }
            
        }else if ([self.phoneNumber5txt.text length]) {
            if([self.phoneNumber5txt.text containsString:@"+"]){
                if ([phoneNumber5 length]==0) {
                    valid = NO;
                    [[DigiCardModel sharedInstance] ViewSlideDown:@"Please select phone number type"];
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
    }else if(([frontImgBase64 isEqualToString:@""]&& [frontImgBase64 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please add front image of card"];
    }
    else if ([self.emailIdTxt.text length]>0) {
        if(![emailTest evaluateWithObject:self.emailIdTxt.text]){
            valid = NO;
            [self.emailIdTxt becomeFirstResponder];
            [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter valid email id"];
            
        }
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
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    
    if ([cardSideFlag isEqualToString:@"Front"]) {
        [[DigiCardModel sharedInstance]show];
        self.frontCardImgView.image=[info objectForKey:UIImagePickerControllerEditedImage];
        frontImgBase64=[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        self.frontCardImgView.contentMode = UIViewContentModeScaleToFill;
        self.frontCardImgView.clipsToBounds = YES;
        [self recognizeImageWithTesseract:chosenImage];
        
    }
    else{
        _frontCardViewHTConst.constant=205;
        self.backCardImgView.image=[info objectForKey:UIImagePickerControllerEditedImage];
        backImgBase64=[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
                    [self addCardDetails];
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
        contact.contactType = CNContactTypePerson;
        
        
        NSArray *arrayWithTwoStrings = [self.userNameTxt.text componentsSeparatedByString:@" "];
        contact.givenName=[arrayWithTwoStrings objectAtIndex:0];
        
        if (arrayWithTwoStrings.count>1) {
            
            NSString *userLastName;
            for (NSString *LastName in arrayWithTwoStrings) {
                userLastName=[userLastName stringByAppendingString:LastName];
            }
            contact.familyName =userLastName;
            
        }
        
        
        CNLabeledValue *homePhone_1 = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:self.phoneNumber1txt.text]];
        CNLabeledValue * homePhone_2 = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:[CNPhoneNumber phoneNumberWithStringValue:self.phoneNumber2txt.text]];
        CNLabeledValue *homePhone_3 = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:self.phoneNumber3txt.text]];
        CNLabeledValue * homePhone_4 = [CNLabeledValue labeledValueWithLabel:CNLabelWork value:[CNPhoneNumber phoneNumberWithStringValue:self.phoneNumber4txt.text]];
        CNLabeledValue *homePhone_5 = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:self.phoneNumber5txt.text]];
        contact.phoneNumbers = @[homePhone_1, homePhone_2,homePhone_3,homePhone_4,homePhone_5];
        
        
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
    
    
    if (activeField==self.ContactTypeTxt) {
        [self.ContactTypeBtn setTitle:[[pickerArray valueForKey:@"ContactType"]objectAtIndex:0] forState:UIControlStateNormal];
        ContactTypeID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ContactTypeID"]objectAtIndex:0]];
    }else if (activeField==self.managementTypeTxt){
        [self.ManagementTypeBtn setTitle:[[pickerArray valueForKey:@"ManagementType"]objectAtIndex:0] forState:UIControlStateNormal];
        ManagementTypeID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ManagementTypeID"]objectAtIndex:0]];
        
    }else if (activeField==self.zoneTxt){
        [self.ZoneTypeBtn setTitle:[[pickerArray valueForKey:@"ZoneName"]objectAtIndex:0] forState:UIControlStateNormal];
        ZoneID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ZoneID"]objectAtIndex:0]];
        
    }
    
    
    return attString;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (activeField==self.ContactTypeTxt) {
        [self.ContactTypeBtn setTitle:[[pickerArray valueForKey:@"ContactType"]objectAtIndex:row] forState:UIControlStateNormal];
        ContactTypeID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ContactTypeID"]objectAtIndex:row]];
    }else if (activeField==self.managementTypeTxt){
        [self.ManagementTypeBtn setTitle:[[pickerArray valueForKey:@"ManagementType"]objectAtIndex:row] forState:UIControlStateNormal];
        ManagementTypeID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ManagementTypeID"]objectAtIndex:row]];
        
    }else if (activeField==self.zoneTxt){
        [self.ZoneTypeBtn setTitle:[[pickerArray valueForKey:@"ZoneName"]objectAtIndex:row] forState:UIControlStateNormal];
        ZoneID=[NSString stringWithFormat:@"%@",[[pickerArray valueForKey:@"ZoneID"]objectAtIndex:row]];
        
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


//Scan Card Functionality
-(void)recognizeImageWithTesseract:(UIImage *)image
{
    // Animate a progress activity indicator
    [self.activityIndicator startAnimating];
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = image;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        NSLog(@"%@", recognizedText);
        
        if (recognizedText.length>50)
            [self GetDataFromImageString:recognizedText];
        
        // Remove the animated progress activity indicator
        [self.activityIndicator stopAnimating];
        
        [[DigiCardModel sharedInstance]Hide];
        // Spawn an alert with the recognized text
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Scan Result"
                                                        message:recognizedText
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:@"Rescan",nil];
        
        [alert show];
    };
    
    // Display the image to be recognized in the view
    //self.imageToRecognize.image = operation.tesseract.thresholdedImage;
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can observe the progress.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 */
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can cancel the recogntion
 *  prematurely if necessary.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 *
 *  @return Whether or not to cancel the recognition.
 */
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to cancel recognition prematurely
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1) {
        [self OpenCamera];
    }
}




-(void)GetDataFromImageString:(NSString*)string{
    
    NSMutableArray *PinCodeArray=[[NSMutableArray alloc]init];
    NSMutableArray *addressArray=[[NSMutableArray alloc]init];
    NSMutableArray *emailURLArray=[[NSMutableArray alloc]init];
    phoneNumberArray=[[NSMutableArray alloc]init];
    
    NSError *error = nil;
    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber
                                                                   error:&error];
    [dataDetector enumerateMatchesInString:string
                                   options:0
                                     range:NSMakeRange(0, string.length)
                                usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         NSString *numberWithExtra = result.phoneNumber;
         NSCharacterSet *toRemove = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
         NSString *trimmed = [[numberWithExtra componentsSeparatedByCharactersInSet:toRemove] componentsJoinedByString:@""];
         if(trimmed && trimmed.length)
         {
             NSLog(@"Phone %@", trimmed);
             NSString * firstLetter = [trimmed substringToIndex:1];
             if (![firstLetter isEqualToString:@"+"]) {
                 trimmed=[NSString stringWithFormat:@"+%@",trimmed];
             }
             [phoneNumberArray addObject:trimmed];
         }
         else
         {
             NSLog(@"No phone number");
         }
     }];
    
    
    NSDataDetector * dataDetector1 = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:nil];
    [dataDetector1 enumerateMatchesInString:string
                                    options:0
                                      range:NSMakeRange(0, string.length)
                                 usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
     {
         NSString *numberWithExtra = [result.URL absoluteString];
         numberWithExtra=[numberWithExtra stringByReplacingOccurrencesOfString:@"mailto:" withString:@""];
         NSLog(@"email&URL  %@  ", [numberWithExtra stringByRemovingPercentEncoding]);
         [emailURLArray addObject:[numberWithExtra stringByRemovingPercentEncoding]];
         
     }];
    
    
    
    // NSTextCheckingCityKey  NSTextCheckingTypeSpelling
    NSDataDetector* detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress error:nil];
    NSArray* matches = [detector matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for(NSTextCheckingResult* match in matches)
    {
        if(match.resultType == NSTextCheckingTypeAddress)
        {
            NSDictionary* addressComponents = [match addressComponents];
            NSLog(@"Address Dictionary:%@", addressComponents);
        }
    }
    
    //Retrieving Numbers in array
    NSMutableArray* numberArray = [NSMutableArray new];
    
    NSString* regexPattern = @"\\d+";
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:regexPattern options:0 error:nil];
    
    NSArray* matches1 = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for( NSTextCheckingResult* match in matches1) {
        NSString* strNumber = [string substringWithRange:match.range];
        [numberArray addObject:[NSNumber numberWithInt:strNumber.intValue]];
    }
    
    //Retrieving Pin Code in array and adresses
    
    for (NSString *pin in numberArray) {
        NSString* pinStr=[NSString stringWithFormat:@"%@",pin];
        NSString *pinRegex = @"^[0-9]{6}$";
        NSPredicate *pinTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
        BOOL pinValidates = [pinTest evaluateWithObject:pinStr];
        if (pinValidates) {
            [PinCodeArray addObject:pinStr];
            
            if (PinCodeArray.count==1) {
                NSArray *arrayWithTwoStrings = [string componentsSeparatedByString:pinStr];
                NSString *addrStr=[arrayWithTwoStrings objectAtIndex:0];
                NSInteger textCount=addrStr.length;
                if (addrStr.length>50) {
                    textCount=50;
                }
                NSString* addressText=[NSString stringWithFormat:@"%@ %@",[addrStr substringFromIndex:[addrStr length]-textCount],pinStr];
                [addressArray addObject:addressText];
            }
            
        }
        
    }
    if ([PinCodeArray count]>1) {
        for (int i=0; i<[PinCodeArray count]-1; i++) {
            NSRange searchFromRange = [string rangeOfString:[PinCodeArray objectAtIndex:i]];
            NSRange searchToRange = [string rangeOfString:[PinCodeArray objectAtIndex:i+1]];
            NSString *substring = [string substringWithRange:NSMakeRange(searchFromRange.location+searchFromRange.length, searchToRange.location-searchFromRange.location-searchFromRange.length)];
            NSString* addressText=[NSString stringWithFormat:@"%@ %@",substring,[PinCodeArray objectAtIndex:i+1]];
            [addressArray addObject:addressText];
            
        }
        
    }
    
    [G8Tesseract clearCache];
    
    NSLog(@"Addresses : %@",addressArray);
    NSLog(@"Email URL : %@",emailURLArray);
    NSLog(@"Phone Numbers  : %@",phoneNumberArray);
    
    NSRange searchToRange = [string rangeOfString:@"\n"];
    NSString *nameStr = [string substringWithRange:NSMakeRange(0, searchToRange.location)];
    self.userNameTxt.text=nameStr;//[string substringToIndex:15];
    //Designation
    //Company name
    [self CompanyNameCheck:string];
    
    if ([string containsString:@"PVT."] || [string containsString:@"LTD."] || [string containsString:@"LTD"] ||
        [string containsString:@"S.r.l."] || [string containsString:@"eurl"] || [string containsString:@"GbR"] ||
        [string containsString:@"GmbH"] || [string containsString:@"inc"] || [string containsString:@"LLC"] ||
        [string containsString:@"LLP"] || [string containsString:@"Ltd"] || [string containsString:@"Srl"]||
        [string containsString:@"Corp"] || [string containsString:@"Ltd."] || [string containsString:@"Inc."] ||
        [string containsString:@"Co,LTD."]){
        
    }
    
    if (addressArray.count>0) {
        self.addressLine1txt.text=[addressArray objectAtIndex:0];
        if (addressArray.count>1) {
            self.addressLine2txt.text=[addressArray objectAtIndex:1];
            if (addressArray.count>2) {
                self.addressLine3txt.text=[addressArray objectAtIndex:2];
                if (addressArray.count>3) {
                    self.addressLine4txt.text=[addressArray objectAtIndex:3];
                }
            }
        }
    }
    
    if (phoneNumberArray.count>0) {
        self.phoneNumber1txt.text=[phoneNumberArray objectAtIndex:0];
        if (phoneNumberArray.count>1) {
            self.phoneNumber2txt.text=[phoneNumberArray objectAtIndex:1];
            if (phoneNumberArray.count>2) {
                self.phoneNumber3txt.text=[phoneNumberArray objectAtIndex:2];
                if (phoneNumberArray.count>3) {
                    self.phoneNumber4txt.text=[phoneNumberArray objectAtIndex:3];
                    if (phoneNumberArray.count>4) {
                        self.phoneNumber5txt.text=[phoneNumberArray objectAtIndex:4];
                    }
                }
            }
        }
    }
    
    if (emailURLArray.count) {
        NSInteger index=1000;
        if ([emailURLArray containsObject:@"www"]) {
            index = [emailURLArray indexOfObject:@"www"];
            self.webURLtxt.text=[emailURLArray objectAtIndex:index];
        }else if ([emailURLArray containsObject:@"http"]){
            index = [emailURLArray indexOfObject:@"http"];
            self.webURLtxt.text=[emailURLArray objectAtIndex:index];
        }
        
        if (index!=1000) {
            [emailURLArray removeObjectAtIndex:index];
            if (emailURLArray.count>0){
                self.emailIdTxt.text=[emailURLArray objectAtIndex:0];
                if (emailURLArray.count>1){
                    self.emailId2Txt.text=[emailURLArray objectAtIndex:1];
                }
            }
        }else{
            self.emailIdTxt.text=[emailURLArray objectAtIndex:0];
            if (emailURLArray.count>1){
                self.emailId2Txt.text=[emailURLArray objectAtIndex:1];
            }
        }
        
    }
}

-(void)CompanyNameCheck:(NSString*)string{
    NSString *extentionConmpany;
    if ([string containsString:@"PVT."]){
        extentionConmpany=@"PVT.";
        
    }else if([string containsString:@"LTD."]){
        extentionConmpany=@"LTD.";
    }else if([string containsString:@"LTD"]){
        extentionConmpany=@"LTD";
    }else if([string containsString:@"S.r.l."]){
        extentionConmpany=@"S.r.l.";
    }else if([string containsString:@"eurl"]){
        extentionConmpany=@"eurl";
    }else if([string containsString:@"GbR"]){
        extentionConmpany=@"GbR";
    }else if([string containsString:@"GmbH"]){
        extentionConmpany=@"GmbH";
    }else if([string containsString:@"inc"]){
        extentionConmpany=@"inc";
    }else if([string containsString:@"LLC"]){
        extentionConmpany=@"LLC";
    }else if([string containsString:@"LLP"]){
        extentionConmpany=@"LLP";
    }else if([string containsString:@"Ltd"]){
        extentionConmpany=@"Ltd";
    }else if([string containsString:@"Srl"]){
        extentionConmpany=@"Srl";
    }else if([string containsString:@"Corp"]){
        extentionConmpany=@"Corp";
    }else if([string containsString:@"Ltd."]){
        extentionConmpany=@"Ltd.";
    }else if([string containsString:@"Inc."]){
        extentionConmpany=@"Inc.";
    }else if([string containsString:@"Co,LTD."]){
        extentionConmpany=@"Co,LTD.";
    }
    
    if (extentionConmpany.length) {
        NSArray *arrayWithTwoStrings = [string componentsSeparatedByString:extentionConmpany];
        NSArray *arrayWithLineBreak = [[arrayWithTwoStrings objectAtIndex:0] componentsSeparatedByString:@"\n"];
        self.companyName1Txt.text=[NSString stringWithFormat:@"%@%@",[arrayWithLineBreak lastObject],extentionConmpany];
        
    }
    
}


-(NSString*)PicCodeExist:(NSString*)string{
    
    NSString *pinCode;
    //Retrieving Numbers in array
    NSMutableArray* numberArray = [NSMutableArray new];
    
    NSString* regexPattern = @"\\d+";
    NSRegularExpression* regex = [[NSRegularExpression alloc] initWithPattern:regexPattern options:0 error:nil];
    
    NSArray* matches1 = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    for( NSTextCheckingResult* match in matches1) {
        NSString* strNumber = [string substringWithRange:match.range];
        [numberArray addObject:[NSNumber numberWithInt:strNumber.intValue]];
    }
    
    //Retrieving Pin Code in array and adresses
    
    for (NSString *pin in numberArray) {
        NSString* pinStr=[NSString stringWithFormat:@"%@",pin];
        NSString *pinRegex = @"^[0-9]{6}$";
        NSPredicate *pinTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pinRegex];
        BOOL pinValidates = [pinTest evaluateWithObject:pinStr];
        if (pinValidates) {
            pinCode=pinStr;
        }
        
    }
    return pinCode;
}

-(void)addCardDetails{
    if ([saveContactFlag isEqualToString:@"YES"]) {
        [self addContact];
    }
    
    NSString *OfficeAddress=@"";
    NSString *OfficePin=@"";
    
    NSString *FactoryAddress=@"";
    NSString *FactoryPin=@"";
    
    NSString *ResidenceAddress=@"";
    NSString *ResidencePin=@"";
    
    if([addresstype containsObject:addressType1]) {
        NSInteger index = [addresstype indexOfObject: addressType1];
        if (index==0) {
            OfficePin=[self PicCodeExist:self.addressLine1txt.text];
            if (FactoryPin.length)
                OfficeAddress=[self.addressLine1txt.text stringByReplacingOccurrencesOfString:OfficePin withString:@""];
            else
                OfficeAddress=self.addressLine1txt.text;
            
        }else if (index==1){
            FactoryPin=[self PicCodeExist:self.addressLine2txt.text];
            if (FactoryPin.length)
                FactoryAddress=[self.addressLine2txt.text stringByReplacingOccurrencesOfString:FactoryPin withString:@""];
            else
                FactoryAddress=self.addressLine2txt.text;
            
            
        }else if (index==2){
            ResidencePin=[self PicCodeExist:self.addressLine3txt.text];
            if (ResidencePin.length)
                ResidenceAddress=[self.addressLine3txt.text stringByReplacingOccurrencesOfString:ResidencePin withString:@""];
            else
                ResidenceAddress=self.addressLine3txt.text;
            
        }
    }
    
    if([addresstype containsObject:addressType2]) {
        NSInteger index = [addresstype indexOfObject: addressType2];
        if (index==0) {
            OfficePin=[self PicCodeExist:self.addressLine1txt.text];
            if (FactoryPin.length)
                OfficeAddress=[self.addressLine1txt.text stringByReplacingOccurrencesOfString:OfficePin withString:@""];
            else
                OfficeAddress=self.addressLine1txt.text;
            
        }else if (index==1){
            FactoryPin=[self PicCodeExist:self.addressLine2txt.text];
            if (FactoryPin.length)
                FactoryAddress=[self.addressLine2txt.text stringByReplacingOccurrencesOfString:FactoryPin withString:@""];
            else
                FactoryAddress=self.addressLine2txt.text;
            
            
        }else if (index==2){
            ResidencePin=[self PicCodeExist:self.addressLine3txt.text];
            if (ResidencePin.length)
                ResidenceAddress=[self.addressLine3txt.text stringByReplacingOccurrencesOfString:ResidencePin withString:@""];
            else
                ResidenceAddress=self.addressLine3txt.text;
            
        }
        
    }
    
    if([addresstype containsObject:addressType3]) {
        NSInteger index = [addresstype indexOfObject: addressType3];
        if (index==0) {
            OfficePin=[self PicCodeExist:self.addressLine1txt.text];
            if (FactoryPin.length)
                OfficeAddress=[self.addressLine1txt.text stringByReplacingOccurrencesOfString:OfficePin withString:@""];
            else
                OfficeAddress=self.addressLine1txt.text;
            
        }else if (index==1){
            FactoryPin=[self PicCodeExist:self.addressLine2txt.text];
            if (FactoryPin.length)
                FactoryAddress=[self.addressLine2txt.text stringByReplacingOccurrencesOfString:FactoryPin withString:@""];
            else
                FactoryAddress=self.addressLine2txt.text;
            
            
        }else if (index==2){
            ResidencePin=[self PicCodeExist:self.addressLine3txt.text];
            if (ResidencePin.length)
                ResidenceAddress=[self.addressLine3txt.text stringByReplacingOccurrencesOfString:ResidencePin withString:@""];
            else
                ResidenceAddress=self.addressLine3txt.text;
            
        }
    }
    
    
    
    
    NSString *UserUserID=[NSUSERDEFAULTS objectForKey:@"UserUserID"];
    NSString *AuthCode=[NSUSERDEFAULTS objectForKey:@"AuthCode"];
    
    
    [[DigiCardModel sharedInstance]show];
    [[BaseManager sharedInstance]AppCustomerInsUpdt:AuthCode UserID:UserUserID CustomerID:@"" Title:@"" CustomerName:self.userNameTxt.text DOB:@"" Designation:self.designationtxt.text CompanyName:self.companyName1Txt.text Website:self.webURLtxt.text ContactTypeID:ContactTypeID ManagementTypeID:ManagementTypeID ZoneID:ZoneID EmailID:self.emailIdTxt.text EmailID2:self.emailId2Txt.text NumberType1:phoneNumber1 Number1:self.phoneNumber1txt.text NumberType2:phoneNumber2 Number2:self.phoneNumber2txt.text NumberType3:phoneNumber3 Number3:self.phoneNumber3txt.text NumberType4:phoneNumber4 Number4:self.phoneNumber4txt.text NumberType5:phoneNumber5 Number5:self.phoneNumber5txt.text CardFrontImageString:frontImgBase64 CardFrontImageExtension:@".png" CardBackImageString:backImgBase64 CardBackImageExtension:@".png" Remark:self.remarkTxt.text OfficeAddress:OfficeAddress OfficePin:OfficePin FactoryAddress:FactoryAddress FactoryPin:FactoryPin ResidenceAddress:ResidenceAddress ResidencePin:ResidencePin PrincipleList:PrincipleID BusinessVerticalList:BusinessVerticalID IndustrySegmentList:IndustrySegmentID IndustryTypeList:IndustryTypeID withCallback:^(NSDictionary *response) {
        NSString *statusValue=[response objectForKey:@"status"];
        if ([statusValue isEqualToString:@"failed"]) {
            [[DigiCardModel sharedInstance]HideWaiting];
            [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
        }
        else{
            [[DigiCardModel sharedInstance]success:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
            [self performSelector:@selector(goToCardList) withObject:nil afterDelay:2.00];
        }
        [[DigiCardModel sharedInstance]Hide];
        
    }];
}

-(void)goToCardList{
    [APPDELEGATE SetNavigationBar];
    [APPDELEGATE.maintab setSelectedIndex:0];
    [[APPDELEGATE.maintab.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:YES];
}



@end
