//
//  DAO.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 7/5/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudImage.h"

@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray <CloudImage*> * imageArray;

+ (DAO *)sharedInstance;

- (void)addPhotoToFirebaseStorage:(CloudImage *)cloudPhoto;
- (void)updatePhotoInFirebaseStorage:(CloudImage *)cloudPhoto;
- (void)deletePhotoFromFirebaseStorage:(CloudImage *)cloudPhoto;

@end
