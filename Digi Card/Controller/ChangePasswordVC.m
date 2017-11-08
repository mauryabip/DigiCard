//
//  ChangePasswordVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()<UITextFieldDelegate>{
    UITextField* activeField;
    UIView *inputAccessoryView;
    UIButton *Done;
    UIButton *Privious;
    UIButton *Next;
    NSString *nextBtnName;
    NSString *previousBtnName;
}

@property (weak, nonatomic) IBOutlet UITextField *currentPassTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassTxt;

@end

@implementation ChangePasswordVC

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
    [APPDELEGATE maintab].tabBar.hidden=YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [APPDELEGATE maintab].tabBar.hidden=NO;
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePasswordAction:(id)sender {
    BOOL isValid=[self CheckForValidation];
    if (isValid){
        NSString *UserUserID=[NSUSERDEFAULTS objectForKey:@"UserUserID"];
        NSString *AuthCode=[NSUSERDEFAULTS objectForKey:@"AuthCode"];

       // [[DigiCardModel sharedInstance]ShowWaitingLongtime:@""];
        [[DigiCardModel sharedInstance]show];

        [[BaseManager sharedInstance]AppUserChangePassword:UserUserID OldPassword:self.currentPassTxt.text NewPassword:self.passwordTxt.text AuthCode:AuthCode withCallback:^(NSDictionary *response) {
           // [[DigiCardModel sharedInstance]HideWaiting];
            [[DigiCardModel sharedInstance]Hide];

            NSString *statusValue=[response objectForKey:@"status"];
            if ([statusValue isEqualToString:@"failed"]) {
                [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
            }else{
                [[DigiCardModel sharedInstance] success:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
                [self performSelector:@selector(backAction:) withObject:nil afterDelay:2.0000];
            }
        }];
    }
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
    
    if (activeField==self.currentPassTxt) {
        Privious.userInteractionEnabled=NO;
        Next.userInteractionEnabled=YES;
        nextBtnName=@"nextk.png";
        previousBtnName=@"previousDisable.png";
    }
    else if(activeField==self.confirmPassTxt) {
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

    [self.view endEditing:YES];
}
-(void)previousButtonClick{
    if ([self.confirmPassTxt isFirstResponder])
    {
        
        [_confirmPassTxt resignFirstResponder];
        activeField = self.passwordTxt;
    }
    else if ([self.passwordTxt isFirstResponder])
    {
        
        [_passwordTxt resignFirstResponder];
        activeField = self.currentPassTxt;
    }
    
    [activeField becomeFirstResponder];
    
    
}
-(void)nextButtonClick{
    if ([self.currentPassTxt isFirstResponder])
    {
        
        [self.currentPassTxt resignFirstResponder];
        activeField = self.passwordTxt;
    }
    else if ([self.passwordTxt isFirstResponder])
    {
        
        [_passwordTxt resignFirstResponder];
        activeField = self.confirmPassTxt;
    }
    
    [activeField becomeFirstResponder];
    
}


#pragma mark - Validation Method
-(BOOL)CheckForValidation
{
    BOOL valid=YES;
    
    if([self.currentPassTxt.text isEqualToString:@""] && [self.currentPassTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]])
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter current password"];
    }
    else if(([self.passwordTxt.text isEqualToString:@""]&& [self.passwordTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter new password"];
    }
    else if(([self.confirmPassTxt.text isEqualToString:@""]&& [self.confirmPassTxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]))
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"Please enter confirm new password"];
    }
    else if(![self.confirmPassTxt.text isEqualToString:self.passwordTxt.text])
    {
        valid = NO;
        [[DigiCardModel sharedInstance] ViewSlideDown:@"New password and confirm New password didn't match"];
    }
    
    return valid;
}

@end
