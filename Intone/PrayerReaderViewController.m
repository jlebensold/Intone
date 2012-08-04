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
    NSString *html = [NSString stringWithFormat:@"<html> \n"
                                   "<head> \n"
                                   "<style type=\"text/css\"> \n"
                                   "body {font-family: \"%@\"; font-size: %@;}\n"
                      ".prayer {margin: 1em; }\n"
                      ".prayer p:first-child:first-letter { "
                      "font-family: Old English, Georgia,serif;"
                      "font-size: 140%;"
                      "line-height: 0.85em;"
                      "float:left;"
                      "margin-right: 0.05em;"
                      "margin-bottom:-0.25em;"
                      "}"
                                    "</style> \n"
                                   "</head> \n"
                                   "<body><div class=\"prayer\">%@</div></body> \n"
                                   "</html>", @"Georgia",@"45", prayer.text];

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
