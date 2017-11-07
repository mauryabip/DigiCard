//
//  ScannerVC.h
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import <UIKit/UIKit.h>

@interface ScannerVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate>{
    UITextField* activeField;
    UIView *inputAccessoryView;
    UIButton *Done;
    UIButton *Privious;
    UIButton *Next;
    NSString *nextBtnName;
    NSString *previousBtnName;
    
    FTPopOverMenuConfiguration *configuration;
    NSArray *phoneNumbertype;
    NSArray *addresstype;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTxt;
@property (weak, nonatomic) IBOutlet UITextField *designationtxt;
@property (weak, nonatomic) IBOutlet UITextField *companyName1Txt;
@property (weak, nonatomic) IBOutlet UITextField *companyName2Txt;
@property (weak, nonatomic) IBOutlet UITextField *addressLine1txt;
@property (weak, nonatomic) IBOutlet UITextField *addressLine2txt;
@property (weak, nonatomic) IBOutlet UITextField *addressLine3txt;
@property (weak, nonatomic) IBOutlet UITextField *addressLine4txt;
@property (weak, nonatomic) IBOutlet UITextField *postalCodetxt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber1txt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber2txt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber3txt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber4txt;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber5txt;
@property (weak, nonatomic) IBOutlet UITextField *emailIdTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailId2Txt;
@property (weak, nonatomic) IBOutlet UITextField *webURLtxt;
@property (weak, nonatomic) IBOutlet UITextField *remarkTxt;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressLine1btn;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressLine2btn;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressLine3btn;
@property (weak, nonatomic) IBOutlet UIButton *selectAddressLine4btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPhonenumber1btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPhonenumber2btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPhonenumber3btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPhonenumber4btn;
@property (weak, nonatomic) IBOutlet UIButton *selectPhonenumber5btn;

@end
