//
//  DetailTableViewController.m
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ServerManager.h"
#import "DetailUser.h"

@interface DetailTableViewController ()

@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) DetailUser* detailUser;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userId = [self.delegate getUserId];
    
    //NSLog(@"user_id = %@", self.userId);
    
    //self.navigationItem.title = @"Test";
    
    //self.userName.text = @"Test text";
    
    [self getUserInfoFromServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getUserInfoFromServer {
    
    [[ServerManager sharedManager] getUserInfoByUserID:self.userId
                                            withFields:@[@"city", @"photo_200"]
                                             onSuccess:^(id user) {
                                                 
                                                 self.detailUser = user;
                                                 [self loadInfoUser:user];
                                                 
                                                 NSLog(@"%@", user);
                                                 
                                                 
                                             } onFailure:^(NSError *error) {
                                                 NSLog(@"Error = %@", [error localizedDescription]);
                                             }];
    
}

#pragma mark - Support methods

- (void) loadInfoUser:(DetailUser*) detailUser {
    
    //self.userImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:detailUser.largeImageUrl]];
    
    [self.userImage setImageWithURL:detailUser.largeImageUrl];
    
    self.userName.text = [NSString stringWithFormat:@"%@ %@", detailUser.firstName, detailUser.lastName];
    
    [self.tableView reloadData];
    
    //self.navigationItem.title = detailUser.userId;
    
    
}

#pragma mark - Actions


- (IBAction)actionGetSubscriptions:(UIButton *)sender {
    
    NSLog(@"actionGetSubscriptions!");
    
    [[ServerManager sharedManager] getSubscriptionsByUserID:self.userId
                                                 withFields:@[@"photo_50"]
                                                  onSuccess:^(NSArray *users) {
                                                      
                                                  } onFailure:^(NSError *error) {
                                                      
                                                  }];
   
    
}

- (IBAction)actionGetFollowers:(UIButton *)sender {
    
    NSLog(@"actionGetFollowers!");
    
    [[ServerManager sharedManager] getFollowersByUserID:self.userId
                                             withFields:@[@"photo_50"]
                                                 offset:0
                                                  count:20
                                              onSuccess:^(NSArray *users) {
                                                  
                                              } onFailure:^(NSError *error) {
                                                  
                                              }];
    
}
@end
