//
//  MBViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/14.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBViewController.h"
#import "MBBlocksViewController.h"
#import "MBBlocksTableViewController.h"

@implementation MBViewController

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];

    __block MBViewController *weakSelf = self;
    
    CGFloat y = 60;
    UIButton *blocksViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blocksViewButton.frame = CGRectMake(40, y, 240, 44);
    [blocksViewButton setTitle:@"MBBlocksViewController" forState:UIControlStateNormal];
    [blocksViewButton addEventHandler:^(id sender) {
        MBBlocksViewController *ctl = [[[MBBlocksViewController alloc] init] autorelease];
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:ctl] autorelease];
        [weakSelf presentModalViewController:nav animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blocksViewButton];
    
    
    y += 44+40;
    UIButton *blocksTableViewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blocksTableViewButton.frame = CGRectMake(40, y, 240, 44);
    [blocksTableViewButton setTitle:@"MBBlocksTableViewController" forState:UIControlStateNormal];
    [blocksTableViewButton addEventHandler:^(id sender) {
        MBBlocksTableViewController *ctl = [[[MBBlocksTableViewController alloc] init] autorelease];
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:ctl] autorelease];
        [weakSelf presentModalViewController:nav animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blocksTableViewButton];

}

@end
