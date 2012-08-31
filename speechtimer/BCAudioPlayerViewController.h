//
//  BCAudioPlayerViewController.h
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-22.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

@interface BCAudioPlayerViewController : UIViewController

@property (nonatomic, strong) MPMoviePlayerController *player;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withAudioFileURL:(NSURL *)audioFileURL;
@end
