//
//  BCAudioPlayerViewController.m
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-22.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import "BCAudioPlayerViewController.h"

@interface BCAudioPlayerViewController ()

@end

@implementation BCAudioPlayerViewController

@synthesize player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAudioFileURL:(NSURL *)audioFileURL
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        
        //load audio file
        player = [[MPMoviePlayerController alloc] initWithContentURL: audioFileURL];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [player prepareToPlay];
    [player.view setFrame: self.view.bounds];  // player's frame must match parent's
    [self.view addSubview: player.view];
}

-(void)viewWillAppear:(BOOL)animated
{
    [player play];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
