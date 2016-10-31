//
//  ViewController.m
//  APIHomeWork
//
//  Created by iMac on 30.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "ViewController.h"
#import "ServerManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

static NSInteger friendsInRequest = 20;

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.friendsArray = [NSMutableArray array];
    [self getFriendsFromServer];
    
}

#pragma mark - API

- (void) getFriendsFromServer {
    
    [[ServerManager sharedManager] getFriendsWithOffset:[self.friendsArray count]
                                                  count:friendsInRequest
                                              onSuccess:^(NSArray *friends) {
                                                  
                                                  [self.friendsArray addObjectsFromArray:friends];
                                                  
                                                  NSMutableArray* newPaths = [NSMutableArray array];
                                                  
                                                  for (int i = (int)[self.friendsArray count] - (int)[friends count]; i < [self.friendsArray count]; i++) {
                                                      [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                                                  }
                                                  
                                                  [self.tableView beginUpdates];
                                                  
                                                  [self.tableView insertRowsAtIndexPaths:newPaths
                                                                        withRowAnimation:UITableViewRowAnimationTop];
                                                  
                                                  [self.tableView endUpdates];
                                                  
                                              }
                                              onFailure:^(NSError *error) {
                                                  NSLog(@"Error = %@", [error localizedDescription]);
                                              }];
    
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.friendsArray count] + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (indexPath.row == [self.friendsArray count]) {
        cell.textLabel.text = @"LOAD MORE";
        cell.imageView.image = nil;
    } else {
        
        User* user = self.friendsArray[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:user.imageUrl]];
        //[cell.imageView setImageWithURL:user.imageUrl];
        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
    
}

@end
