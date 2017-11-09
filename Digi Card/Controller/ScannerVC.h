//
//  ScannerVC.h
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "OptionVC.h"

@interface ScannerVC : UIViewController<UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
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
    UIPickerView *myPickerView;
    NSMutableArray *pickerArray;
    
    NSString *locationId;
    
    UIBarButtonItem *_previous, *_next, *_done, *_searchone;
    UIView *_inputAccView;
    UIView *_inputAccViewforsearch;
    UIToolbar *_keyboardToolbarforsearch;
    
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIImageView *frontCardImgView;
@property (strong, nonatomic) IBOutlet UIImageView *backCardImgView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *frontCardViewHTConst;



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

@property (strong, nonatomic) IBOutlet UIButton *ContactTypeBtn;
- (IBAction)ContactTypeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *ContactTypeTxt;

@property (strong, nonatomic) IBOutlet UIButton *ManagementTypeBtn;
- (IBAction)ManagementTypeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *managementTypeTxt;

@property (strong, nonatomic) IBOutlet UILabel *BusinessVerticalLbl;
@property (strong, nonatomic) IBOutlet UIButton *BusinessVerticalBtn;
- (IBAction)BusinessVerticalBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *IndustrySegmentLbl;
@property (strong, nonatomic) IBOutlet UIButton *IndustrySegmentBtn;
- (IBAction)IndustrySegmentBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *IndustryTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *IndustryTypeBtn;
- (IBAction)IndustryTypeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *PrincipleTypeLbl;
@property (strong, nonatomic) IBOutlet UIButton *PrincipleTypeBtn;
- (IBAction)PrincipleTypeBtnAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *ZoneTypeBtn;
- (IBAction)ZoneTypeBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *zoneTxt;

@property (strong, nonatomic) IBOutlet UIButton *saveContactBtn;
- (IBAction)saveContactAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitBtnAction:(id)sender;

- (IBAction)addFrontCardAction:(id)sender;

- (IBAction)addBackCardAction:(id)sender;

@end
