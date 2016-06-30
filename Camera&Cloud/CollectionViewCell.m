//
//  CollectionViewCell.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.imageView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.imageView.layer setBorderWidth:4.0];
}

@end
