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
        _ipAddress = @"ipaddress";
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
         _ipAddress = @"ipaddress";
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
    _ipAddress = @"ipaddress";
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

//- (void) updateInterfaceWithReachability: (Reachability*) curReach
//{
//
//    [self.tableView reloadData];
//
//
//    // NSLog(@"updateInterface");
//    //    if(curReach == hostReach)
//    //	{
//    //		[self configureTextField: remoteHostStatusField imageView: remoteHostIcon reachability: curReach];
//    //        NetworkStatus netStatus = [curReach currentReachabilityStatus];
//    //        BOOL connectionRequired= [curReach connectionRequired];
//    //
//    //        summaryLabel.hidden = (netStatus != ReachableViaWWAN);
//    //        NSString* baseLabel=  @"";
//    //        if(connectionRequired)
//    //        {
//    //            baseLabel=  @"Cellular data network is available.\n  Internet traffic will be routed through it after a connection is established.";
//    //        }
//    //        else
//    //        {
//    //            baseLabel=  @"Cellular data network is active.\n  Internet traffic will be routed through it.";
//    //        }
//    //        summaryLabel.text= baseLabel;
//    //    }
//    //	if(curReach == internetReach)
//    //	{
//    //		[self configureTextField: internetConnectionStatusField imageView: internetConnectionIcon reachability: curReach];
//    //	}
//    //	if(curReach == wifiReach)
//    //	{
//    //		[self configureTextField: localWiFiConnectionStatusField imageView: localWiFiConnectionIcon reachability: curReach];
//    //	}
//
//}



@end
