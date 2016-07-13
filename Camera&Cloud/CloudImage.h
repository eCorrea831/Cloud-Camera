//
//  CloudImage.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/30/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudImage : NSObject

@property (nonatomic, retain) UIImage * image;
@property (nonatomic) int numLikes;
@property (retain, nonatomic) NSMutableArray <NSString*> * commentsArray;
@property (retain, nonatomic) NSString * imageName;
@property (retain, nonatomic) NSDate * dateCreated;

- (instancetype)initWithImage:(UIImage *)image dateCreated:(NSDate *)dateCreated;

@end
