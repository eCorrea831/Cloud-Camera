//
//  CameraViewController.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CloudImage.h"

@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet CloudImage * imagePicked;

- (IBAction)openCamera:(id)sender;
- (IBAction)openPhotoLibrary:(id)sender;
- (IBAction)saveImage:(id)sender;

@end

