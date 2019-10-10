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

@property (nonatomic, copy) NSArray <JSDog *> * dogs;

+(instancetype) sharedController;

-(void)fetchDogs:(void (^)(BOOL))completion;

-(void)fetchImage:(NSString *)urlString completion:(void (^)(UIImage * _Nullable))completion;

-(void)fetchImageSubDog:(NSString *)urlString completion:(void(^) (UIImage * _Nullable))completion;

-(void)fetchImageURL: (JSDog *)dog completion:(void (^) (NSString * _Nullable))completion;

-(void)fetchSubDogImageURL: (JSSubDog *)dog breedName:(NSString *)breedName completion:(void (^) (NSString * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
