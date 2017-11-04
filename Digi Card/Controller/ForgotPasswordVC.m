//
//  ForgotPasswordVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ForgotPasswordVC.h"

@interface ForgotPasswordVC ()
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
}
- (IBAction)backToLogin:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
