//
//  PrayerCategory.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-09.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Prayer.h"

@interface PrayerCategory : NSObject

@property (nonatomic, copy) NSString *categoryName;
@property NSString *description;
@property (nonatomic, assign) int categoryCount;
@property (nonatomic, copy) NSMutableArray *prayers;
@end
