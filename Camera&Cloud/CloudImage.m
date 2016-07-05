//
//  CloudImage.m
//  Camera&Cloud
//
//  Created by Aditya Narayan on 6/30/16.
//  Copyright © 2016 TurnToTech. All rights reserved.
//

#import "CloudImage.h"

@implementation CloudImage

- (instancetype)initWithImage:(UIImage *)image dateCreated:(NSDate *)dateCreated fileType:(NSString *)fileType {
    
    self = [super init];
    
    if (self) {
        _image = image;
        _dateCreated = dateCreated;
        _fileType = fileType;
        
        _numLikes = 0;
        _commentsArray = [[NSMutableArray alloc]init];
        
        return self;
    }
    return nil;
}

@end
