//
//  LANInfo.h
//  NetworkScanner
//
//  Created by Mark Feeney on 15/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LANInfo : NSObject

@property (strong, nonatomic) NSString *internalIPV4Address;
@property (strong, nonatomic) NSString *internalSubnetMask;
@property (strong, nonatomic) NSString *internalIPV6Address;
@property (strong, nonatomic) NSString *internalIPV6PrefixLength;
@property (strong, nonatomic) NSString *internalMACAddress;

@property (strong, nonatomic) NSString *externalIPV4Address;
@property (strong, nonatomic) NSString *externalSubnetMask;
@property (strong, nonatomic) NSString *externalMACAddress;

@property (strong, nonatomic) NSString *hostName;

@end
