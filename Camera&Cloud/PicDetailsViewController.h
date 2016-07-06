//
//  PicDetailsViewController.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudImage.h"

@interface PicDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIImageView * picImage;
@property (nonatomic, retain) CloudImage * cloudImage;
@property (weak, nonatomic) IBOutlet UITableView * commentsTableView;
@property (weak, nonatomic) IBOutlet UILabel * numLikesLabel;
@property (weak, nonatomic) IBOutlet UITextField * picCommentTextField;
@property (nonatomic) NSString * picComment;
@property (weak, nonatomic) IBOutlet UIButton * heartButton;

- (IBAction)heartClicked:(id)sender;
- (IBAction)moreOptionsClicked:(id)sender;
- (IBAction)commentClicked:(id)sender;

@end
