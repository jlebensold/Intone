//
//  IntoneAppDelegate.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-08.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntoneAppDelegate : UIResponder <UIApplicationDelegate> {     
    NSArray *_records;
   
}

@property (strong, nonatomic) UIWindow *window;
@property (retain) NSArray *records;

@end
