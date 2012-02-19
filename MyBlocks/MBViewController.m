//
//  MBViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/14.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBViewController.h"
#import "MBBlocksViewController.h"

@implementation MBViewController

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    __block MBViewController *weakSelf = self;
    [NSObject performBlock:^(void) {
        NSLog(@"fire");
        MBBlocksViewController *ctl = [[[MBBlocksViewController alloc] init] autorelease];
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:ctl] autorelease];
        [weakSelf presentModalViewController:nav animated:YES];
    } afterDelay:1];
}

@end
