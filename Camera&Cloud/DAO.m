//
//  DAO.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 7/5/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "DAO.h"
#import "Firebase.h"

@interface DAO ()

@property (strong, nonatomic) FIRStorageReference * storageRef;

@end

@implementation DAO

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithData];
    });
    
    return sharedInstance;
}

- (instancetype)initWithData {
    
    self.imageArray = [[NSMutableArray alloc] init];
    
    self = [super init];
    if (self) {
        [self getPhotosFromFirebaseStorage];
    }
    return self;
}

- (void)getPhotosFromFirebaseStorage {
    
    self.storageRef = [[FIRStorage storage] reference];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * filePath = [NSString stringWithFormat:@"file:%@/photo_07@3x.jpg", documentsDirectory];
    NSString * filePath2 = [NSString stringWithFormat:@"%@/photo_07@3x.jpg", documentsDirectory];
    
    [[self.storageRef child:@"photo_07@3x.jpg"] writeToFile:[NSURL URLWithString:filePath] completion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
         if (error) {
             NSLog(@"Error downloading: %@", error);
             return;
         }
        NSData * data = [[NSData alloc]initWithContentsOfFile:filePath2];
        CloudImage * cloudImage1 = [[CloudImage alloc]initWithImage:[UIImage imageWithData:data] dateCreated:[NSDate date]];

        cloudImage1.imageName = @"photo_07@3x.jpg";
        [self.imageArray addObject:cloudImage1];
        [self reloadCollectionVCWithFireBasePhotos];
     }];
    NSLog(@"THE FILE PATH IS: %@", filePath);
}

- (void)reloadCollectionVCWithFireBasePhotos {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Update" object:self userInfo:nil];
}

- (void)loadData {

    CloudImage * imageView1 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_01"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView1];
    CloudImage * imageView2 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_02"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView2];
    CloudImage * imageView3 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_03"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView3];
    CloudImage * imageView4 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_04"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView4];
    CloudImage * imageView5 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_05"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView5];
    CloudImage * imageView6 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_06"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView6];
    CloudImage * imageView7 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_07"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView7];
    CloudImage * imageView8 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_08"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView8];
    CloudImage * imageView9 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_09"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView9];
    CloudImage * imageView10 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_10"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView10];
    CloudImage * imageView11 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_11"] dateCreated:[NSDate date]];
     [self.imageArray addObject:imageView11];
    CloudImage * imageView12 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_12"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView12];
    CloudImage * imageView13 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_13"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView13];
    CloudImage * imageView14 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_14"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView14];
    CloudImage * imageView15 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_15"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView15];
    CloudImage * imageView16 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_16"] dateCreated:[NSDate date]];
    [self.imageArray addObject:imageView16];
}

@end
