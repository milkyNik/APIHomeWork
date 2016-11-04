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
#import "UsersViewController.h"

@interface DetailTableViewController ()

@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) DetailUser* detailUser;
@property (strong, nonatomic) NSArray* usersArray;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.userId = [self.delegate getUserId];
    
    [self getUserInfoFromServer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getUserInfoFromServer {
    
    [[ServerManager sharedManager] getUserInfoByUserID:@[self.userId]
                                            withFields:@[@"city", @"photo_200"]
                                             onSuccess:^(NSArray* users) {
                                                 
                                                 self.detailUser = [users firstObject];
                                                 [self loadInfoUser:[users firstObject]];
                                                 
                                                 NSLog(@"%@", [users firstObject]);
                                                 
                                                 
                                             } onFailure:^(NSError *error) {
                                                 NSLog(@"Error = %@", [error localizedDescription]);
                                             }];
    
}

#pragma mark - Support methods

- (void) loadInfoUser:(DetailUser*) detailUser {
    
    //self.userImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:detailUser.largeImageUrl]];
    
    [self.userImage setImageWithURL:detailUser.largeImageUrl];
    
    NSString* fullName = [NSString stringWithFormat:@"%@ %@", detailUser.firstName, detailUser.lastName];
    
    self.userName.text = fullName;
    self.navigationItem.title = fullName;
    [self.tableView reloadData];
    
}

#pragma mark - Actions


- (IBAction)actionGetSubscriptions:(UIButton *)sender {
    
    NSLog(@"actionGetSubscriptions!");
    
    [[ServerManager sharedManager] getSubscriptionsByUserID:self.userId
                                                 withFields:@[@"photo_50"]
                                                  onSuccess:^(NSArray *users) {
                                                      
                                                      self.usersArray = users;
                                                      
                                                      UsersViewController* uc = [[UsersViewController alloc] initWithUsers:users];
                                                      
                                                      uc.navigationItem.title = @"Subscriptions";
                                                      
                                                      [self.navigationController pushViewController:uc animated:YES];
                                                      
                                                      
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
                                                  
                                                  self.usersArray = users;
                                                  
                                                  UsersViewController* uc = [[UsersViewController alloc] initWithUsers:users];
                                                  uc.navigationItem.title = @"Followers";
                                                  
                                                  [self.navigationController pushViewController:uc animated:YES];
                                                  
                                              } onFailure:^(NSError *error) {
                                                  
                                              }];
    
}
@end
