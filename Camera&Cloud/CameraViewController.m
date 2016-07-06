//
//  CameraViewController.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/29/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "CameraViewController.h"
#import "CloudCollectionViewController.h"
#import "DAO.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)openCamera:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.allowsEditing = false;
        [self presentViewController:picker animated:true completion:nil];
    }
}

- (IBAction)openPhotoLibrary:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        picker.allowsEditing = true;
        [self presentViewController:picker animated:true completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    self.imagePicked = [info objectForKey:UIImagePickerControllerOriginalImage];
    CloudImage * newImage = [[CloudImage alloc]initWithImage:self.imagePicked dateCreated:[NSDate date] fileType:@"png"];
    [[[DAO sharedInstance] imageArray] addObject:newImage];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CloudCollectionViewController * cloudCollectionVC = [storyboard instantiateViewControllerWithIdentifier:@"CloudCollectionViewController"];
    
//    UINavigationController *vc = self.tabBarController.viewControllers[0];
//    
//    [self presentViewController:vc.childViewControllers[0] animated:YES completion:nil];
    //[self presentViewController:vc animated:YES completion:nil];
}

@end
