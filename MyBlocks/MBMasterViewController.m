//
//  MBMasterViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/27.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBMasterViewController.h"
#import "MBDetail1ViewController.h"
#import "MBDetail2ViewController.h"
#import "UITableView+BlocksKitExtends.h"

@implementation MBMasterViewController

- (void)dealloc {
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];

    self.title = @"Master";
    
    __block MBMasterViewController *weakSelf = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel handler:^(id sender){
        [weakSelf dismissModalViewControllerAnimated:YES];
    }];

    UITableView *tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-20-44)  
                                                           style:UITableViewStyleGrouped 
                                                        delegate:self 
                                                      dataSource:self] autorelease];
    [self.view addSubview:tableView];
    [tableView setHandler:^NSInteger(UITableView *tv, NSInteger s){
        return 3;
    } forNumberOfRowsInSection:0];
    
    //row 0
    [tableView setHandler:^id(UITableView *tv, NSIndexPath *ip){
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.textLabel.text = @"Detail1";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [tv setHandler:^(UITableView *t, NSIndexPath *i){
            [t deselectRowAtIndexPath:i animated:YES];
            weakSelf.viewDidAppearBlock = ^(BOOL animated) {
                [[[[UIAlertView alloc] initWithTitle:nil message:@"From Detail1" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] autorelease] show];
            };
            MBDetail1ViewController *ctl = [[[MBDetail1ViewController alloc] init] autorelease];
            [weakSelf.navigationController pushViewController:ctl animated:YES];
        } forDidSelectRowAtIndexPath:ip];
        return cell;
    } forCellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    //row 1
    [tableView setHandler:^id(UITableView *tv, NSIndexPath *ip){
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.textLabel.text = @"Detail2";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [tv setHandler:^(UITableView *t, NSIndexPath *i){
            [t deselectRowAtIndexPath:i animated:YES];
            weakSelf.viewDidAppearBlock = ^(BOOL animated) {
                [[[[UIAlertView alloc] initWithTitle:nil message:@"From Detail2" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] autorelease] show];
            };
            MBDetail2ViewController *ctl = [[[MBDetail2ViewController alloc] init] autorelease];
            [weakSelf.navigationController pushViewController:ctl animated:YES];
        } forDidSelectRowAtIndexPath:ip];
        return cell;
    } forCellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    //row 2
    [tableView setHandler:^id(UITableView *tv, NSIndexPath *ip){
        UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"] autorelease];
        cell.textLabel.text = @"Detail3";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [tv setHandler:^(UITableView *t, NSIndexPath *i){
            [t deselectRowAtIndexPath:i animated:YES];
            weakSelf.viewDidAppearBlock = ^(BOOL animated) {
                [[[[UIAlertView alloc] initWithTitle:nil message:@"From Detail3" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] autorelease] show];
            };
            MBDetail1ViewController *ctl = [[[MBDetail1ViewController alloc] init] autorelease];
            __block MBDetail1ViewController *weakCtl = ctl;
            ctl.viewDidLoadBlock = ^{
                weakCtl.title = @"Detail3";
                weakCtl.view.backgroundColor = [UIColor darkGrayColor];
            };
            [weakSelf.navigationController pushViewController:ctl animated:YES];
        } forDidSelectRowAtIndexPath:ip];
        return cell;
    } forCellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

}

@end
