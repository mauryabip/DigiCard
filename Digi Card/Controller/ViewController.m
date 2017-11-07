//
//  ViewController.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "ViewController.h"

@interface ViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnAction:(id)sender {
    NSString *Status=[NSUSERDEFAULTS objectForKey:@"Status"];
    if ([Status isEqualToString:@"1"]) {
        [APPDELEGATE SetNavigationBar];
        [APPDELEGATE.maintab setSelectedIndex:1];
        [[APPDELEGATE.maintab.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:YES];
    }
    else{
        LoginVC *LoginVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [self.navigationController pushViewController:LoginVC animated:YES];
    }


}


@end
