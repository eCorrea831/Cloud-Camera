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
@property (strong, nonatomic) NSURL * fireBaseStorageURL;

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
        self.fireBaseStorageURL = [NSURL URLWithString:@"gs://cameraandcloud.appspot.com/"];
        
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

            for (NSDictionary * dict in parsedData) {
                
                CloudImage * newCloudImage = [[CloudImage alloc]init];
                newCloudImage.imageName = parsedData[dict][@"name"];
                newCloudImage.numLikes = [parsedData[dict][@"likes"] floatValue];
                newCloudImage.dateCreated = parsedData[dict][@"date"];
                newCloudImage.commentsArray = [[NSMutableArray alloc]init];
                
                for (NSString * comment in parsedData[dict][@"comments"]) {
                    ImageComment * newImageComment = [[ImageComment alloc]init];
                    newImageComment.userID = parsedData[dict][@"comments"][comment][@"userID"];
                    newImageComment.comment = parsedData[dict][@"comments"][comment][@"commentText"];
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
    NSString * imageName = [cloudPhoto.imageName stringByAppendingString:@".jpg"];
    
    NSDictionary * cloudImageDict = @{@"comments" : cloudPhoto.commentsArray, @"date" : dateString, @"likes" : likes, @"name" : imageName};
    
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
        
        NSString * fileName = [documentsDirectory stringByAppendingFormat:@"/%@", imageName];
        NSData * fileData = UIImageJPEGRepresentation(cloudPhoto.image, 1.0);
        [fileData writeToFile:fileName atomically:YES];
        
        cloudPhoto.filePath = [NSURL URLWithString:fileName];
        
        [self addPhotoToFirebaseStorage:cloudPhoto];
    }];
    [task resume];
}

- (void)addPhotoToFirebaseStorage:(CloudImage *)cloudImage {
    

    NSString * imageString = [NSString stringWithFormat:@"%@.jpg", cloudImage.imageName];
    FIRStorageReference * imageRef = [self.storageRef child:imageString];
    
    FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc] initWithDictionary:@{@"contentType":@"image/jpeg"}];
    
    FIRStorageUploadTask * uploadTask = [imageRef putData:[NSData dataWithContentsOfFile:cloudImage.filePath.absoluteString] metadata:metadata completion:^(FIRStorageMetadata * metadata, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSURL * downloadURL = metadata.downloadURL;
        }
    }];
}

- (void)updatePhotoInfoInFirebaseDatabase:(CloudImage *)cloudPhoto {
    
}

- (void)deletePhotoInfoFromFirebaseDatabase:(CloudImage *)cloudPhoto {
    
}

- (void)deletePhotoFromFirebaseStorage:(CloudImage *)cloudPhoto {

    [self.imageArray removeObject:cloudPhoto];
}

@end
