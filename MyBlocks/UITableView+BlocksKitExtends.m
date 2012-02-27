//
//  UITableView+BlocksKitExtends.m
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

#import "UITableView+BlocksKitExtends.h"
#import "A2BlockDelegate+BlocksKit.h"

static NSString * const kFormat = @"%@_%d_%d";
static NSString * const kHandlerWillDisplayCellForRow = @"kHandlerWillDisplayCellForRow";
static NSString * const kHandlerHeightForRow = @"kHandlerHeightForRow";
static NSString * const kHandlerHeightForHeaderInSection = @"kHandlerHeightForHeaderInSection";
static NSString * const kHandlerHeightForFooterInSection = @"kHandlerHeightForFooterInSection";
static NSString * const kHandlerViewForHeaderInSection = @"kHandlerViewForHeaderInSection";
static NSString * const kHandlerViewForFooterInSection = @"kHandlerViewForFooterInSection";
static NSString * const kHandlerAccessoryButtonTappedForRow = @"kHandlerAccessoryButtonTappedForRow";
static NSString * const kHandlerWillSelectRow = @"kHandlerWillSelectRow";
static NSString * const kHandlerWillDeselectRow = @"kHandlerWillDeselectRow";
static NSString * const kHandlerDidSelectRow = @"kHandlerDidSelectRow";
static NSString * const kHandlerDidDeselectRow = @"kHandlerDidDeselectRow";
static NSString * const kHandlerEditingStyleForRow = @"kHandlerEditingStyleForRow";
static NSString * const kHandlerTitleForDeleteConfirmationButtonForRow = @"kHandlerTitleForDeleteConfirmationButtonForRow";
static NSString * const kHandlerIndentationLevelForRow = @"kHandlerIndentationLevelForRow";
static NSString * const kHandlerShouldIndentWhileEditingRow = @"kHandlerShouldIndentWhileEditingRow";
static NSString * const kHandlerWillBeginEditingRow = @"kHandlerWillBeginEditingRow";
static NSString * const kHandlerDidEndEditingRow = @"kHandlerDidEndEditingRow";
static NSString * const kHandlerTargetIndexPathForMoveFromRow = @"kHandlerTargetIndexPathForMoveFromRow";
static NSString * const kHandlerShouldShowMenuForRow = @"kHandlerShouldShowMenuForRow";
static NSString * const kHandlerCanPerformAction = @"kHandlerCanPerformAction";
static NSString * const kHandlerPerformAction = @"kHandlerPerformAction";
static NSString * const kHandlerNumberOfRows = @"kHandlerNumberOfRows";
static NSString * const kHandlerCellForRow = @"kHandlerCellForRow";
static NSString * const kHandlerNumberOfSections = @"kHandlerNumberOfSections";
static NSString * const kHandlerTitleForHeader = @"kHandlerTitleForHeader";
static NSString * const kHandlerTitleForFooter = @"kHandlerTitleForFooter";
static NSString * const kHandlerCanEditRow = @"kHandlerCanEditRow";
static NSString * const kHandlerCanMoveRow = @"kHandlerCanMoveRow";
static NSString * const kHandlerSectionIndexTitlesForTableView = @"kHandlerSectionIndexTitlesForTableView";
static NSString * const kHandlerSectionForSectionIndexTitle = @"kHandlerSectionForSectionIndexTitle";
static NSString * const kHandlerCommitEditingStyle = @"kHandlerCommitEditingStyle";
static NSString * const kHandlerMoveRowAtIndexPath = @"kHandlerMoveRowAtIndexPath";


#pragma mark - CustomDelegate

@interface A2DynamicUITableViewDelegate : A2DynamicDelegate <UITableViewDelegate>
@end

@implementation A2DynamicUITableViewDelegate

