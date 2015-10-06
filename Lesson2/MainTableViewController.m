//
//  ViewController.m
//  Lesson2
//
//  Created by Azat Almeev on 26.09.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "MainTableViewController.h"
#import "LoadingTableViewController.h"
#import "IndicatorTableViewCell.h"

@implementation MainTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    for(int i = 0;i <= 5;i++){
        
        NSMutableArray *subarray = [NSMutableArray new];
        [subarray addObject:[NSString stringWithFormat:@"%ld section", (long ) i]];
        [self.items addObject:subarray];
    }
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshView:)forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

-(void)didLoadNewData:(NSArray *)items{
    int c = (int)self.items.count;
    
    UITableView *s = self.tableView;
    
    for(int i = c+1;i < c + 6;i++){
        [self.tableView beginUpdates];
        NSMutableArray *subarray = [NSMutableArray new];
        [subarray addObject:[NSString stringWithFormat:@"%ld section", (long ) i]];
        [self.items addObject:subarray];
        [self.tableView reloadData];
        [s insertSections:[NSIndexSet indexSetWithIndex:c] withRowAnimation:UITableViewRowAnimationBottom ];
        [self.tableView endUpdates];
    }
    [self.tableView reloadData];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
    
    
}

- (NSMutableArray *)items{
    if(!_items)
        _items = [NSMutableArray new];
    return _items;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *basicCell1 = @"cell1";
    static NSString *basicCell2 = @"cell2";
    static NSString *basicCell3 = @"cell3";
    static NSString *basicCell4 = @"cell4";
    UITableViewCell *cell;
        if(indexPath.row==0){
            cell = [tableView dequeueReusableCellWithIdentifier:basicCell1];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
            
        }
        if(indexPath.row==1){
            cell = [tableView dequeueReusableCellWithIdentifier:basicCell2];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Subtitle %ld index",(long)indexPath.section];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld subtitle",(long)indexPath.section];
        }
        if(indexPath.row==2){
            cell = [tableView dequeueReusableCellWithIdentifier:basicCell3];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Detail %ld index",(long)indexPath.section];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld subtitle",(long)indexPath.section];    }
        if(indexPath.row==3){
            cell = [tableView dequeueReusableCellWithIdentifier:basicCell4];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"Detail %ld index",(long)indexPath.section];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.section];
        }
        return cell;
    
}






- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return true;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
        return UITableViewCellEditingStyleDelete;
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *deleteIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:indexPath.section],[NSIndexPath indexPathForRow:1 inSection:indexPath.section],[NSIndexPath indexPathForRow:2 inSection:indexPath.   section],[NSIndexPath indexPathForRow:3 inSection:indexPath.section],nil];
        [self.tableView beginUpdates];
        [self.items removeObjectAtIndex:indexPath.section];
        [tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        [self.tableView endUpdates];
        
    }
        
}


-(void)refreshView:(UIRefreshControl *)refresh {
  refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data..."];
   
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
    [formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    [refresh endRefreshing];
}



-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(!decelerate){
        [self loadDataUsingLastID:[NSNumber numberWithInteger:self.items.count]];
        NSLog(@"reload2");
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= 0) {
        [self loadDataUsingLastID:[NSNumber numberWithInteger:self.items.count]];
        NSLog(@"reload");
    }
    
    
}

- (void)didFailToLoadDataWithError:(NSError *)error {
    [self.tableView reloadData];
     NSLog(@"the end");
}


-(void)initFooterView
{
    
    
}


@end
