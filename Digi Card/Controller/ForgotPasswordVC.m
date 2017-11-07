//
//  ForgotPasswordVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()<UITextFieldDelegate>{
    UIView *inputAccessoryView;
    UIButton *Done;
}
@property (strong, nonatomic) IBOutlet UITextField *userNameTxt;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ForgotPasswordVC

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
- (IBAction)forgotAction:(id)sender {
    BOOL isValid=[self CheckForValidation];
    if (isValid){
        NSString *UserName=[NSUSERDEFAULTS objectForKey:@"UserName"];
        [[DigiCardModel sharedInstance]ShowWaitingLongtime:@""];
        [[BaseManager sharedInstance]AppUserForgetPassword:UserName withCallback:^(NSDictionary *response) {
            [[DigiCardModel sharedInstance]HideWaiting];
            NSString *statusValue=[response objectForKey:@"status"];
            if ([statusValue isEqualToString:@"failed"]) {
                [[DigiCardModel sharedInstance]errorWithTitle:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
            }else{
                [[DigiCardModel sharedInstance] success:APPNAME detailMessage:[response objectForKey:@"MsgNotification"] view:self.view];
                [self performSelector:@selector(backToLogin:) withObject:nil afterDelay:2.0000];
            }
        }];
    }
}
- (IBAction)backToLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)tabGestureAction:(id)sender {
    [self.view endEditing:YES];
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
    
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 265.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    [textField setInputAccessoryView:[self inputAccessoryViews]];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    
}

#pragma mark - inputAccessoryViews & Delegate

- (UIView *)inputAccessoryViews {
    
    CGRect accessFrame = CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 40.0);
    inputAccessoryView = [[UIView alloc] initWithFrame:accessFrame];
    inputAccessoryView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    
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
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    self.scrollView.contentInset = contentInsets;
    
    [self.view endEditing:YES];
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
    
    return valid;
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
