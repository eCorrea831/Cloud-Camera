//
//  DAO.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 7/5/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "DAO.h"

@interface DAO ()

@property (strong, nonatomic) FIRStorageReference * storageRef;
@property (strong, nonatomic) NSURL * fireBaseDatabaseURL;

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
        self.fireBaseDatabaseURL = [NSURL URLWithString:@"https://cameraandcloud.firebaseio.com/photos.json"];
        
        [self getCloudData];
    }
    return self;
}

- (void)getCloudData {
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.fireBaseDatabaseURL];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError * jsonError;
            NSDictionary * parsedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
            NSLog(@"%@",jsonError.localizedDescription);
            [self.imageArray removeAllObjects];

            
            NSArray * keys = [parsedData allKeys];
            for (NSString * key in keys) {
                
                NSDictionary * dict = [parsedData objectForKey:key];
                
                CloudImage * newCloudImage = [[CloudImage alloc]init];
                newCloudImage.id = key;
                newCloudImage.imageName = dict[@"name"];
                newCloudImage.numLikes = [dict[@"likes"] floatValue];
                newCloudImage.dateCreated = dict[@"date"];
                newCloudImage.commentsArray = [[NSMutableArray alloc]init];
                
                NSDictionary * comments = dict[@"comments"];
                
                for (NSString * key in comments.allKeys) {
                    
                    ImageComment * newImageComment = [[ImageComment alloc]init];
                    newImageComment.userID = comments[key][@"userID"];
                    newImageComment.commentText = comments[key][@"commentText"];
                    [newCloudImage.commentsArray addObject:newImageComment];
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

- (void)addPhotoInfoToFirebaseDatabase:(CloudImage *)cloudPhoto {
    
    [self.imageArray addObject:cloudPhoto];
    
    NSNumber * likes = [NSNumber numberWithInteger:cloudPhoto.numLikes];
    NSString * dateString = [NSString stringWithFormat:@"%@", cloudPhoto.dateCreated];
    
    NSDictionary * cloudImageDict = @{@"comments" : cloudPhoto.commentsArray, @"date" : dateString, @"likes" : likes, @"name" : cloudPhoto.imageName};
    
    NSError * error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:cloudImageDict options:0 error:&error];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:self.fireBaseDatabaseURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        if (error != nil) {
            NSLog(@"NSURLSession error: %@", error.localizedDescription);
            return;
        }
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSError * fileError = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:documentsDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&fileError];
            if (error) {
                NSLog(@"Documents Directory error: %@", fileError.localizedDescription);
            }
        }
        
        NSString * fileName = [documentsDirectory stringByAppendingFormat:@"/%@", cloudPhoto.imageName];
        NSData * fileData = UIImageJPEGRepresentation(cloudPhoto.image, 1.0);
        [fileData writeToFile:fileName atomically:YES];
        
        cloudPhoto.filePath = [NSURL URLWithString:fileName];
        
        [self addPhotoToFirebaseStorage:cloudPhoto];
    }];
    [task resume];
}

- (void)addPhotoToFirebaseStorage:(CloudImage *)cloudImage {
    
    FIRStorageReference * imageRef = [self.storageRef child:cloudImage.imageName];
    FIRStorageMetadata * metadata = [[FIRStorageMetadata alloc] initWithDictionary:@{@"contentType":@"image/jpeg"}];
    
    FIRStorageUploadTask * uploadTask = [imageRef putData:[NSData dataWithContentsOfFile:cloudImage.filePath.absoluteString] metadata:metadata completion:^(FIRStorageMetadata * metadata, NSError * error) {
        if (error != nil) {
            NSLog(@"Storage Upload Error: %@", error.localizedDescription);
        }
        #pragma unused (uploadTask)
    }];
}

- (void)updatePhotoInfoInFirebaseDatabase:(CloudImage *)cloudPhoto {

    NSString * firebaseString = [NSString stringWithFormat:@"https://cameraandcloud.firebaseio.com/photos/%@.json", cloudPhoto.id];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:firebaseString]];
    
    
    
    NSMutableDictionary *comments = [[NSMutableDictionary alloc]init];
    
    for (int i = 0; i < cloudPhoto.commentsArray.count; i++) {
        
        NSString *commentId = [NSString stringWithFormat:@"comment%d", i+1];
        ImageComment *comment = cloudPhoto.commentsArray[i];
        [comments setValue:@{@"userID":comment.userID, @"commentText": comment.commentText} forKey:commentId];
    }
    
    NSDictionary * updateDict = @{@"likes":[NSNumber numberWithInteger:cloudPhoto.numLikes], @"comments": comments};
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:updateDict options:0 error:nil];

    [request setHTTPMethod:@"PATCH"];
    [request setHTTPBody:jsonData];

    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
      }];
    [task resume];
  }

- (void)deletePhotoInfoFromFirebaseDatabase:(CloudImage *)cloudPhoto {
    
    [self.imageArray removeObject:cloudPhoto];
    
    NSString * firebaseString = [NSString stringWithFormat:@"https://cameraandcloud.firebaseio.com/photos/%@.json", cloudPhoto.id];

    NSURLSession * session = [NSURLSession sharedSession];
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:firebaseString]];

    [request setHTTPMethod:@"DELETE"];
    
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        [self deletePhotoFromFirebaseStorage:cloudPhoto];
    }];
    [task resume];
}

- (void)deletePhotoFromFirebaseStorage:(CloudImage *)cloudPhoto {

    FIRStorageReference * imageRef = [self.storageRef child:cloudPhoto.imageName];

    [imageRef deleteWithCompletion:^(NSError *error){
        if (error != nil) {
            NSLog(@"Error deleting from firebase: %@", error.localizedDescription);
        } else {
            NSLog(@"Successfully deleted image from firebase!");
        }
    }];
}

@end
