//
//  host.h
//  NetworkScanner
//
//  Created by Mark Feeney on 27/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject

@property (nonatomic) NSString * hostName;
@property (nonatomic) NSString * ipAddress;
@property (nonatomic) NSString * macAddress;

@end
