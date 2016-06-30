//
//  PicDetailsViewController.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel * picName;
@property (weak, nonatomic) IBOutlet UIImageView * picImage;
@property (weak, nonatomic) IBOutlet UITableView * commentsTableView;

- (IBAction)thumbsUpClicked:(id)sender;
- (IBAction)thumbsDownclicked:(id)sender;

@end
