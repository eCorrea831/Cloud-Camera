//
//  CloudImage.h
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/30/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudImage : UIImageView

@property (retain, nonatomic) NSString * name;
@property (nonatomic) int numLikes;
@property (nonatomic) int numDislikes;
@property (retain, nonatomic) NSMutableArray * commentsArray;
@property (retain, nonatomic) NSString * reference;
@property (retain, nonatomic) NSDate * dateCreated;
@property (retain, nonatomic) NSString * fileType;

- (instancetype)initWithImage:(UIImage *)image name:(NSString *)name dateCreated:(NSDate *)dateCreated fileType:(NSString *)fileType;

@end
