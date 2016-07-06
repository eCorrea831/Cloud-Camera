//
//  TableViewCell.h
//  Camera&Cloud
//
//  Created by Erica Correa on 7/6/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel * userNameLabel;
@property (weak, nonatomic) IBOutlet UITextView * pictureCommentTextView;

@end