//optional

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
		[realDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillDisplayCellForRow, indexPath.section, indexPath.row];
    BKTableViewDisplayCellBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewDisplayCellBlock)block)(tableView, cell, indexPath);
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat ret = 44.0f;
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
//		ret = [realDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
//    }
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForRow, indexPath.section, indexPath.row];
//    BKTableViewReturnFloatBlock block = [self.handlers objectForKey:key];
//    if (block) {
//        ret = ((BKTableViewReturnFloatBlock)block)(tableView, indexPath);
//    }
//    return ret;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    CGFloat ret = 0.0f;
//    if (tableView.style == UITableViewStylePlain) {
//        ret = 10.0f;
//    } else if (tableView.style == UITableViewStyleGrouped) {
//        ret = 22.0f;
//    }
//    
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
//		ret = [realDelegate tableView:tableView heightForHeaderInSection:section];
//    }
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForHeaderInSection, section, 0];
//    BKTableViewSectionReturnFloatBlock block = [self.handlers objectForKey:key];
//    if (block) {
//        ret = ((BKTableViewSectionReturnFloatBlock)block)(tableView, section);
//    }
//    return ret;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    CGFloat ret = 0.0f;
//    if (tableView.style == UITableViewStylePlain) {
//        ret = 10.0f;
//    } else if (tableView.style == UITableViewStyleGrouped) {
//        ret = 22.0f;
//    }
//	id realDelegate = self.realDelegate;
//	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
//		ret = [realDelegate tableView:tableView heightForFooterInSection:section];
//    }
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForFooterInSection, section, 0];
//    BKTableViewSectionReturnFloatBlock block = [self.handlers objectForKey:key];
//    if (block) {
//        ret = ((BKTableViewSectionReturnFloatBlock)block)(tableView, section);
//    }
//    return ret;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
		ret = [realDelegate tableView:tableView viewForHeaderInSection:section];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerViewForHeaderInSection, section, 0];
    BKTableViewSectionReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewSectionReturnBlock)block)(tableView, section);
    }
    return ret;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
		ret = [realDelegate tableView:tableView viewForFooterInSection:section];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerViewForFooterInSection, section, 0];
    BKTableViewSectionReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewSectionReturnBlock)block)(tableView, section);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
		[realDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerAccessoryButtonTappedForRow, indexPath.section, indexPath.row];
    BKTableViewBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewBlock)block)(tableView, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id ret = indexPath;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillSelectRow, indexPath.section, indexPath.row];
    BKTableViewReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    id ret = indexPath;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillDeselectRow, indexPath.section, indexPath.row];
    BKTableViewReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
		[realDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidSelectRow, indexPath.section, indexPath.row];
    BKTableViewBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewBlock)block)(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
		[realDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidDeselectRow, indexPath.section, indexPath.row];
    BKTableViewBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewBlock)block)(tableView, indexPath);
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
		style = [realDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerEditingStyleForRow, indexPath.section, indexPath.row];
    BKTableViewReturnEditingStyleBlock block = [self.handlers objectForKey:key];
    if (block) {
        style = ((BKTableViewReturnEditingStyleBlock)block)(tableView, indexPath);
    }
    return style;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForDeleteConfirmationButtonForRow, indexPath.section, indexPath.row];
    BKTableViewReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL ret = NO;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerShouldIndentWhileEditingRow, indexPath.section, indexPath.row];
    BKTableViewReturnBoolBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBoolBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
		[realDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillBeginEditingRow, indexPath.section, indexPath.row];
    BKTableViewBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewBlock)block)(tableView, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
		[realDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidEndEditingRow, indexPath.section, indexPath.row];
    BKTableViewBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewBlock)block)(tableView, indexPath);
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    id ret = proposedDestinationIndexPath;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
		ret = [realDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTargetIndexPathForMoveFromRow, sourceIndexPath.section, sourceIndexPath.row];
    BKTableViewMoveReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewMoveReturnBlock)block)(tableView, sourceIndexPath, proposedDestinationIndexPath);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger ret = 0;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerIndentationLevelForRow, indexPath.section, indexPath.row];
    BKTableViewIndexPathReturnIntegerBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewIndexPathReturnIntegerBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
    BOOL ret = NO;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerShouldShowMenuForRow, indexPath.section, indexPath.row];
    BKTableViewReturnBoolBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBoolBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
    BOOL ret = NO;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
		ret = [realDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanPerformAction, indexPath.section, indexPath.row];
    BKTableViewActionReturnBoolBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewActionReturnBoolBlock)block)(tableView, action, indexPath, sender);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
		[realDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerPerformAction, indexPath.section, indexPath.row];
    BKTableViewActionBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewActionBlock)block)(tableView, action, indexPath, sender);
    }
}

