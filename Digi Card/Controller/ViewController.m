//
//  ViewController.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ViewController.h"
#import "YBHud.h"

@interface ViewController (){
    YBHud *hud;
    DGActivityIndicatorView *activityIndicatorView;
}
@property (weak, nonatomic) IBOutlet UILabel *DigiLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES];
    
    activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:[UIColor whiteColor]];
    
    activityIndicatorView.frame = CGRectMake((SCREENWIDTH/2)-50, self.DigiLbl.frame.origin.y+50, 100, 100);
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    //    hud = [[YBHud alloc]initWithHudType:33];
    //    hud.dimAmount = 0.7;
    //    [hud showInView:self.view animated:YES];
    
    
    [self performSelector:@selector(dismissHud) withObject:nil afterDelay:30.0];
    
    NSString *Status=[NSUSERDEFAULTS objectForKey:@"Status"];
    if ([Status isEqualToString:@"1"]) {
        
        NSString *UserUserID=[NSUSERDEFAULTS objectForKey:@"UserUserID"];
        NSString *AuthCode=[NSUSERDEFAULTS objectForKey:@"AuthCode"];
        [[BaseManager sharedInstance]AppLoginStatusCheck:UserUserID AuthCode:AuthCode withCallback:^(NSDictionary *response) {
            
            if ([response objectForKey:@"LoginCount"]==0) {
                [self performSelector:@selector(GoToLoginScreen) withObject:nil afterDelay:2.00000];
            }else{
                [self performSelector:@selector(GoToScannerScreen) withObject:nil afterDelay:2.00000];
            }
            
        }];
        
    }else{
        [self performSelector:@selector(GoToLoginScreen) withObject:nil afterDelay:5.00000];
    }
    
}
-(void)dismissHud{
    [activityIndicatorView stopAnimating];
    
    // [hud dismissAnimated:YES];
}

-(void)GoToScannerScreen{
    [activityIndicatorView stopAnimating];
    [APPDELEGATE SetNavigationBar];
    [APPDELEGATE.maintab setSelectedIndex:1];
    [[APPDELEGATE.maintab.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:YES];
}

-(void)GoToLoginScreen{
    [activityIndicatorView stopAnimating];
    LoginVC *LoginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self.navigationController pushViewController:LoginVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
