//
//  MBBaseViewController.h
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/27.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBBaseViewController : UIViewController {
    void (^_loadViewBlock)(void);
    void (^_viewDidLoadBlock)(void);
    void (^_viewWillAppearBlock)(BOOL);
    void (^_viewDidAppearBlock)(BOOL);
    void (^_viewWillDisappearBlock)(BOOL);
    void (^_viewDidDisappearBlock)(BOOL);
}

@property (nonatomic, copy) void (^loadViewBlock)(void);
@property (nonatomic, copy) void (^viewDidLoadBlock)(void);
@property (nonatomic, copy) void (^viewWillAppearBlock)(BOOL);
@property (nonatomic, copy) void (^viewDidAppearBlock)(BOOL);
@property (nonatomic, copy) void (^viewWillDisappearBlock)(BOOL);
@property (nonatomic, copy) void (^viewDidDisappearBlock)(BOOL);

@end
