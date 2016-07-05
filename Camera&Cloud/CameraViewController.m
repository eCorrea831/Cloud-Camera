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

@property (nonatomic, retain) CloudCollectionViewController * cloudCollectionVC;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.cloudCollectionVC = [storyboard instantiateViewControllerWithIdentifier:@"CloudCollectionViewController"];
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
    
    //FIXME:Image is nil
    //self.imagePicked.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    DAO * dao = [DAO sharedInstance];
    //[dao.imageArray addObject:self.imagePicked];
    [self.navigationController pushViewController:self.cloudCollectionVC animated:YES];

    //[self dismissViewControllerAnimated:true completion:nil];
}

@end
