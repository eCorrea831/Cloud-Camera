//
//  DAO.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 7/5/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

// FIRStorage * storage = [FIRStorage storage];
// FIRStorageReference *storageRef = [storage referenceForURL:@"gs://cameraandcloud.appspot.com"];

// Create a child reference
// imagesRef now points to "images"
// FIRStorageReference *imagesRef = [storageRef child:@"images"];
// Child references can also take paths delimited by '/'
// spaceRef now points to "images/space.jpg"
// imagesRef still points to "images"
// FIRStorageReference *spaceRef = [storageRef child:@"images/space.jpg"];

// This is equivalent to creating the full reference
// FIRStorageReference *spaceRef = [storage referenceForURL:@"gs://<your-firebase-storage-bucket>/images/space.jpg"];

// Parent allows us to move to the parent of a reference
// imagesRef now points to 'images'
// FIRStorageReference *imagesRef = [spaceRef parent];
// Root allows us to move all the way back to the top of our bucket
// rootRef now points to the root
// FIRStorageReference *rootRef = [spaceRef root];

// References can be chained together multiple times
// earthRef points to "images/earth.jpg"
// FIRStorageReference *earthRef = [[spaceRef parent] child:@"earth.jpg"];
// nilRef is nil, since the parent of root is nil
// FIRStorageReference *nilRef = [[spaceRef root] parent];

// Reference's path is: "images/space.jpg"
// This is analogous to a file path on disk
// spaceRef.fullPath;
// Reference's name is the last segment of the full path: "space.jpg"
// This is analogous to the file name
// spaceRef.name;

// Reference's bucket is the name of the storage bucket where files are stored
// spaceRef.bucket;

#import "DAO.h"

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
        [self loadData];
    }
    return self;
}

- (void)loadData {

    CloudImage * imageView1 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_01"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView1];
    CloudImage * imageView2 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_02"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView2];
    CloudImage * imageView3 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_03"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView3];
    CloudImage * imageView4 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_04"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView4];
    CloudImage * imageView5 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_05"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView5];
    CloudImage * imageView6 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_06"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView6];
    CloudImage * imageView7 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_07"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView7];
    CloudImage * imageView8 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_08"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView8];
    CloudImage * imageView9 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_09"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView9];
    CloudImage * imageView10 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_10"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView10];
    CloudImage * imageView11 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_11"] dateCreated:[NSDate date] fileType:@"png"];
     [self.imageArray addObject:imageView11];
    CloudImage * imageView12 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_12"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView12];
    CloudImage * imageView13 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_13"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView13];
    CloudImage * imageView14 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_14"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView14];
    CloudImage * imageView15 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_15"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView15];
    CloudImage * imageView16 = [[CloudImage alloc]initWithImage:[UIImage imageNamed:@"photo_16"] dateCreated:[NSDate date] fileType:@"png"];
    [self.imageArray addObject:imageView16];
}

@end
