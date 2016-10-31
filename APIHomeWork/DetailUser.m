//
//  DetailUser.m
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "DetailUser.h"

@implementation DetailUser

- (id) initWithServerResponse:(NSDictionary*) dictionaryResponse
{
    self = [super initWithServerResponse:dictionaryResponse];
    if (self) {
        
        //self.userId = dictionaryResponse[@"user_id"];
        //self.firstName = dictionaryResponse[@"first_name"];
        //self.lastName = dictionaryResponse[@"last_name"];
        //self.imageUrl = [NSURL URLWithString:dictionaryResponse[@"photo_50"]];
        
        self.largeImageUrl = [NSURL URLWithString:dictionaryResponse[@"photo_200"]];
        
    }
    return self;
}

@end
