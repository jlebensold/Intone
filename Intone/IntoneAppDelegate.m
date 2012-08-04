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
    NSMutableArray *prayerCategories, *prayers;
    NSArray *records;
}
@synthesize records = _records;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    prayerCategories = [NSMutableArray arrayWithCapacity:15];
    prayers = [NSMutableArray arrayWithCapacity:15];
    
    UINavigationController *navigationController = 
        (UINavigationController *)self.window.rootViewController;
	
    // XML
    NSString *path = [[NSBundle mainBundle] pathForResource:@"intone" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:path];
    xmlParserObject =[[NSXMLParser alloc]initWithData:xmlData];
    //TODO: move parser to delegate
    [xmlParserObject setDelegate:self];    
    //asking the xmlparser object to begin with its parsing
    [xmlParserObject parse];

        
    IntoneFirstViewController *intoneFirstViewController = 
    [[navigationController viewControllers] objectAtIndex:0];
	intoneFirstViewController.listData = prayerCategories;

    return YES;
}
#pragma mark NSXMLParser delegate

//below delegate method is sent by a parser object to provide its delegate when it encounters a start tag 

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
	//if element name is equat to item then only i am assingning memory to the NSObject class
	if([elementName isEqualToString:@"prayer"]){    
        prayer = [[Prayer alloc] init];  
    }
    else if([elementName isEqualToString:@"category"]){
		prayerCategory =[[PrayerCategory alloc]init];
        prayers = [NSMutableArray arrayWithCapacity:15];
        NSString *title = [attributeDict objectForKey:@"title"];
        if (title)
            prayerCategory.categoryName = title;
	}

	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (!nodecontent) {
        // currentStringValue is an NSMutableString instance variable
        nodecontent = [[NSMutableString alloc] initWithCapacity:50 ];
    }
//    [nodecontent appendString:string];
  //  nodecontent = [[NSMutableString alloc] initWithString:string];
    
	//whatever data i am getting from node i am appending it to the nodecontent variable
	[nodecontent appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//    NSLog(@"node content = %@",nodecontent);
}

//bellow delegate method specify when it encounter end tag of specific that tag

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

	
	//finally when we reaches the end of tag i am adding data inside the NSMutableArray
	if([elementName isEqualToString:@"category"]){  
        prayerCategory.prayers = prayers;
		[prayerCategories addObject:prayerCategory];
        prayerCategory = nil;
	}
    if([elementName isEqualToString:@"prayer"]){        
		[prayers addObject:prayer];
        prayer = nil;
	}
    else if([elementName isEqualToString:@"text"]){
        prayer.text = nodecontent;
    }
    else if([elementName isEqualToString:@"excerpt"]){
        prayer.excerpt = nodecontent;
    }
    else if([elementName isEqualToString:@"author"]){
        prayer.author = nodecontent;
    }
	
	//reallocate the memory to get new content data from file
	nodecontent=[[NSMutableString alloc]init];
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
