//
//  IntoneAppDelegate.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-08.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayerCategory.h"
@interface IntoneAppDelegate : UIResponder <UIApplicationDelegate> {     
    NSArray *_records;
	//to store data from xml node 
	
	NSMutableString *nodecontent;

	//declare the object of nsxml parse which will we use later for parsing
	
	NSXMLParser *xmlParserObject;
	
		
    PrayerCategory *prayerCategory;
    Prayer *prayer;
}

@property (strong, nonatomic) UIWindow *window;
@property (retain) NSArray *records;

@end
