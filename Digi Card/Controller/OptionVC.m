//
//  OptionVC.m
//  Digi Card
//
//  Created by umenit on 11/8/17.
//
//

#import "OptionVC.h"

@interface OptionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation OptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *catIdentifier = @"OptionCell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:catIdentifier];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:201];
    UILabel *nameLbl=(UILabel*)[cell viewWithTag:202];
    
    
//    AllCategory *categoryList=[[FloristBaseModel sharedInstance].catGlobalArray objectAtIndex:indexPath.section];
//    nameLbl.text=categoryList.cat_name;
//    
//    if([[FloristBaseModel sharedInstance].catSelectedArray containsObject:categoryList.cat_id]) {
//        imageView.image=[UIImage imageNamed:@"checksquare.png"];
//        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
//        //  [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//    }
//    else{
//        imageView.image=[UIImage imageNamed:@"square.png"];
//    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:201];
    imageView.image=[UIImage imageNamed:@"checksquare.png"];
    
    // AllCategory *categoryList=[[FloristBaseModel sharedInstance].catGlobalArray objectAtIndex:indexPath.section];
    //[selectedArray addObject:categoryList.cat_id];

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:201];
    imageView.image=[UIImage imageNamed:@"square.png"];
   // AllCategory *categoryList=[[FloristBaseModel sharedInstance].catGlobalArray objectAtIndex:indexPath.section];
   // [selectedArray removeObject:categoryList.cat_id];
    
    
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)okBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
