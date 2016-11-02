//
//  UsersViewController.h
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ViewController.h"

@protocol UsersViewDelegate;

@interface UsersViewController : ViewController

@property (strong, nonatomic) id <UsersViewDelegate> delegate;

@end

@protocol UsersViewDelegate <NSObject>

- (NSArray*) getUsersId;

@end