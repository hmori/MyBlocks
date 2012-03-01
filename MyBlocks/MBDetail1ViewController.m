//
//  MBDetail1ViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/03/01.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBDetail1ViewController.h"

@implementation MBDetail1ViewController

- (void)dealloc {
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.title = @"Detail1";
    self.view.backgroundColor = [UIColor orangeColor];
}

@end
