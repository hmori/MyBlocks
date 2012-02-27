//
//  UITableView+BlocksKitExtends.h
//
//  Created by Hidetoshi Mori on 12/02/26.
//  Copyright (c) 2012 hmori.jp. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "BKGlobals.h"

typedef void (^BKTableViewDisplayCellBlock)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath);
typedef CGFloat (^BKTableViewReturnFloatBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^BKTableViewSectionReturnFloatBlock)(UITableView *tableView, NSInteger section);
typedef id (^BKTableViewSectionReturnBlock)(UITableView *tableView, NSInteger section);
typedef NSInteger (^BKTableViewSectionReturnIntegerBlock)(UITableView *tableView, NSInteger section);
typedef NSInteger (^BKTableViewReturnIntegerBlock)(UITableView *tableView);
typedef id (^BKTableViewTableReturnBlock)(UITableView *tableView);
typedef NSInteger (^BKTableViewIndexTitleReturnIntegerBlock)(UITableView *tableView, NSString *title, NSInteger index);
typedef void (^BKTableViewStyleBlock)(UITableView *tableView, UITableViewCellEditingStyle style, NSIndexPath *indexPath);
typedef void (^BKTableViewMoveBlock)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
typedef id (^BKTableViewMoveReturnBlock)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
typedef NSInteger (^BKTableViewIndexPathReturnIntegerBlock)(UITableView *tableView, NSIndexPath *indexPath);

typedef void (^BKTableViewBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef id (^BKTableViewReturnBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef UITableViewCellEditingStyle (^BKTableViewReturnEditingStyleBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef BOOL (^BKTableViewReturnBoolBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef BOOL (^BKTableViewActionReturnBoolBlock)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);
typedef void (^BKTableViewActionBlock)(UITableView *tableView, SEL action, NSIndexPath *indexPath, id sender);


@interface UITableView (BlocksKitExtends) 

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource;


// UITableViewDelegate setHandler

- (void)setHandler:(BKTableViewDisplayCellBlock)block forWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath;

// handler is called before 'tableView:cellForRowAtIndexPath:'
//- (void)setHandler:(BKTableViewReturnFloatBlock)block forHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

// handler is called before 'tableView:cellForRowAtIndexPath:' 'tableView:heightForRowAtIndexPath:' 'numberOfRowsInSection'
//- (void)setHandler:(BKTableViewSectionReturnFloatBlock)block forHeightForHeaderInSection:(NSInteger)section;
//- (void)setHandler:(BKTableViewSectionReturnFloatBlock)block forHeightForFooterInSection:(NSInteger)section;

- (void)setHandler:(BKTableViewSectionReturnBlock)block forViewForHeaderInSection:(NSInteger)section;
- (void)setHandler:(BKTableViewSectionReturnBlock)block forViewForFooterInSection:(NSInteger)section;
- (void)setHandler:(BKTableViewBlock)block forAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBlock)block forWillSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBlock)block forWillDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewBlock)block forDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewBlock)block forDidDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnEditingStyleBlock)block forEditingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBlock)block forTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBoolBlock)block forShouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewBlock)block forWillBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewBlock)block forDidEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewMoveReturnBlock)block forTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewIndexPathReturnIntegerBlock)block forIndentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBoolBlock)block forShouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
- (void)setHandler:(BKTableViewActionReturnBoolBlock)block forCanPerformActionForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
- (void)setHandler:(BKTableViewActionBlock)block forPerformActionForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);

// UITableViewDataSource setHandler

- (void)setHandler:(BKTableViewSectionReturnIntegerBlock)block forNumberOfRowsInSection:(NSInteger)section;
- (void)setHandler:(BKTableViewReturnBlock)block forCellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandlerForNumberOfSectionsInTableView:(BKTableViewReturnIntegerBlock)block;
- (void)setHandler:(BKTableViewSectionReturnBlock)block forTitleForHeaderInSection:(NSInteger)section;
- (void)setHandler:(BKTableViewSectionReturnBlock)block forTitleForFooterInSection:(NSInteger)section;
- (void)setHandler:(BKTableViewReturnBoolBlock)block forCanEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandler:(BKTableViewReturnBoolBlock)block forCanMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setHandlerForSectionIndexTitlesForTableView:(BKTableViewTableReturnBlock)block;
- (void)setHandlerForSectionForSectionIndexTitle:(BKTableViewIndexTitleReturnIntegerBlock)block;
- (void)setHandlerForCommitEditingStyle:(BKTableViewStyleBlock)block;
- (void)setHandlerForMoveRowAtIndexPath:(BKTableViewMoveBlock)block;

@end