@end

#pragma mark - CustomDataSource

@interface A2DynamicUITableViewDataSource : A2DynamicDelegate <UITableViewDataSource>
@end

@implementation A2DynamicUITableViewDataSource

//required

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger ret = 0;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
		ret = [realDelegate tableView:tableView numberOfRowsInSection:section];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerNumberOfRows, section, 0];
    BKTableViewSectionReturnIntegerBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewSectionReturnIntegerBlock)block)(tableView, section);
    }
    return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCellForRow, indexPath.section, indexPath.row];
    BKTableViewReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBlock)block)(tableView, indexPath);
    }
    return ret;
}

//optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger ret = 1;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		ret = [realDelegate numberOfSectionsInTableView:tableView];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerNumberOfSections, 0, 0];
    BKTableViewReturnIntegerBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnIntegerBlock)block)(tableView);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
		ret = [realDelegate tableView:tableView titleForHeaderInSection:section];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForHeader, section, 0];
    BKTableViewSectionReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewSectionReturnBlock)block)(tableView, section);
    }
    return ret;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
		ret = [realDelegate tableView:tableView titleForFooterInSection:section];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForFooter, section, 0];
    BKTableViewSectionReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewSectionReturnBlock)block)(tableView, section);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL ret = NO;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanEditRow, indexPath.section, indexPath.row];
    BKTableViewReturnBoolBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBoolBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL ret = NO;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
		ret = [realDelegate tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanMoveRow, indexPath.section, indexPath.row];
    BKTableViewReturnBoolBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewReturnBoolBlock)block)(tableView, indexPath);
    }
    return ret;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    id ret = nil;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
		ret = [realDelegate sectionIndexTitlesForTableView:tableView];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerSectionIndexTitlesForTableView, 0, 0];
    BKTableViewTableReturnBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewTableReturnBlock)block)(tableView);
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSInteger ret = 0;
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
		ret = [realDelegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerSectionForSectionIndexTitle, 0, 0];
    BKTableViewIndexTitleReturnIntegerBlock block = [self.handlers objectForKey:key];
    if (block) {
        ret = ((BKTableViewIndexTitleReturnIntegerBlock)block)(tableView, title, index);
    }
    return ret;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
		[realDelegate tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCommitEditingStyle, 0, 0];
    BKTableViewStyleBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewStyleBlock)block)(tableView, editingStyle, indexPath);
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
		[realDelegate tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerMoveRowAtIndexPath, 0, 0];
    BKTableViewMoveBlock block = [self.handlers objectForKey:key];
    if (block) {
        ((BKTableViewMoveBlock)block)(tableView, sourceIndexPath, destinationIndexPath);
    }
}

@end

#pragma mark - Custom UITableView

@implementation UITableView (BlocksKitExtends)

- (void)setHandler:(id)block forKey:(NSString *)key target:(id)target {
    if (block) {
		[[target handlers] setObject:block forKey:key];
    } else {
		[[target handlers] removeObjectForKey:key];
    }
}


#pragma mark Initializers

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource {
    UITableView *tableView = [self initWithFrame:frame style:style];
    tableView.delegate = self.dynamicDelegate;
    ((A2DynamicDelegate *)self.dynamicDelegate).realDelegate = delegate;
    
    tableView.dataSource = self.dynamicDataSource;
    ((A2DynamicDelegate *)self.dynamicDataSource).realDelegate = dataSource;
    
    return tableView;
}

