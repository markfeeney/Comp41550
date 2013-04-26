//
//  PingPacket.h
//  NetworkScanner
//
//  Created by Mark Feeney on 15/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PingPacket : NSObject

@property (nonatomic) int pingPacketNumber;
@property (strong, nonatomic) NSString *ipV4DestinationAddress;
@property (nonatomic) float pingResponseTime;

@end
