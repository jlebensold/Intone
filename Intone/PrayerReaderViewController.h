//
//  PrayerReaderViewController.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-23.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Prayer.h"
@interface PrayerReaderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) Prayer *prayer;
@end
