//
//  ServerManager.h
//  APIHomeWork
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (id) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error)) failure;

- (void) getUserInfoByUserID:(NSString*) userId
                        withFields:(NSArray*) fieldsArray
                    onSuccess:(void(^)(id user)) success
                    onFailure:(void(^)(NSError* error)) failure;

@end
