//
//  LocalHost.m
//  NetworkScanner
//
//  Created by Mark Feeney on 20/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "LocalHost.h"
#import "Reachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <netdb.h>
 #include <arpa/inet.h>

@implementation LocalHost

@synthesize hostName = _hostName;
@synthesize ipAddress = _ipAddress;
@synthesize subnetMask = _subnetMask;
@synthesize defaultGateway = _defaultGateway;
@synthesize dnsServer = _dnsServer;
@synthesize externalIPAddress = _externalIPAddress;
@synthesize macAddress = _macAddress;
@synthesize ssid = _ssid;
@synthesize bssid = _bssid;
@synthesize networkConnected = _networkConnected;


- (id) init {
    self = [super init];
    if(self){
        _hostName = @"hosatname";
        //_ipAddress = _ipAddress;
        _subnetMask = @"SubnetMask";
        _defaultGateway = @"defaultGateway";
        _dnsServer = @"dnsServer";
        _macAddress = @"macAddress";
        _ssid = @"ssid";
        _bssid = @"bssid";
        _externalIPAddress = @"externalIPAddress";
        _networkConnected = FALSE;
    }
    return self;
}

-(id)initWithHostDetails{
    
     if ( self = [super init] ) {
         CFArrayRef myArray = CNCopySupportedInterfaces();
         // Get the dictionary containing the captive network infomation
         CFDictionaryRef captiveNtwrkDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
         NSLog(@"Information of the network we're connected to: %@", captiveNtwrkDict);
         NSDictionary *dict = (__bridge NSDictionary*) captiveNtwrkDict;
         
         [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
             NSLog(@"%@ => %@", key, obj);
         }];
         
         // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
         // method "reachabilityChanged" will be called.
         [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
         
         
         self.reach = [Reachability reachabilityForLocalWiFi]; //retain reach
         [self.reach startNotifier];
         
         NetworkStatus remoteHostStatus = [self.reach currentReachabilityStatus];
                                   
         _hostName = @"hosatname";
         //_ipAddress = _ipAddress;
         _subnetMask = @"SubnetMask";
         _defaultGateway = @"defaultGateway";
         _dnsServer = @"dnsServer";
         _macAddress = @"macAddress";
         _ssid = [dict objectForKey:@"SSID"];
         _bssid = [dict objectForKey:@"BSSID"];
         _externalIPAddress = @"externalIPAddress";
         
         if (remoteHostStatus == ReachableViaWiFi)
             _networkConnected = TRUE;
         else
             _networkConnected = FALSE;
         

     }
    
        
        return self;
    
}
-(void)reload{
    CFArrayRef myArray = CNCopySupportedInterfaces();
    // Get the dictionary containing the captive network infomation
    CFDictionaryRef captiveNtwrkDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    NSLog(@"Information of the network we're connected to: %@", captiveNtwrkDict);
    NSDictionary *dict = (__bridge NSDictionary*) captiveNtwrkDict;
    
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"%@ => %@", key, obj);
    }];
    
    // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the
    // method "reachabilityChanged" will be called.
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    
    self.reach = [Reachability reachabilityForLocalWiFi]; //retain reach
    [self.reach startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reach currentReachabilityStatus];
    
    _hostName = @"hosatname";
    //_ipAddress = _ipAddress;
    _subnetMask = @"SubnetMask";
    _defaultGateway = @"defaultGateway";
    _dnsServer = @"dnsServer";
    _macAddress = @"macAddress";
    _ssid = [dict objectForKey:@"SSID"];
    _bssid = [dict objectForKey:@"BSSID"];
    _externalIPAddress = @"externalIPAddress";
    
    if (remoteHostStatus == ReachableViaWiFi)
        _networkConnected = TRUE;
    else
        _networkConnected = FALSE;

}



//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    [self.localhostDelegate networkstatusHasChanged];
    
    [self reload];
    
	//[self updateInterfaceWithReachability: curReach];
}

- (NSString *)ipAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces 
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    return address;//    NSString *address = @"error";
}


@end
