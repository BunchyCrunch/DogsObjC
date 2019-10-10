//
//  JSDogController.m
//  DogsObjC
//
//  Created by Josh Sparks on 10/9/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

#import "JSDogController.h"
#import "JSDog.h"
#import "JSSubDog.h"

@implementation JSDogController

static NSString * const kBaseURLString = @"https://dog.ceo/api/";
static NSString * const kBreedsComponentString = @"breeds";
static NSString * const kListAllComponentString = @"list/all";

static NSString * const kBreedImageComponentString = @"breed";
static NSString * const kImageRandomString = @"images/random";

+(instancetype)sharedController
{
    static JSDogController * sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [JSDogController new];
    });
    return sharedController;
}

-(void)fetchDogs:(void (^)(BOOL))completion
{
    NSURL * url = [NSURL URLWithString:kBaseURLString];
    NSURL * breedsURL = [url URLByAppendingPathComponent:kBreedsComponentString];
    NSURL * finalURL = [breedsURL URLByAppendingPathComponent:kListAllComponentString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching dog: %@", error);
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            NSDictionary * topLevelDict = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (error)
            {
                NSLog(@"Error parsing JSON data: %@", [error localizedDescription]);
                completion(false);
                return;
            }
            
            NSDictionary * messageDictionary = topLevelDict[@"message"];
            
            NSMutableArray *arrayOfBreeds = [NSMutableArray new];
            for (id key in messageDictionary)
            {
                NSMutableArray *subBreeds = [NSMutableArray new ];
                for (NSString *name in messageDictionary[key])
                {
                    JSSubDog *subBreed = [[JSSubDog alloc] initWithSubBreed:name image:[NSString new]];
                    [subBreeds addObject:subBreed];
                }
                JSDog *breed = [[JSDog alloc] initWithBreed:key subBreed:subBreeds image:[NSString new]];
                [arrayOfBreeds addObject:breed];
            }
            JSDogController.sharedController.dogs = arrayOfBreeds;
            completion(true);
        }
        
    }]resume];
}

- (void)fetchImage:(NSString *)urlString completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *finalURL = [NSURL URLWithString:urlString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching image: %@", error);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error with image data");
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}


- (void)fetchImageSubDog:(NSString *)urlString completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *finalURL = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching image: %@", error);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error with image data");
            completion(nil);
            return;
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    }] resume];
}

// When you fetchImage, it brings you to a page with more data. This data contains a dictionary with key = "message" and value = the image URL. This is because when you use the randomize URL, it provides a new picture URL. The fetchImageURL function parses though this data. 
- (void)fetchImageURL:(JSDog *)dog completion:(void (^)(NSString * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:kBaseURLString];
    NSURL *breedURL = [imageURL URLByAppendingPathComponent:kBreedImageComponentString];
    NSURL *breedNameURL = [breedURL URLByAppendingPathComponent:dog.breed];
    NSURL *finalURL = [breedNameURL URLByAppendingPathComponent:kImageRandomString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching image: %@", error);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error with image data");
            completion(nil);
            return;
        }
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        NSString *urlString = dictionary[@"message"];
        completion(urlString);
        
    }]resume];
}

- (void)fetchSubDogImageURL:(JSSubDog *)dog breedName:(NSString *)breedName completion:(void (^)(NSString * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:kBaseURLString];
    NSURL *breedURL = [imageURL URLByAppendingPathComponent:kBreedImageComponentString];
    NSURL *breedNameURL = [breedURL URLByAppendingPathComponent:breedName];
    NSURL *subBreedNameURL = [breedNameURL URLByAppendingPathComponent:dog.name];
    NSURL *finalURL = [subBreedNameURL URLByAppendingPathComponent:kImageRandomString];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error fetching image: %@", error);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error with image data");
            completion(nil);
            return;
        }
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        NSString *urlString = dictionary[@"message"];
        completion(urlString);
        
    }]resume];
}
@end
