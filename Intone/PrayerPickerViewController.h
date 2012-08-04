//
//  PrayerPickerViewController.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-14.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerCategory.h"
@interface PrayerPickerViewController : UITableViewController
@property (nonatomic, strong) PrayerCategory *prayerCategory;
//@property (weak, nonatomic) IBOutlet UITableViewCell *tableView;
@property (copy, nonatomic) NSMutableArray *listData;
@property (copy,nonatomic) NSString *testString;
@end
