//
//  PrayerReaderViewController.m
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-23.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import "PrayerReaderViewController.h"

@interface PrayerReaderViewController ()

@end

@implementation PrayerReaderViewController
@synthesize prayer;
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"style" ofType:@"css"];
    NSString *cssString = [NSString stringWithContentsOfFile:path];
    
    NSString *html = [NSString stringWithFormat: cssString, @"Georgia",@"45", prayer.text];

    [webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://localhost"]];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
