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
@property (strong, nonatomic) NSURL * fireBaseURL;
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
        self.fireBaseURL = [NSURL URLWithString:@"https://cameraandcloud.firebaseio.com/photos.json"];
        [self getCloudData];
    }
    return self;
}

- (void)getCloudData {
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.fireBaseURL];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError * jsonError;
            //issue here
            NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSLog(@"%@",jsonError.localizedDescription);
            [self.imageArray removeAllObjects];

            for (NSDictionary * dict in parsedData) {
                
                CloudImage * newCloudImage = [[CloudImage alloc]init];
                newCloudImage.imageName = parsedData[dict][@"name"];
                newCloudImage.numLikes = [parsedData[dict][@"likes"] floatValue];
                newCloudImage.dateCreated = parsedData[dict][@"date"];
                newCloudImage.commentsArray = [[NSMutableArray alloc]init];
                for (NSString * comment in parsedData[dict][@"comments"]) {
                //TODO:get comments
                    [newCloudImage.commentsArray addObject:parsedData[dict][@"comments"][comment]];
                    NSLog(@"%@", newCloudImage.commentsArray);
                }

                [self getPhotoFromFirebaseStorageForCloudImage:newCloudImage];
                [self.imageArray addObject:newCloudImage];
            }
        });
    }];
    [task resume];
}

- (void)getPhotoFromFirebaseStorageForCloudImage:(CloudImage *)cloudImage {
    
    self.storageRef = [[FIRStorage storage] reference];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * filePath = [NSString stringWithFormat:@"file:%@/%@", documentsDirectory, cloudImage.imageName];
    NSString * filePath2 = [NSString stringWithFormat:@"%@/%@", documentsDirectory, cloudImage.imageName];
    
    [[self.storageRef child:cloudImage.imageName] writeToFile:[NSURL URLWithString:filePath] completion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error downloading: %@", error);
            return;
        }
        NSData * data = [[NSData alloc]initWithContentsOfFile:filePath2];
        cloudImage.image = [UIImage imageWithData:data];
        [self reloadCollectionVCWithFireBasePhotos];
    }];
}

- (void)reloadCollectionVCWithFireBasePhotos {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Update" object:self userInfo:nil];
}

- (void)addPhotoToFirebaseStorage:(CloudImage *)cloudPhoto {
    //TODO:use to add new photos to firebase
}

- (void)updatePhotoInFirebaseStorage:(CloudImage *)cloudPhoto {
    //TODO:use for updating with likes and comments
}

- (void)deletePhotoFromFirebaseStorage:(CloudImage *)cloudPhoto {
    //TODO:use for deleting photos
}

@end
