//
//  BCFirstViewController.h
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-21.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BCFirstViewController : UIViewController <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSTimer *updateIntervalTimer;
@property (nonatomic, strong) NSTimer *greenFlashTimer;
@property (nonatomic, strong) NSTimer *yellowFlashTimer;
@property (nonatomic, strong) NSTimer *redFlashTimer;
@property (nonatomic, strong) NSTimer *flashTimer;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *yellowSlider;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *yellowLabel;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UIView *flashView;

@end