#pragma mark setHandler

//Delegate

- (void)setHandler:(BKTableViewDisplayCellBlock)block forWillDisplayCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillDisplayCellForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

//- (void)setHandler:(BKTableViewReturnFloatBlock)block forHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForRow, indexPath.section, indexPath.row];
//    [self setHandler:block forKey:key target:self.dynamicDelegate];
//}
//
//- (void)setHandler:(BKTableViewSectionReturnFloatBlock)block forHeightForHeaderInSection:(NSInteger)section {
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForHeaderInSection, section, 0];
//    [self setHandler:block forKey:key target:self.dynamicDelegate];
//}
//
//- (void)setHandler:(BKTableViewSectionReturnFloatBlock)block forHeightForFooterInSection:(NSInteger)section {
//    NSString *key = [NSString stringWithFormat:kFormat, kHandlerHeightForFooterInSection, section, 0];
//    [self setHandler:block forKey:key target:self.dynamicDelegate];
//}

- (void)setHandler:(BKTableViewSectionReturnBlock)block forViewForHeaderInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerViewForHeaderInSection, section, 0];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewSectionReturnBlock)block forViewForFooterInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerViewForFooterInSection, section, 0];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewBlock)block forAccessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerAccessoryButtonTappedForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnBlock)block forWillSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillSelectRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnBlock)block forWillDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillDeselectRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewBlock)block forDidSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidSelectRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewBlock)block forDidDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidDeselectRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnEditingStyleBlock)block forEditingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerEditingStyleForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnBlock)block forTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForDeleteConfirmationButtonForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnBoolBlock)block forShouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerShouldIndentWhileEditingRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewBlock)block forWillBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerWillBeginEditingRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewBlock)block forDidEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerDidEndEditingRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewMoveReturnBlock)block forTargetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTargetIndexPathForMoveFromRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewIndexPathReturnIntegerBlock)block forIndentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerIndentationLevelForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewReturnBoolBlock)block forShouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerShouldShowMenuForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewActionReturnBoolBlock)block forCanPerformActionForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanPerformAction, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}

- (void)setHandler:(BKTableViewActionBlock)block forPerformActionForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0) {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerPerformAction, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDelegate];
}


//dataSource

- (void)setHandler:(BKTableViewSectionReturnIntegerBlock)block forNumberOfRowsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerNumberOfRows, section, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandler:(BKTableViewReturnBlock)block forCellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCellForRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandlerForNumberOfSectionsInTableView:(BKTableViewReturnIntegerBlock)block {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerNumberOfSections, 0, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}


- (void)setHandler:(BKTableViewSectionReturnBlock)block forTitleForHeaderInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForHeader, section, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandler:(BKTableViewSectionReturnBlock)block forTitleForFooterInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerTitleForFooter, section, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandler:(BKTableViewReturnBoolBlock)block forCanEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanEditRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandler:(BKTableViewReturnBoolBlock)block forCanMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCanMoveRow, indexPath.section, indexPath.row];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandlerForSectionIndexTitlesForTableView:(BKTableViewTableReturnBlock)block {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerSectionIndexTitlesForTableView, 0, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandlerForSectionForSectionIndexTitle:(BKTableViewIndexTitleReturnIntegerBlock)block {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerSectionForSectionIndexTitle, 0, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandlerForCommitEditingStyle:(BKTableViewStyleBlock)block {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerCommitEditingStyle, 0, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

- (void)setHandlerForMoveRowAtIndexPath:(BKTableViewMoveBlock)block {
    NSString *key = [NSString stringWithFormat:kFormat, kHandlerMoveRowAtIndexPath, 0, 0];
    [self setHandler:block forKey:key target:self.dynamicDataSource];
}

@end
