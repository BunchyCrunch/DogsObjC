//
//  JSSubDog.h
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSSubDog : NSObject


@property(nonatomic, copy, readonly, nonnull)NSString *name;
@property(nonatomic, copy, readonly, nullable)NSString *image;

-(instancetype)initWithSubBreed:(NSString *)name image:(NSString *)image;

@end

NS_ASSUME_NONNULL_END
