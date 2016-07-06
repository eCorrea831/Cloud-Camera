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

@property (strong, nonatomic) IBOutlet UIImageView * picImage;
@property (nonatomic, retain) CloudImage * cloudImage;
@property (weak, nonatomic) IBOutlet UITableView * commentsTableView;
@property (weak, nonatomic) IBOutlet UILabel * numLikesLabel;
@property (nonatomic) int numLikes;
@property (weak, nonatomic) IBOutlet UITextField * picCommentTextView;
@property (nonatomic) NSString * picComment;
@property (weak, nonatomic) IBOutlet UIButton * sendButton;

- (IBAction)heartClicked:(id)sender;
- (IBAction)moreOptionsClicked:(id)sender;
- (IBAction)commentClicked:(id)sender;
- (IBAction)sendCommentClicked:(id)sender;

@end
