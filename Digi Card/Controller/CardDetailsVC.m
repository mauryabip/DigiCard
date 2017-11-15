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


@property (strong, nonatomic) IBOutlet UILabel *phoneNo1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneNo2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneNo3Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneNo4Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneNo5Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneMobile4Lbl;
@property (strong, nonatomic) IBOutlet UILabel *phoneMobile5Lbl;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *backImgHtConst;
@property (strong, nonatomic) IBOutlet UILabel *backImgLbl;


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
    self.nameLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Name"];
    self.designationLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Designation"];
    self.companyLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Company"];
    self.emailIdLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"EmailID"];
    
    NSString *NumberType=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"NumberType"];
    if (NumberType.length)
        self.phoneNo1Lbl.text=[NSString stringWithFormat:@"Phone No (%@)",[[CustomerDetailArray objectAtIndex:0]objectForKey:@"NumberType"]];
    NSString *NumberType2=NumberType;
    if (NumberType2.length)
        self.phoneNo2Lbl.text=[NSString stringWithFormat:@"Phone No (%@)",NumberType2];
    NSString *NumberType3=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"NumberType3"];
    if (NumberType3.length)
        self.phoneNo3Lbl.text=[NSString stringWithFormat:@"Phone No (%@)",NumberType3];
    NSString *NumberType4=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"NumberType4"];
    if (NumberType4.length)
        self.phoneNo1Lbl.text=[NSString stringWithFormat:@"Phone No (%@)",NumberType4];
    NSString *NumberType5=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"NumberType5"];
    if (NumberType5.length)
        self.phoneNo5Lbl.text=[NSString stringWithFormat:@"Phone No (%@)",NumberType5];
    
    self.phoneWorkLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number"];
    self.phoneMobileLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number2"];
    self.phoneMobile2Lbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number3"];
    self.phoneMobile4Lbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number4"];
    self.phoneMobile5Lbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Number5"];

    
    
    self.officeAddressLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"OfficeAddress"];
    self.factoryAddressLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"FactoryAddress"];
    self.residentialAddressLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"ResidenceAddress"];
    self.websitrURLLbl.text=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"Website"];
    NSString* zoneNme=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"ZoneName"];
    if ([zoneNme isKindOfClass:[NSNull class]]) {
        zoneNme=@"";
    }
    self.zoneNameLbl.text=zoneNme;
    
    NSString *CardFrontImagePath=[NSString stringWithFormat:@"%@%@",APPIMAGEURL,[[CustomerDetailArray objectAtIndex:0]objectForKey:@"CardFrontImage"]];
    [self.frontImageView sd_setImageWithURL:[NSURL URLWithString:CardFrontImagePath]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSString *path=[NSString stringWithFormat:@"%@%@",APPIMAGEURL,[[CustomerDetailArray objectAtIndex:0]objectForKey:@"CardBackImage"]];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:path]
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    NSString *backImgServer=[[CustomerDetailArray objectAtIndex:0]objectForKey:@"CardBackImage"];
    if (backImgServer.length==0) {
        self.backImgLbl.hidden=YES;
        self.backImgHtConst.constant=0;
    }
    
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

//static id ObjectOrNull(id object)
//{
//    return object ?: [NSNull null];
//}

@end
