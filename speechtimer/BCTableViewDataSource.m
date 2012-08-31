//
//  BCTableViewDataSource.m
//  speechtimer
//
//  Created by Brendan Clement on 2012-08-22.
//  Copyright (c) 2012 Stripe Software. All rights reserved.
//

#import "BCTableViewDataSource.h"

@implementation BCTableViewDataSource

@synthesize recordings;

-(id)init
{
    self = [super init];
    if(self)
    {
        recordings = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)reloadData
{
    [recordings removeAllObjects];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSError *error;
    NSArray *dirContents = [[NSFileManager defaultManager]
                            contentsOfDirectoryAtPath:documentsDirectory error:&error];
    
    for(NSString *file in dirContents)
    {
        if([[file substringFromIndex:[file length]-3] isEqualToString:@"caf"])
        {
            [recordings addObject:file];
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recordings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        //clear the subviews
        for(UIView *v in [cell.contentView subviews])
        {
            [v removeFromSuperview];
        }
    }
    
    cell.textLabel.text = [recordings objectAtIndex:indexPath.row];
    return cell;
}

@end
