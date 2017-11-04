//
//  CardListVC.m
//  Digi Card
//
//  Created by umenit on 11/2/17.
//
//

#import "CardListVC.h"

@interface CardListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120.0;
    
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
- (IBAction)moreBtnAction:(id)sender {
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 15;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 10.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CardCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
     //   UILabel *questionLbl=(UILabel*)[cell viewWithTag:100];

    UIView* shadowView = (UIView*)[cell viewWithTag:99];
    shadowView.backgroundColor=[UIColor colorWithRed:0.0/255.0 green:150.0/255.0 blue:136.0/255.0 alpha:0.3];
    [shadowView.layer setCornerRadius:5.0f];
    [shadowView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [shadowView.layer setBorderWidth:0.2f];
    [shadowView.layer setShadowColor:[UIColor colorWithRed:225.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0].CGColor];
    [shadowView.layer setShadowOpacity:1.0];
    [shadowView.layer setShadowRadius:5.0];
    [shadowView.layer setShadowOffset:CGSizeMake(5.0f, 5.0f)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 10)];
    headerView.backgroundColor=[UIColor clearColor];
    return headerView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {


    CGFloat sectionHeaderHeight = 10;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
    
 
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
