//
//  CardDetailsVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "CardDetailsVC.h"

@interface CardDetailsVC (){
    NSArray *CustomerDetailArray;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *designationLbl;
@property (weak, nonatomic) IBOutlet UILabel *companyLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneWorkLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneMobileLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneMobile2Lbl;
@property (weak, nonatomic) IBOutlet UILabel *officeAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *factoryAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *residentialAddressLbl;
@property (weak, nonatomic) IBOutlet UILabel *websitrURLLbl;
@property (weak, nonatomic) IBOutlet UILabel *zoneNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *frontImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontImgViewHTConst;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImgViewHTConst;//150

@end

@implementation CardDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomerDetailArray=[[NSArray alloc]init];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    [self AppCustomerDetail];
    
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

-(void)AppCustomerDetail{
    [[DigiCardModel sharedInstance]show];

    NSString *AuthCode=[NSUSERDEFAULTS objectForKey:@"AuthCode"];
    NSString *UserID=[NSUSERDEFAULTS objectForKey:@"UserUserID"];
    [[BaseManager sharedInstance]AppCustomerDetail:AuthCode UserID:UserID CustomerID:_customerId withCallback:^(NSDictionary *response) {
        //CustomerDetail
        CustomerDetailArray=[response objectForKey:@"CustomerDetail"];
        [self setValueInLabel];

    }];
}


-(void)setValueInLabel{
    self.nameLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Name"];
    self.designationLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Designation"];
    self.companyLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Company"];
    self.emailIdLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"EmailID"];
    self.phoneWorkLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number"];
    self.phoneMobileLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number3"];
    self.phoneMobile2Lbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number4"];
    self.officeAddressLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"OfficeAddress"];
    self.factoryAddressLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"FactoryAddress"];
    self.residentialAddressLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"ResidenceAddress"];
    self.websitrURLLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Website"];
    self.zoneNameLbl=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"ZoneName"];
    
    NSString *CardFrontImagePath=[NSString stringWithFormat:@"%@%@",APPIMAGEURL,[[CustomerDetailArray objectAtIndex:0]objectForKey:@"CardFrontImage"]];
    [self.frontImageView sd_setImageWithURL:[NSURL URLWithString:CardFrontImagePath]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",APPIMAGEURL,[[CustomerDetailArray objectAtIndex:0]objectForKey:@"CardBackImage"]];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:path]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [[DigiCardModel sharedInstance]Hide];

}

/*
 
 {
 BusinessVerticalName = "<null>";
 CardBackImage = "Uploads/CardImage/527b73cd-c7a9-4e18-8005-b201eca7f59a..jpeg";
 CardFrontImage = "Uploads/CardImage/841767de-911e-42c2-b307-e61eee772df1..jpeg";
 Company = CFCS;
 ContactType = "<null>";
 ContactTypeID = 4;
 CustomerID = "9baf3113-32ed-4d18-a174-71a6ce1b6870";
 DOB = "<null>";
 Designation = COO;
 EmailID = "pankaj@cfesindia.com";
 FactoryAddress = "Kakardooma, Delhi - 110092. (INDIA), ";
 FactoryCity = 0;
 FactoryCityName = "<null>";
 FactoryCountryID = "<null>";
 FactoryCountryName = "<null>";
 FactoryPin = "";
 FactoryStateID = "<null>";
 FactoryStateName = "<null>";
 ISDeletable = 0;
 IndustrySegmentName = "<null>";
 IndustryTypeName = "<null>";
 LogBy = "Mr. DIGICARD ADMIN";
 LogDate = "10 Oct 2017";
 ManagementType = "Middle Level";
 ManagementTypeID = 2;
 ModifyBy = "<null>";
 ModifyDate = "<null>";
 Name = "Pankaj Chopra";
 Number = " +91-11-40522522";
 Number2 = "";
 Number3 = "+91-9810082139";
 Number4 = "+9811082139";
 Number5 = "";
 NumberType = Work;
 NumberType2 = Home;
 NumberType3 = "Mobile No";
 NumberType4 = "Mobile No";
 NumberType5 = "";
 OfficeAddress = "208, IInd Floor, Parmesh Complex-2, Plot No-6, Community Center,";
 OfficeCity = 0;
 OfficeCityName = "<null>";
 OfficeCountryID = "<null>";
 OfficeCountryName = "<null>";
 OfficePin = "";
 OfficeStateID = "<null>";
 OfficeStateName = "<null>";
 PrincipleName = "<null>";
 Remark = "";
 ResidenceAddress = "";
 ResidenceCity = 0;
 ResidenceCityName = "<null>";
 ResidenceCountryID = "<null>";
 ResidenceCountryName = "<null>";
 ResidencePin = "";
 ResidenceStateID = "<null>";
 ResidenceStateName = "<null>";
 Title = "";
 Website = "w.cfcs.co.in/theo";
 ZoneID = 1008;
 ZoneName = "<null>";
 }

 
 
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
