//
//  PicDetailsViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "PicDetailsViewController.h"

@interface PicDetailsViewController ()

@end

@implementation PicDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.commentsTableView.layer setBorderColor:[[UIColor blackColor]CGColor]];
//    [self.commentsTableView.layer setBorderWidth:2.0];
}

-(void)viewDidAppear:(BOOL)animated {
    
    self.picImage.image = self.cloudImage.image;
    
    self.numLikes = 0;
    
    self.picCommentTextView.hidden = YES;
    self.sendButton.hidden = YES;
    
    if (self.numLikes == 0) {
        self.numLikesLabel.hidden = YES;
    } else {
        self.numLikesLabel.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)heartClicked:(id)sender {
    
    self.numLikes ++;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d likes",self.numLikes];
    self.numLikesLabel.hidden = NO;
}

- (IBAction)moreOptionsClicked:(id)sender {
    //bring up delete options
}

- (IBAction)commentClicked:(id)sender {
    
    //show textfield and send button
    self.picCommentTextView.hidden = NO;
    self.sendButton.hidden = NO;
}

- (IBAction)sendCommentClicked:(id)sender {
    
    //add comment to tableview
    self.picCommentTextView.hidden = YES;
    self.sendButton.hidden = YES;
}

@end
