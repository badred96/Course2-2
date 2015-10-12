//
//  IndicatorTableViewCell.m
//  Lesson2
//
//  Created by Admin on 06.10.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "IndicatorTableViewCell.h"

@implementation IndicatorTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setActInd:(UIApplication *)app{
    UIApplication* appIn = [UIApplication sharedApplication];
    appIn.networkActivityIndicatorVisible = YES;
}

@end
