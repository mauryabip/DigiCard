//
//  CardListFilterVC.m
//  Digi Card
//
//  Created by Appy on 05/11/17.
//
//

#import "CardListFilterVC.h"

@interface CardListFilterVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
    NSInteger selectedIndex;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CardListFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    selectedIndex=1000;
    titleArr=@[@"Region", @"Business Vertical", @"Industry Segment",@"Industry Type",@"Principle"];

    
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


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArr count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIdentifier = @"FilterCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    
    UILabel *typeLbl=(UILabel*)[cell viewWithTag:112];
    UIImageView *upDownImgView=(UIImageView*)[cell viewWithTag:111];

    typeLbl.text=[NSString stringWithFormat:@"%@",[titleArr objectAtIndex:indexPath.row]];
    if (selectedIndex==indexPath.row) {
        upDownImgView.image=[UIImage imageNamed:@"down-arrow.png"];
    }else{
        upDownImgView.image=[UIImage imageNamed:@"up-arrow"];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex=indexPath.row;
    [self.tableView reloadData];
}

- (IBAction)applyAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)resetAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
