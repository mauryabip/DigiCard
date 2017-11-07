//
//  ScannerVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ScannerVC.h"

@interface ScannerVC ()


@end



@implementation ScannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    phoneNumbertype=[[NSArray alloc]init];
    phoneNumbertype=[[[DigiCardModel sharedInstance].NumberTypeMasterDic valueForKey:@"NumberType"] objectAtIndex:0];
    NSLog(@"%@   dsadas%@",[[DigiCardModel sharedInstance].NumberTypeMasterDic valueForKey:@"NumberType"],[[[DigiCardModel sharedInstance].NumberTypeMasterDic valueForKey:@"NumberType"] objectAtIndex:0]);
    addresstype=@[@"Office", @"Factory", @"Residence"];
    
    [[DigiCardModel sharedInstance]show];
    [self performSelector:@selector(hide) withObject:nil afterDelay:2.00];

}
-(void)hide{
    [[DigiCardModel sharedInstance]Hide];
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

                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}


- (IBAction)selectPhonenumber1Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:phoneNumbertype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber1btn setTitle:[phoneNumbertype objectAtIndex:selectedIndex] forState:UIControlStateNormal];

                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber2Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:phoneNumbertype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber2btn setTitle:[phoneNumbertype objectAtIndex:selectedIndex] forState:UIControlStateNormal];

                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber3Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:phoneNumbertype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber3btn setTitle:[phoneNumbertype objectAtIndex:selectedIndex] forState:UIControlStateNormal];

                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber4Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:phoneNumbertype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber4btn setTitle:[phoneNumbertype objectAtIndex:selectedIndex] forState:UIControlStateNormal];

                       } dismissBlock:^{
                           NSLog(@"user canceled. do nothing.");
                           
                       }];
}
- (IBAction)selectPhonenumber5Action:(id)sender {
    [self OpenPopOver:sender];
    [FTPopOverMenu showForSender:sender
                   withMenuArray:phoneNumbertype
                       doneBlock:^(NSInteger selectedIndex) {
                           
                           NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                           [self.selectPhonenumber5btn setTitle:[phoneNumbertype objectAtIndex:selectedIndex] forState:UIControlStateNormal];

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
    
  
    
    return valid;
}

@end
