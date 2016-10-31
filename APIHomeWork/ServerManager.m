//
//  ServerManager.m
//  APIHomeWork
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "User.h"

@interface ServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager* requestSessionManager;

@end

@implementation ServerManager

+ (id) sharedManager {
    
    static ServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL* baseUrl = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl];
        
    }
    return self;
}

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error)) failure {
    
    NSDictionary* params = @{
                             @"user_id"     : @"10588945",
                             @"order"       : @"name",
                             @"fields"      : @"photo_50",
                             @"count"       : @(count),
                             @"offset"      : @(offset)};
    
    [self.requestSessionManager GET:@"friends.get" parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        NSArray* dictionarysArray = [responseObject objectForKey:@"response"];
        
        NSMutableArray* objectsArray = [NSMutableArray array];
        
        for (NSDictionary* dictionary in dictionarysArray) {
            
            User* user = [[User alloc] initWithServerResponse:dictionary];
            
            [objectsArray addObject:user];
            
        }
        
        if (success) {
            
            success(objectsArray);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        if (failure) {
            failure(error);
        }
        
    }];

    
}

@end
