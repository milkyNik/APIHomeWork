//
//  UsersViewController.h
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ViewController.h"

@interface UsersViewController : UITableViewController

@property (strong, nonatomic) NSArray* usersIdArray;

- (instancetype)initWithUsers:(NSArray*) usersArray;

@end

