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
    
    [self.picImage.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.picImage.layer setBorderWidth:2.0];
    
    [self.commentsTableView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.commentsTableView.layer setBorderWidth:2.0];
    
    self.numLikes = 0;
    self.numDislikes = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)thumbsUpClicked:(id)sender {
    
    self.numLikes ++;
    self.numLikesLabel.text = [NSString stringWithFormat:@"%d",self.numLikes];
}

- (IBAction)thumbsDownclicked:(id)sender {
    
    self.numDislikes ++;
    self.numDislikesLabel.text = [NSString stringWithFormat:@"%d",self.numDislikes];
}

@end
