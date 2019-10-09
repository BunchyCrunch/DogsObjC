//
//  JSDogController.h
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSDog.h"
#import "JSSubDog.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSDogController : NSObject
@property (nonatomic, copy) NSArray <JSDog *> * posts;

+(instancetype) sharedController;

-(void)fetchDogs:(void (^)(BOOL))completion;

-(void)fetchImage:(JSDog *)name completion:(void (^)(UIImage * _Nullable))completion;

-(void)fetchImageSubDog:(JSSubDog *)subDog completion:(void(^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
