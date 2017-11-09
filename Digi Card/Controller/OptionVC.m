//
//  OptionVC.m
//  Digi Card
//
//  Created by umenit on 11/8/17.
//
//

#import "OptionVC.h"

@interface OptionVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *selectedArray;
    NSMutableArray *selectedDataArray;

    NSArray *dataArr;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation OptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataArr=[[NSArray alloc]init];
    dataArr=_optionDataArray;
    selectedArray=[[NSMutableArray alloc]init];
    selectedDataArray=[[NSMutableArray alloc]init];
    self.tableView.allowsMultipleSelection=YES;
    
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        [selectedArray addObjectsFromArray:[[DigiCardModel sharedInstance].BusinessVerticalMasterArray valueForKey:@"BusinessVertical"]];
        [selectedDataArray addObjectsFromArray:[DigiCardModel sharedInstance].BusinessVerticalMasterArray];

    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        [selectedArray addObjectsFromArray:[[DigiCardModel sharedInstance].IndustrySegmentMasterArray valueForKey:@"IndustrySegment"]];
        [selectedDataArray addObjectsFromArray:[DigiCardModel sharedInstance].IndustrySegmentMasterArray];

    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        [selectedArray addObjectsFromArray:[[DigiCardModel sharedInstance].IndustryTypeMasterArray valueForKey:@"IndustryType"]];
        [selectedDataArray addObjectsFromArray:[DigiCardModel sharedInstance].IndustryTypeMasterArray];

    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        [selectedArray addObjectsFromArray:[[DigiCardModel sharedInstance].PrincipleMasterArray valueForKey:@"Principle"]];
        [selectedDataArray addObjectsFromArray:[DigiCardModel sharedInstance].PrincipleMasterArray];

    }
    

    
    [self setNeedsStatusBarAppearanceUpdate];
    
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
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
    return [dataArr count];
    
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
    
  
    NSString *objectValue;
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        objectValue=[[dataArr objectAtIndex:indexPath.section] valueForKey:@"BusinessVertical"];
        
    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        objectValue=[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustrySegment"];
        
    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        objectValue=[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustryType"];
        
    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        objectValue=[[dataArr objectAtIndex:indexPath.section] valueForKey:@"Principle"];
        
    }
    if([selectedArray containsObject:objectValue]) {
        imageView.image=[UIImage imageNamed:@"checksquare.png"];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        //  [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    }
    else{
        imageView.image=[UIImage imageNamed:@"square.png"];
    }
    
    nameLbl.text=objectValue;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:201];
    imageView.image=[UIImage imageNamed:@"checksquare.png"];
    
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        [selectedArray addObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"BusinessVertical"]];
        
    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        [selectedArray addObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustrySegment"]];
        
    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        [selectedArray addObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustryType"]];
        
    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        [selectedArray addObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"Principle"]];
        
    }
    [selectedDataArray addObject:[dataArr objectAtIndex:indexPath.section]];

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView=(UIImageView*)[cell viewWithTag:201];
    imageView.image=[UIImage imageNamed:@"square.png"];
    
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        [selectedArray removeObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"BusinessVertical"]];
        
    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        [selectedArray removeObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustrySegment"]];
        
    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        [selectedArray removeObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"IndustryType"]];
        
    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        [selectedArray removeObject:[[dataArr objectAtIndex:indexPath.section] valueForKey:@"Principle"]];
        
    }
    [selectedDataArray removeObject:[dataArr objectAtIndex:indexPath.section]];

}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)okBtnAction:(id)sender {
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        [DigiCardModel sharedInstance].BusinessVerticalMasterArray=selectedDataArray;
        
    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        [DigiCardModel sharedInstance].IndustrySegmentMasterArray=selectedDataArray;
        
    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        [DigiCardModel sharedInstance].IndustryTypeMasterArray=selectedDataArray;
        
    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        [DigiCardModel sharedInstance].PrincipleMasterArray=selectedDataArray;
        
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - search Delegate

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope{
    
    if ([_selectedType isEqualToString:@"BusinessVertical"]) {
        dataArr = [[_optionDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(BusinessVertical contains[cd] %@)", searchText]] mutableCopy];

    }else if ([_selectedType isEqualToString:@"IndustrySegment"]){
        dataArr = [[_optionDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(IndustrySegment contains[cd] %@)", searchText]] mutableCopy];

    }else if ([_selectedType isEqualToString:@"IndustryType"]){
        dataArr = [[_optionDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(IndustryType contains[cd] %@)", searchText]] mutableCopy];

    }else if ([_selectedType isEqualToString:@"PrincipleType"]){
        dataArr = [[_optionDataArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(Principle contains[cd] %@)", searchText]] mutableCopy];

    }
    [self.tableView reloadData];
}

- (void)searchBar:(UISearchBar *)searchBar1 textDidChange:(NSString *)searchText{
    
    
    if (searchText.length>0) {
        // search and reload data source
        // [[DealGaliInformation sharedInstance]ShowWaiting:@"Searching Data..."];
          [self filterContentForSearchText:searchText scope:[[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
  
        
    }
    
    else{
        // if text lenght == 0
        // we will consider the searchbar is not active
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar1 afterDelay:0];
        
    }
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
    //[searchBar resignFirstResponder];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self cancelSearching];
    [self.tableView reloadData];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar1{
    [searchBar1 resignFirstResponder];
    UIButton *cancelButton = [searchBar1 valueForKey:@"_cancelButton"];
    if ([cancelButton respondsToSelector:@selector(setEnabled:)]) {
        cancelButton.enabled = YES;
    }
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar1{
    // we used here to set self.searchBarActive = YES
    // but we'll not do that any more... it made problems
    // it's better to set self.searchBarActive = YES when user typed something
    [searchBar1 setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar1 {
    
    return YES;
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar1{
    
    // searchBarActive = NO;
    [searchBar1 setShowsCancelButton:YES animated:YES];
}
-(void)cancelSearching{
    
    dataArr=_optionDataArray;
    [_searchBar resignFirstResponder];
    _searchBar.text  = @"";
    [_searchBar setShowsCancelButton:NO animated:YES];
    [self.tableView reloadData];
    
    
}

@end
