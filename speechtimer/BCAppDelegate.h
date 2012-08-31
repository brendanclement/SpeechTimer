//
//  BCAppDelegate.h
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-21.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BCAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
