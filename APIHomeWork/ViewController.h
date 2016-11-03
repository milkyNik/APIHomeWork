//
//  ViewController.h
//  APIHomeWork
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTableViewController.h"

@interface ViewController : UITableViewController <DetailDelegate>

@property (strong, nonatomic) NSMutableArray* friendsArray;

@end

