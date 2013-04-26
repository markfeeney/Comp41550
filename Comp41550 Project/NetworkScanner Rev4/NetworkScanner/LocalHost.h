//
//  LocalHost.h
//  NetworkScanner
//
//  Created by Mark Feeney on 20/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocalHostlDelegate <NSObject>
-(void)networkstatusHasChanged;
@end

@class Reachability;

@interface LocalHost : NSObject{
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
}


@property (retain, nonatomic)  Reachability* reach;

@property (nonatomic) NSString * hostName;
@property (nonatomic) NSString * ipAddress;
@property (nonatomic) NSString * subnetMask;
@property (nonatomic) NSString * defaultGateway;
@property (nonatomic) NSString * externalIPAddress;
@property (nonatomic) NSString * dnsServer;
@property (nonatomic) NSString * macAddress;
@property (nonatomic) NSString * ssid;
@property (nonatomic) NSString * bssid;
@property (nonatomic) Boolean networkConnected;

@property (nonatomic,strong) id <LocalHostlDelegate> localhostDelegate;

-(id)initWithHostDetails;

@end
