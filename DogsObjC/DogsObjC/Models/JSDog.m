//
//  JSDog.m
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSDog.h"

static NSString * const kBreedKey = @"breed";


@implementation JSDog

- (instancetype)initWithBreed:(NSString *)breed subBreed:(NSArray *)subBreed image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _breed = breed;
        _subBreed = subBreed;
        _image = image;
    }
    return self;
}

@end
