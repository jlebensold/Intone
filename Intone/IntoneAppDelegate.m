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
    /*    */
    PrayerCategory *album1 = [[PrayerCategory alloc] init];
    PrayerCategory *album2 = [[PrayerCategory alloc] init];
    PrayerCategory *album3 = [[PrayerCategory alloc] init];
    PrayerCategory *album4 = [[PrayerCategory alloc] init];
    PrayerCategory *album5 = [[PrayerCategory alloc] init];
    
    album1.categoryName = @"Graduation";
    album2.categoryName = @"Dark and Twisted Fantasy";
    album3.categoryName = @"Torches";
    album4.categoryName = @"Nothing But The Beat";
    album5.categoryName = @"Angles";
    
    
    album1.categoryCount = 5;
    album2.categoryCount = 5;
    album3.categoryCount = 5;
    album4.categoryCount = 5;
    album5.categoryCount = 5;
    
    [prayerCategories addObject:album1];
    /*
    [prayerCategories addObject:album2];
    [prayerCategories addObject:album3];
    [prayerCategories addObject:album4];
    [prayerCategories addObject:album5];
*/
    //UITabBarController *tabBarController = 
    //    (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = 
        (UINavigationController *)self.window.rootViewController;
	
//    UINavigationController *navigationController = 
//    [[tabBarController viewControllers] objectAtIndex:0];
	
//    AlbumViewController *albumsViewController = 
//    [[navigationController viewControllers] objectAtIndex:0];
//	albumsViewController.albums = albums;


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
                    NSString* foo =  [NSString stringWithUTF8String:(const char *) (char*) xmlTextReaderGetAttribute(reader, BAD_CAST "title" )];
                    PrayerCategory *pc = [[PrayerCategory alloc] init];
                    pc.categoryName = foo;
                    pc.categoryCount = 3;
                    [prayerCategories addObject:pc];
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
