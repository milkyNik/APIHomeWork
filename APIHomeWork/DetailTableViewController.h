//
//  DetailTableViewController.h
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailDelegate;

@interface DetailTableViewController : UITableViewController

@property (strong, nonatomic) id <DetailDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;


- (IBAction)actionGetSubscriptions:(UIButton *)sender;
- (IBAction)actionGetFollowers:(UIButton *)sender;


@end

@protocol DetailDelegate <NSObject>

- (NSString*) getUserId;

@end