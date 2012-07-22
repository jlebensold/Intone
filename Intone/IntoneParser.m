//
//  IntoneParser.m
//  Intone
//
//  Created by Jonathan Lebensold on 12-07-21.
//  Copyright (c) 2012 J. F. Lebensold. All rights reserved.
//

#import "IntoneParser.h"

@implementation IntoneParser

- (IntoneParser *) initWithDelegate: (id) d url: (NSURL *) u {
	self = [super init];
	delegate = d;
    url = [u copy];
	thread = [NSThread currentThread];				// Assumed delegate's thread
    
	outstring = [[NSMutableString alloc] init];
	
	myThread = [[NSThread alloc] initWithTarget:self selector:@selector(run:) object: nil];
    [myThread start];
	return self;
}

@end

