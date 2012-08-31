//
//  BCFirstViewController.m
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-21.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import "BCFirstViewController.h"

@interface BCFirstViewController ()

@end

@implementation BCFirstViewController

@synthesize recorder;
@synthesize timerLabel;
@synthesize recordButton;
@synthesize stopButton;
@synthesize greenSlider;
@synthesize yellowSlider;
@synthesize redSlider;
@synthesize greenLabel;
@synthesize yellowLabel;
@synthesize redLabel;
@synthesize flashView;
@synthesize updateIntervalTimer;
@synthesize greenFlashTimer;
@synthesize redFlashTimer;
@synthesize yellowFlashTimer;
@synthesize flashTimer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Record", @"Record");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)updateTimer
{
    NSTimeInterval currentTime = [recorder currentTime];
    div_t m = div(currentTime, 60);
    int minutes = m.quot;
    int seconds = m.rem;
    
    if(seconds < 10)
        timerLabel.text = [NSString stringWithFormat:@"%d:0%d", minutes, seconds];
    else
        timerLabel.text = [NSString stringWithFormat:@"%d:%d", minutes, seconds];
    NSLog(@"updating timer to %d %d", minutes, seconds);
}

-(IBAction)startRecording:(id)sender
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //recorder settings
    NSString *fileName = [NSString stringWithFormat:@"%f-recording.caf",[[NSDate date] timeIntervalSince1970]];
    NSURL *recordingURL = [NSURL URLWithString:[documentsDirectory stringByAppendingPathComponent:fileName]];
    NSDictionary *recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:kAudioFormatAppleIMA4],AVFormatIDKey,
                                         [NSNumber numberWithInt:16000],AVSampleRateKey,
                                         [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                                         nil];
    
    //create an Audio Recorder object
    NSError *error;
    recorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:recorderSettingsDict error:&error];
    if(recorder == nil)
    {
        NSLog(@"Error creating recorder: %@", error);
    }
    recorder.delegate = self;
    [recorder prepareToRecord];
    
    //Hide the sliders
    redSlider.hidden = YES;
    yellowSlider.hidden = YES;
    greenSlider.hidden = YES;
    redLabel.hidden = YES;
    yellowLabel.hidden = YES;
    greenLabel.hidden = YES;
    
    //show the timer
    self.timerLabel.hidden = NO;
    
    //hide the record button
    recordButton.hidden = YES;
    
    //show the stop button
    stopButton.hidden = NO;
    
    [recorder record];
    
    //invalidate timers
    [updateIntervalTimer invalidate];
    [greenFlashTimer invalidate];
    [yellowFlashTimer invalidate];
    [redFlashTimer invalidate];
    [flashTimer invalidate];
    self.updateIntervalTimer = nil;
    self.flashTimer = nil;
    self.greenFlashTimer = nil;
    self.yellowFlashTimer = nil;
    self.redFlashTimer = nil;
    
    //re-create timers
    self.updateIntervalTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    self.greenFlashTimer = [NSTimer scheduledTimerWithTimeInterval:floor(greenSlider.value)*60 target:self selector:@selector(flashView:) userInfo:[UIColor greenColor] repeats:NO];
    self.yellowFlashTimer = [NSTimer scheduledTimerWithTimeInterval:floor(yellowSlider.value)*60 target:self selector:@selector(flashView:) userInfo:[UIColor yellowColor] repeats:NO];
    self.flashTimer = [NSTimer scheduledTimerWithTimeInterval:floor(redSlider.value)*60-15 target:self selector:@selector(continuousFlash:) userInfo:[UIColor yellowColor] repeats:NO];
    self.redFlashTimer = [NSTimer scheduledTimerWithTimeInterval:floor(redSlider.value)*60 target:self selector:@selector(flashView:) userInfo:[UIColor redColor] repeats:NO];
}

-(IBAction)stopRecording:(id)sender
{
    //invalidate timers
    if([updateIntervalTimer isValid])
        [updateIntervalTimer invalidate];
    if([greenFlashTimer isValid])
        [greenFlashTimer invalidate];
    if([yellowFlashTimer isValid])
        [yellowFlashTimer invalidate];
    if([redFlashTimer isValid])
        [redFlashTimer invalidate];
    if([flashTimer isValid])
        [flashTimer invalidate];
    self.updateIntervalTimer = nil;
    self.flashTimer = nil;
    self.greenFlashTimer = nil;
    self.yellowFlashTimer = nil;
    self.redFlashTimer = nil;
    
    //show the record button
    recordButton.hidden = NO;
    
    //hide the stop button
    stopButton.hidden = YES;
    
    //hide the timer
    self.timerLabel.hidden = YES;
    
    //show the sliders
    redSlider.hidden = NO;
    yellowSlider.hidden = NO;
    greenSlider.hidden = NO;
    redLabel.hidden = NO;
    yellowLabel.hidden = NO;
    greenLabel.hidden = NO;
    
    //stop flashing view from appearing
    flashView.backgroundColor = [UIColor whiteColor];
    
    //stop the recording
    [recorder stop];
}

#pragma - timer selectors

-(void)flashView:(NSTimer *)aTimer
{
    UIColor *colorToFlash = aTimer.userInfo;
    flashView.backgroundColor = colorToFlash;
    flashView.hidden = NO;
}

-(void)continuousFlash:(NSTimer *)aTimer
{
    UIColor *colorToFlash = aTimer.userInfo;
    flashView.backgroundColor = colorToFlash;
    flashView.hidden = NO;
    flashView.alpha = 1.0f;
    [UIView animateWithDuration:0.5f
                          delay:0.0f
                        options:UIViewAnimationOptionAutoreverse
                     animations:^
     {
         [UIView setAnimationRepeatCount:30.0f/2.0f];
         flashView.alpha = 0.0f;
     }
                     completion:^(BOOL finished)
     {
         flashView.alpha = 1.0;
     }];
}

#pragma - Sliders

-(IBAction)sliderMoved:(UISlider *)sender
{
    if(sender == greenSlider)
    {
        if(greenSlider.value > yellowSlider.value)
        {
            yellowSlider.value = greenSlider.value;
        }
        if(greenSlider.value > redSlider.value)
        {
            redSlider.value = greenSlider.value;
        }
    }
    else if(sender == yellowSlider)
    {
        if(yellowSlider.value < greenSlider.value)
        {
            greenSlider.value = yellowSlider.value;
        }
        if(yellowSlider.value > redSlider.value)
        {
            redSlider.value = yellowSlider.value;
        }
    }
    else if(sender == redSlider)
    {
        if(redSlider.value < yellowSlider.value)
        {
            yellowSlider.value = redSlider.value;
        }
        if(redSlider.value < greenSlider.value)
        {
            greenSlider.value = redSlider.value;
        }
    }
    greenLabel.text = [NSString stringWithFormat:@"%d", (int)greenSlider.value];
    yellowLabel.text = [NSString stringWithFormat:@"%d", (int)yellowSlider.value];
    redLabel.text = [NSString stringWithFormat:@"%d", (int)redSlider.value];
}

#pragma - AVAudioRecordingDelegate methods
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    NSLog(@"finished recording success: %d", flag);
}

-(void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error
{
    NSLog(@"Encoding error did occur %@", error);
}

- (void)viewDidUnload
{
    [self setTimerLabel:nil];
    [self setRecordButton:nil];
    [self setGreenSlider:nil];
    [self setYellowSlider:nil];
    [self setRedSlider:nil];
    [self setGreenLabel:nil];
    [self setYellowLabel:nil];
    [self setRedLabel:nil];
    [self setFlashView:nil];
    [self setStopButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
    

@end
