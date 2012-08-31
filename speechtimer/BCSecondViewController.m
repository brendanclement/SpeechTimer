//
//  BCSecondViewController.m
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-21.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "BCSecondViewController.h"
#import "BCAudioPlayerViewController.h"

@interface BCSecondViewController ()

@end

@implementation BCSecondViewController
@synthesize tableView;
@synthesize movieViewController;
@synthesize tableViewDataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Recordings", @"Recordings");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
        tableViewDataSource = [[BCTableViewDataSource alloc] init];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = tableViewDataSource;
}

-(void)viewWillAppear:(BOOL)animated
{
    [tableViewDataSource reloadData];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - tableviewdelegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = [[tableViewDataSource recordings] objectAtIndex:indexPath.row];
    
    self.movieViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[documentsDirectory stringByAppendingPathComponent:filename]]];
    [self presentMoviePlayerViewControllerAnimated:movieViewController];
}

@end
