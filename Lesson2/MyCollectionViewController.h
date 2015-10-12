//
//  MyCollectionViewController.h
//  Lesson2
//
//  Created by Azat Almeev on 01.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewController : UICollectionViewController
@property (nonatomic) NSMutableArray *items;
@property BOOL Loading;
@property BOOL Failed;
@end
