//
//  CloudImage.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/30/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageComment.h"

@interface CloudImage : NSObject

@property (retain, nonatomic) NSString * id;
@property (retain, nonatomic) UIImage * image;
@property (nonatomic) int numLikes;
@property (retain, nonatomic) NSMutableArray <ImageComment*> * commentsArray;
@property (retain, nonatomic) NSString * imageName;
@property (retain, nonatomic) NSDate * dateCreated;
@property (retain, nonatomic) NSString * createdBy;
@property (retain, nonatomic) NSURL * filePath;

- (instancetype)initWithImage:(UIImage *)image dateCreated:(NSDate *)dateCreated;

@end
