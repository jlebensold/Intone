//
//  IntoneFirstViewController.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-08.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerGrouping.h"
@interface IntoneFirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet PrayerGrouping *prayerGroupingTableView;

@property (copy, nonatomic) NSMutableArray *listData;
@end
