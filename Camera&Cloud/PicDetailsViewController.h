//
//  PicDetailsViewController.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudImage.h"

@interface PicDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel * picName;
@property (strong, nonatomic) IBOutlet CloudImage * picImage;
@property (weak, nonatomic) IBOutlet UITableView * commentsTableView;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numDislikesLabel;
@property (nonatomic) int numLikes;
@property (nonatomic) int numDislikes;

- (IBAction)clickedBack:(id)sender;
- (IBAction)thumbsUpClicked:(id)sender;
- (IBAction)thumbsDownclicked:(id)sender;

@end
