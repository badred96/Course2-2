//
//  MyCollectionViewController.m
//  Lesson2
//
//  Created by Azat Almeev on 01.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "LoadingTableViewController.h"

@implementation MyCollectionViewController



- (NSMutableArray *)items {
    if (!_items)
        _items = [NSMutableArray new];
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MyCollectionIdentifier"];
}


- (void)didLoadNewData:(NSArray *)items {
    self.Loading = NO;
    NSInteger count1 = self.items.count;
    [self.items addObjectsFromArray:items];
    NSMutableArray *indexPaths = [NSMutableArray new];
    for (NSInteger i = 0; i < items.count; i++) {
        NSIndexPath *sub = [NSIndexPath indexPathForRow:i + count1 inSection:0];
        [indexPaths addObject:sub];
    }
    [self.collectionView insertItemsAtIndexPaths:indexPaths];
}

- (void)didFailToLoadDataWithError:(NSError *)error {
    self.Failed = YES;
    self.Loading = NO;
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]]];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        UICollectionViewCell *loadingCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionIdentifier" forIndexPath:indexPath];
        return loadingCell;
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    UITextView *textLab = [UITextView new];
    textLab.text = [NSString stringWithFormat:@"%@", self.items[indexPath.row]];
    cell.backgroundView = textLab;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && !self.Loading) {
        [self loadDataUsingLastID:self.items.lastObject];
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 1 ? !self.Failed : self.items.count;
}

@end
