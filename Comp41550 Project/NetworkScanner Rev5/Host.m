//
//  host.m
//  NetworkScanner
//
//  Created by Mark Feeney on 27/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "Host.h"

@implementation Host

@synthesize hostName = _hostName;
@synthesize ipAddress = _ipAddress;
@synthesize macAddress = _macAddress;


- (id) init {
    self = [super init];
    
    return self;
}




@end
