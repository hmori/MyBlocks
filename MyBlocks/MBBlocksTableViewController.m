//
//  MBBlocksTableViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/26.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBBlocksTableViewController.h"
#import "UITableView+BlocksKitExtends.h"

@interface MBBlocksTableViewController ()
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *rows;
- (UITableViewCell *)cellInTableView:(UITableView *)tableView;
@end

@implementation MBBlocksTableViewController
@synthesize tableView = _tableView;
@synthesize rows = _rows;

- (void)dealloc {
    [_tableView release];
    [_rows release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    self.title = @"UITableView";
    
    __block MBBlocksTableViewController *weakSelf = self;
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-20-44)  
                                                   style:UITableViewStyleGrouped 
                                                delegate:self 
                                              dataSource:self] autorelease];
    [self.view addSubview:_tableView];

    // Number of Section in TableView.
    [_tableView setHandlerForNumberOfSectionsInTableView:^NSInteger(UITableView *tv){
        return 2;
    }];
    
    
    // Part of Section 0
    NSInteger section = 0;
    [_tableView setHandler:^id(UITableView *tv, NSInteger s){
        return @"Copy & Paste";
    } forTitleForHeaderInSection:section];
    [_tableView setHandler:^id(UITableView *tv, NSInteger s){
        return @"Menu is shown by LongPress";
    } forTitleForFooterInSection:section];
    [_tableView setHandler:^NSInteger(UITableView *tv, NSInteger s){
        return 2;
    } forNumberOfRowsInSection:section];
    
    NSInteger row = 0;
    [_tableView setHandler:^id(UITableView *tv, NSIndexPath *ip){
        UITableViewCell *cell = [weakSelf cellInTableView:tv];
        cell.textLabel.text = @"Copy";
        cell.detailTextLabel.text = [[NSDate date] description];
        cell.accessoryType = UITableViewCellAccessoryNone;
        [tv setHandler:^(UITableView *t, NSIndexPath *i){
            [t deselectRowAtIndexPath:i animated:YES];
        } forDidSelectRowAtIndexPath:ip];
        
        [tv setHandler:^BOOL(UITableView *t, NSIndexPath *i){
            return YES;
        } forShouldShowMenuForRowAtIndexPath:ip];
        [tv setHandler:^BOOL(UITableView *t, SEL action, NSIndexPath *i, id sender){
            return action == @selector(copy:);
        } forCanPerformActionForRowAtIndexPath:ip];
        __block UITableViewCell *weakCell = cell;
        [tv setHandler:^(UITableView *t, SEL action, NSIndexPath *i, id sender){
            [UIPasteboard generalPasteboard].string = weakCell.detailTextLabel.text;
        } forPerformActionForRowAtIndexPath:ip];
        return cell;
    } forCellForRowAtIndexPath:[NSIndexPath indexPathForRow:row++ inSection:section]];
    [_tableView setHandler:^id(UITableView *tv, NSIndexPath *ip){
        UITableViewCell *cell = [weakSelf cellInTableView:tv];
        cell.textLabel.text = @"Paste";
        cell.detailTextLabel.text = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        [tv setHandler:^(UITableView *t, NSIndexPath *i){
            [t deselectRowAtIndexPath:i animated:YES];
        } forDidSelectRowAtIndexPath:ip];
        
        [tv setHandler:^BOOL(UITableView *t, NSIndexPath *i){
            return YES;
        } forShouldShowMenuForRowAtIndexPath:ip];
        [tv setHandler:^BOOL(UITableView *t, SEL action, NSIndexPath *i, id sender){
            return action == @selector(paste:);
        } forCanPerformActionForRowAtIndexPath:ip];
        __block UITableViewCell *weakCell = cell;
        [tv setHandler:^(UITableView *t, SEL action, NSIndexPath *i, id sender){
            weakCell.detailTextLabel.text = [UIPasteboard generalPasteboard].string;
        } forPerformActionForRowAtIndexPath:ip];
        
        return cell;
    } forCellForRowAtIndexPath:[NSIndexPath indexPathForRow:row++ inSection:section]];
    
    // Part of Section 1
    section++;
    [_tableView setHandler:^id(UITableView *tv, NSInteger s){
        return @"Editing";
    } forTitleForHeaderInSection:section];
    [_tableView setHandler:^id(UITableView *tv, NSInteger s){
        return @"EDIT button press.";
    } forTitleForFooterInSection:section];
    [_tableView setHandler:^NSInteger(UITableView *tv, NSInteger s){
        return weakSelf.rows.count;
    } forNumberOfRowsInSection:section];
    
    // Rows of Section 1 in UITableViewDataSource (tableView:cellForRowAtIndexPath:)
    
    
    // Deleteing Process
    [_tableView setHandlerForCommitEditingStyle:^(UITableView *tv, UITableViewCellEditingStyle editingStyle, NSIndexPath *ip){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [tv beginUpdates];
            [weakSelf.rows removeObjectAtIndex:ip.row];
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationFade];
            [tv endUpdates];
        }
    }];
    
    // Moving Process
    [_tableView setHandlerForMoveRowAtIndexPath:^(UITableView *tv, NSIndexPath *fromIndexPath, NSIndexPath *toIndexPath){
        if (fromIndexPath.section == toIndexPath.section) {
            if(weakSelf.rows && toIndexPath.row < [weakSelf.rows count]) {
                id item = [[weakSelf.rows objectAtIndex:fromIndexPath.row] retain];
                [weakSelf.rows removeObject:item];
                [weakSelf.rows insertObject:item atIndex:toIndexPath.row];
                [item release];
            }
        }
    }];
    
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                              handler:^(id sender) {
                                                  [weakSelf dismissModalViewControllerAnimated:YES];
                                              }] autorelease];
    
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] 
                                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                               handler:^(id sender) {
                                                   [weakSelf.tableView setEditing:!weakSelf.tableView.editing animated:YES];
                                               }] autorelease];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rows = [NSMutableArray arrayWithObjects:@"ROW 1", @"ROW 2", @"ROW 3", nil];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellInTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    if (indexPath.section == 1) {
        cell.textLabel.text = @"Editable";
        cell.detailTextLabel.text = [_rows objectAtIndex:indexPath.row];
        
        // DidSelect
        [tableView setHandler:^(UITableView *tv, NSIndexPath *ip){
            [tv deselectRowAtIndexPath:ip animated:YES];
            [[[UIAlertView alloc] initWithTitle:@"DidSelect Cell" 
                                        message:[NSString stringWithFormat:@"section=%d, row=%d", indexPath.section, indexPath.row] 
                                       delegate:nil 
                              cancelButtonTitle:@"Close" 
                              otherButtonTitles:nil] show];
        } forDidSelectRowAtIndexPath:indexPath];
        
        // AccessoryButtonTapped
        [tableView setHandler:^(UITableView *tv, NSIndexPath *ip){
            [[[UIAlertView alloc] initWithTitle:@"AccessoryButtonTapped" 
                                        message:[NSString stringWithFormat:@"section=%d, row=%d", indexPath.section, indexPath.row] 
                                       delegate:nil 
                              cancelButtonTitle:@"Close" 
                              otherButtonTitles:nil] show];
        } forAccessoryButtonTappedForRowWithIndexPath:indexPath];

        // Editable Flag
        [tableView setHandler:^BOOL(UITableView *tv, NSIndexPath *ip){
            return YES;
        } forCanEditRowAtIndexPath:indexPath];
        // Editable Type (Delete or Insert)
        [tableView setHandler:^UITableViewCellEditingStyle(UITableView *tv, NSIndexPath *ip){
            return UITableViewCellEditingStyleDelete;
        } forEditingStyleForRowAtIndexPath:indexPath];
        // Movable Flag
        [tableView setHandler:^BOOL(UITableView *tv, NSIndexPath *ip){
            return YES;
        } forCanMoveRowAtIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - Private

- (UITableViewCell *)cellInTableView:(UITableView *)tableView {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    return cell;
}

@end
