//
//  MBBlocksViewController.m
//  MyBlocks
//
//  Created by Hidetoshi Mori on 12/02/17.
//  Copyright (c) 2012年 hmori.jp. All rights reserved.
//

#import "MBBlocksViewController.h"

@implementation MBBlocksViewController

- (void)dealloc {
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"BlocksKit Test";
    

    
    __block MBBlocksViewController *weakSelf = self;
    
    // 左ナビゲーションバーボタン
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] 
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                              handler:^(id sender) {
                                                  [weakSelf dismissModalViewControllerAnimated:YES];
                                              }] autorelease];
    

    // UIAlertView
    CGFloat y = 20;
    UIButton *alertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    alertButton.frame = CGRectMake(40, y, 240, 44);
    [alertButton setTitle:@"UIAlertView" forState:UIControlStateNormal];
    [alertButton addEventHandler:^(id sender) {
        UIAlertView *alert1 = [UIAlertView alertViewWithTitle:@"Alert1" message:@"UIAlertView Test"];
        [alert1 addButtonWithTitle:@"Show Alert2" handler:^(void) {
            UIAlertView *alert2 = [UIAlertView alertViewWithTitle:@"Alert2" message:@"Show UIAlertView From UIAlertView"];
            [alert2 addButtonWithTitle:@"Close"];
            [alert2 show];
        }];
        [alert1 addButtonWithTitle:@"Close"];
        [alert1 show];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertButton];

    
    // UIActionSheet
    y += 44+20;
    UIButton *sheetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sheetButton.frame = CGRectMake(40, y, 240, 44);
    [sheetButton setTitle:@"UIActionSheet" forState:UIControlStateNormal];
    [sheetButton addEventHandler:^(id sender) {
        UIActionSheet *sheet1 = [UIActionSheet actionSheetWithTitle:@"Sheet1"];
        [sheet1 addButtonWithTitle:@"Show Sheet2" handler:^(void) {
            UIActionSheet *sheet2 = [UIActionSheet actionSheetWithTitle:@"Sheet2"];
            [sheet2 setCancelButtonIndex:[sheet2 addButtonWithTitle:@"Close"]];
            [sheet2 showInView:weakSelf.view];
        }];
        [sheet1 setCancelButtonIndex:[sheet1 addButtonWithTitle:@"Close"]];
        [sheet1 showInView:weakSelf.view];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sheetButton];

    
    // NSTimer
    y += 44+20;
    UIButton *timerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    timerButton.frame = CGRectMake(40, y, 240, 44);
    [timerButton setTitle:@"NSTimer" forState:UIControlStateNormal];
    [timerButton addEventHandler:^(id sender) {
        [NSTimer scheduledTimerWithTimeInterval:2 
                                          block:^(NSTimeInterval time) {
                                              UIAlertView *a = [UIAlertView alertViewWithTitle:@"NSTimer" message:@"passed 2 sec."];
                                              [a addButtonWithTitle:@"Close"];
                                              [a show];
                                          }
                                        repeats:NO];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:timerButton];

    
    // NSURLConnection
    y += 44+20;
    UIButton *urlButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    urlButton.frame = CGRectMake(40, y, 240, 44);
    [urlButton setTitle:@"NSURLConnection" forState:UIControlStateNormal];
    [urlButton addEventHandler:^(id sender) {
        NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hatena.ne.jp/h_mori/"]];
        [NSURLConnection startConnectionWithRequest:req 
                                     successHandler:^(NSURLConnection *con, NSURLResponse *res, NSData *data){
                                         NSString *html = [[[NSString alloc] initWithData:data encoding:NSJapaneseEUCStringEncoding] autorelease];
                                         UIAlertView *a = [UIAlertView alertViewWithTitle:@"http://d.hatena.ne.jp/h_mori/" message:html];
                                         [a addButtonWithTitle:@"Close"];
                                         [a show];
                                     } 
                                     failureHandler:^(NSURLConnection *con, NSError *err){
                                         UIAlertView *a = [UIAlertView alertViewWithTitle:@"NSURLConnection h_mori" message:@"failed connection"];
                                         [a addButtonWithTitle:@"Close"];
                                         [a show];
                                     }];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:urlButton];

    
    // UIWebView
    y += 44+20;
    UIButton *webButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    webButton.frame = CGRectMake(40, y, 240, 44);
    [webButton setTitle:@"UIWebView" forState:UIControlStateNormal];
    [webButton addEventHandler:^(id sender) {
        UIWebView *webView = [[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480-20-44)] autorelease];
        __block UIWebView *weakWebView = webView;
        
        webView.didFinishLoadBlock = ^(UIWebView *v) {
            UIAlertView *a = [UIAlertView alertViewWithTitle:@"http://d.hatena.ne.jp/h_mori/" message:@"Finish Loading"];
            [a addButtonWithTitle:@"Close"];
            [a show];
        };
        [webView.dynamicDelegate webViewDidFinishLoad:webView];
        webView.didFinishWithErrorBlock = ^(UIWebView *v, NSError *err) {
            UIAlertView *a = [UIAlertView alertViewWithTitle:@"http://d.hatena.ne.jp/h_mori/" message:@"Error Loading"];
            [a addButtonWithTitle:@"Close"];
            [a show];
        };
        NSError *error = nil;
        [webView.dynamicDelegate webView:webView didFailLoadWithError:error];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://d.hatena.ne.jp/h_mori/"]]];
        [weakSelf.view addSubview:webView];
        
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        closeButton.frame = CGRectMake(0, 480-20-44-44, 320, 44);
        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [closeButton addEventHandler:^(id sender) {
            [weakWebView removeFromSuperview];
        } forControlEvents:UIControlEventTouchUpInside];
        [webView addSubview:closeButton];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:webButton];

    
    // MFMailComposeViewController
    y += 44+20;
    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mailButton.frame = CGRectMake(40, y, 240, 44);
    [mailButton setTitle:@"MFMailComposeViewController" forState:UIControlStateNormal];
    [mailButton addEventHandler:^(id sender) {
        
        MFMailComposeViewController *ctl = [[[MFMailComposeViewController alloc] init] autorelease];
        ctl.mailComposeDelegate = weakSelf;
        ctl.completionBlock = ^(MFMailComposeViewController *controller, MFMailComposeResult result, NSError *err){
            if (result == MFMailComposeResultSent) {
                UIAlertView *a = [UIAlertView alertViewWithTitle:@"MFMailComposeViewController" message:@"Finish to send."];
                [a addButtonWithTitle:@"Close"];
                [a show];
            }
        };
        [weakSelf presentModalViewController:ctl animated:YES];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mailButton];

    
}

@end
