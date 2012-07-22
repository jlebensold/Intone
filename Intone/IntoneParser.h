//
//  IntoneParser.h
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-21.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntoneParser : NSObject <NSXMLParserDelegate>
{
	NSString		*current;
	NSMutableString	*outstring;
	NSURL			*url;
	id				delegate;
	NSThread		*thread;
    NSThread        *myThread;
}

- (IntoneParser *) initWithDelegate: (id) d url: (NSURL *) u;
@end
