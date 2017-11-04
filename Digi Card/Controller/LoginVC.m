//
//  LoginVC.m
//  Digi Card
//
//  Created by umenit on 11/4/17.
//
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "ForgotPasswordVC.h"

@interface LoginVC ()
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
    [APPDELEGATE SetNavigationBar];
    [APPDELEGATE.maintab setSelectedIndex:1];
    [[APPDELEGATE.maintab.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:YES];
}
- (IBAction)forgotPassAction:(id)sender {
    ForgotPasswordVC *ForgotPasswordVC=[self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC"];
    [self.navigationController pushViewController:ForgotPasswordVC animated:YES];
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
