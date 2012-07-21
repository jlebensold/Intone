//
//  IntoneAppDelegate.m
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-08.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import "IntoneAppDelegate.h"
#import "IntoneFirstViewController.h"
#import "PrayerCategory.h"
#include <libxml/xmlreader.h>

@implementation IntoneAppDelegate {
    NSMutableArray *prayerCategories;
    NSArray *records;
}
@synthesize records = _records;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    prayerCategories = [NSMutableArray arrayWithCapacity:15];
    
    
    UINavigationController *navigationController = 
        (UINavigationController *)self.window.rootViewController;
	
    // XML

    NSString *path = [[NSBundle mainBundle] pathForResource:@"intone" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    xmlTextReaderPtr reader = xmlReaderForMemory([xmlData bytes], 
                                                 [xmlData length], 
                                                 [path UTF8String], nil, 
                                                 (XML_PARSE_NOBLANKS | XML_PARSE_NOCDATA | XML_PARSE_NOERROR | XML_PARSE_NOWARNING));
    if (!reader) {
        NSLog(@"Failed to load xmlreader");
        return NO;
    }
	NSString *currentTagName = nil;
	NSDictionary *currentPerson = nil;
	NSString *currentTagValue = nil;
	char* temp;
	while (true) {
		if (!xmlTextReaderRead(reader)) break;
		switch (xmlTextReaderNodeType(reader)) {
			case XML_READER_TYPE_ELEMENT:
				//We are starting an element
				temp =  (char*)xmlTextReaderConstName(reader);
				currentTagName = [NSString stringWithCString:temp 
                                                    encoding:NSUTF8StringEncoding];
				if ([currentTagName isEqualToString:@"category"]) {
                    PrayerCategory *pc = [[PrayerCategory alloc] init];
                    pc.categoryName = [NSString stringWithUTF8String:(const char *) (char*) xmlTextReaderGetAttribute(reader, BAD_CAST "title" )];
                    pc.categoryCount = 3;

                    [prayerCategories addObject:pc];
				}	
				if ([currentTagName isEqualToString:@"prayer"]) {
                    PrayerCategory* curCategory;
                    Prayer *p = [[Prayer alloc] init];
                    
                    xmlNodePtr node = xmlTextReaderCurrentNode(reader);
                    
                    NSString *title = [NSString stringWithUTF8String:(const char *) (char*) xmlTextReaderGetAttribute(reader, BAD_CAST "title" )];
                    
                    for(PrayerCategory *pc in  prayerCategories) {
                        NSLog([NSString stringWithFormat:@"%@",pc.categoryName]);
                    }
                    
                }
				continue;
			case XML_READER_TYPE_TEXT:
				//The current tag has a text value, stick it into the current person
				temp = (char*)xmlTextReaderConstValue(reader);
				currentTagValue = [NSString stringWithCString:temp 
                                                     encoding:NSUTF8StringEncoding];
				if (!currentPerson) continue;
				[currentPerson setValue:currentTagValue forKey:currentTagName];
				currentTagValue = nil;
				currentTagName = nil;
			default: continue;
		}
	}
    IntoneFirstViewController *intoneFirstViewController = 
    [[navigationController viewControllers] objectAtIndex:0];
	intoneFirstViewController.listData = prayerCategories;

    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
