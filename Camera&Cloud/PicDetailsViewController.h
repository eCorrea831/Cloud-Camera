//
//  PicDetailsViewController.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface PicDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) CloudImage * cloudImage;

- (IBAction)heartClicked:(id)sender;
- (IBAction)moreOptionsClicked:(id)sender;
- (IBAction)commentClicked:(id)sender;

@end
