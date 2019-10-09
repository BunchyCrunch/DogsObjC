//
//  JSSubDog.m
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSSubDog.h"

@implementation JSSubDog

- (instancetype)initWithSubBreed:(NSString *)name image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _name = name;
        _image = image;
    }
    return self;
}
@end
