//
//  DAO.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 7/5/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudImage.h"
#import "Firebase.h"

@interface DAO : NSObject

@property (retain, nonatomic) NSMutableArray <CloudImage*> * imageArray;

+ (DAO *)sharedInstance;
- (void)addPhotoInfoToFirebaseDatabase:(CloudImage *)cloudPhoto;
- (void)updatePhotoInfoInFirebaseDatabase:(CloudImage *)cloudPhoto;
- (void)deletePhotoInfoFromFirebaseDatabase:(CloudImage *)cloudPhoto;

@end
