//
//  BCTableViewDataSource.h
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-22.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *recordings;

-(void)reloadData;
@end
