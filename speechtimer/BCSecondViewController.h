//
//  BCSecondViewController.h
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-21.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCTableViewDataSource.h"

@class MPMoviePlayerViewController;

@interface BCSecondViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) BCTableViewDataSource *tableViewDataSource;
@property (strong, nonatomic) MPMoviePlayerViewController *movieViewController;
@end
