//
//  MBBaseViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/27.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBBaseViewController.h"

@implementation MBBaseViewController

@synthesize loadViewBlock = _loadViewBlock;
@synthesize viewDidLoadBlock = _viewDidLoadBlock;
@synthesize viewWillAppearBlock = _viewWillAppearBlock;
@synthesize viewDidAppearBlock = _viewDidAppearBlock;
@synthesize viewWillDisappearBlock = _viewWillDisappearBlock;
@synthesize viewDidDisappearBlock = _viewDidDisappearBlock;

- (void)dealloc {
    [_loadViewBlock release];
    [_viewDidLoadBlock release];
    [_viewWillAppearBlock release];
    [_viewDidAppearBlock release];
    [_viewWillDisappearBlock release];
    [_viewDidDisappearBlock release];
    [super dealloc];
}

- (void)loadView {
    [super loadView];
    if (_loadViewBlock) {
        _loadViewBlock();
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_viewDidLoadBlock) {
        _viewDidLoadBlock();
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_viewWillAppearBlock) {
        _viewWillAppearBlock(animated);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_viewDidAppearBlock) {
        _viewDidAppearBlock(animated);
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_viewWillDisappearBlock) {
        _viewWillDisappearBlock(animated);
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_viewDidDisappearBlock) {
        _viewDidDisappearBlock(animated);
    }
}

@end
