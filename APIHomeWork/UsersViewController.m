//
//  UsersViewController.m
//  APIHomeWork
//
//  Created by iMac on 31.10.16.
//  Copyright © 2016 hata. All rights reserved.
//

#import "UsersViewController.h"
#import "User.h"
#import "DetailUser.h"
#import "UIImageView+AFNetworking.h"
#import "ServerManager.h"

@interface UsersViewController ()

@property (strong, nonatomic) NSString* selectedUserId;
@property (strong, nonatomic) NSMutableArray* usersArray;
@end

@implementation UsersViewController

- (instancetype)initWithUsers:(NSArray*) usersArray
{
    self = [super init];
    if (self) {
        
        self.usersArray = [NSMutableArray arrayWithArray:usersArray];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.usersArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    
        User* user = self.usersArray[indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
        //cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:user.imageUrl]];
        [cell.imageView setImageWithURL:user.imageUrl];
 
    return cell;
}




@end
