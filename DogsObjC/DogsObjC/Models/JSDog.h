//
//  JSDog.h
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSDog : NSObject

@property(nonatomic, copy, readonly, nonnull)NSString *breed;
@property(nonatomic, copy, readonly, nullable)NSArray *subBreed;
@property(nonatomic, copy, readonly, nullable)NSString *image;

-(instancetype)initWithBreed:(NSString *)breed
                    subBreed:(NSArray *)subBreed
                       image:(NSString *)image;

@end
NS_ASSUME_NONNULL_END
