//
//  host.h
//  NetworkScanner
//
//  Created by Mark Feeney on 15/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Host : NSObject

@property (strong, nonatomic) NSString *ipV4Address;
@property (strong, nonatomic) NSString *subnetMask;
@property (strong, nonatomic) NSString *defaultGateway;
@property (strong, nonatomic) NSString *ipV6Address;
@property (strong, nonatomic) NSString *ipV6PrefixLength;

@property (strong, nonatomic) NSString *macAddress;
@property (strong, nonatomic) NSString *hostName;
@property (strong, nonatomic) NSString *status;

@end
