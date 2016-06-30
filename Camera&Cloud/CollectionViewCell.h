//
//  CollectionViewCell.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudImage.h"

@interface CollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet CloudImage * imageView;

@end
