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
#include <net/if_dl.h>
#include <sys/sysctl.h>


@implementation LocalHost

@synthesize hostName = _hostName;
@synthesize ipAddress = _ipAddress;
@synthesize subnetMask = _subnetMask;
@synthesize defaultGateway = _defaultGateway;
@synthesize dnsServer = _dnsServer;
@synthesize externalIPAddress = _externalIPAddress;
@synthesize macAddress = _macAddress;
@synthesize SSID = _ssid;
@synthesize BSSID = _bssid;
@synthesize networkConnected = _networkConnected;
@synthesize internetConnected = _internetConnected;

- (id) init {
    self = [super init];
    
    return self;
}

-(id)initWithHostDetails{
    
    if (self = [super init]){

        // Get IP, Subnet mask and Default gateway
        [self getIPDetails];
        
        // Part 1 - Create Internet socket addr of zero
        struct sockaddr_in zeroAddr;
        bzero(&zeroAddr, sizeof(zeroAddr));
        zeroAddr.sin_len = sizeof(zeroAddr);
        zeroAddr.sin_family = AF_INET;
    
        // Part 2- Create target in format need by SCNetwork
        SCNetworkReachabilityRef target = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *) &zeroAddr);
    
        // Part 3 - Get the flags
        SCNetworkReachabilityFlags flags;
        SCNetworkReachabilityGetFlags(target, &flags);
    
        // Internet connection
        if (flags & kSCNetworkFlagsReachable)
            _internetConnected = TRUE;
        else
            _internetConnected = FALSE;
    
        // Network connection
        if (flags & kSCNetworkReachabilityFlagsIsWWAN){
            _networkConnected = TRUE;
        }else{
            _networkConnected = FALSE;
        }
	
        
        // Observe the kNetworkReachabilityChangedNotification. When that notification is posted, the method "reachabilityChanged" will be called.
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
        //self.reach = [Reachability reachabilityForLocalWiFi];
        //[self.reach startNotifier];

        [self getCurrentNetworkStatus];
    }
    return self;
}

-(void)getCurrentNetworkStatus{
    
    CFArrayRef myArray = CNCopySupportedInterfaces();
    // Get the dictionary containing the captive network infomation
    CFDictionaryRef captiveNtwrkDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
    NSDictionary *dict = (__bridge NSDictionary*) captiveNtwrkDict;
    
    _ssid = [dict objectForKey:@"SSID"];;
    _bssid = [dict objectForKey:@"BSSID"];
    
    self.reach = [Reachability reachabilityForInternetConnection];
    [self.reach startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reach currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWiFi)
        _networkConnected = TRUE;
    else
        _networkConnected = FALSE;
    
    BOOL connectionRequired= [self.reach connectionRequired];
    if (!(connectionRequired))
        _internetConnected = TRUE;
    else
        _internetConnected = FALSE;
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
    
    self.reach= [Reachability reachabilityForLocalWiFi]; //retain reach
    [self.reach startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reach currentReachabilityStatus];
    
    if (remoteHostStatus == ReachableViaWiFi)
        _networkConnected = TRUE;
    else
        _networkConnected = FALSE;
    
    [self getCurrentNetworkStatus];
    
}


//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    [self.localhostDelegate networkstatusHasChanged];
    
    [self reload];
}


- (NSString *)hostName {
    
    NSString *hostname = @"error";
        
    return hostname;
}

- (void)getIPDetails {
    
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
                _ipAddress = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                _subnetMask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                _defaultGateway = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                 }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
}

- (NSString *)subnetMask {
    
    return _subnetMask;
    
}

-(NSString *)macAddress{
    
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    NSString *errorFlag = NULL;
    size_t length;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    // Get the size of the data available (store in len)
    else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
        errorFlag = @"sysctl mgmtInfoBase failure";
    // Alloc memory based on above call
    else if ((msgBuffer = malloc(length)) == NULL)
        errorFlag = @"buffer allocation failure";
    // Get system information, store in buffer
    else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
    {
        free(msgBuffer);
        errorFlag = @"sysctl msgBuffer failure";
    }
    else
    {
        // Map msgbuffer to interface message structure
        struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
        // Map to link-level socket structure
        struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
        // Copy link layer address data in socket structure to an array
        unsigned char macAddress[6];
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
        // Read from char array into a string object, into traditional Mac address format
        NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                      macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
        NSLog(@"Mac Address: %@", macAddressString);
        // Release the buffer memory
        free(msgBuffer);
        return macAddressString;
    }
    // Error...
    NSLog(@"Error: %@", errorFlag);
    return errorFlag;
    
}

- (NSString *)defaultGateway {
    
    return _defaultGateway;
    
}

- (NSString *)externalIPAddress {

    return _externalIPAddress;
    
}



- (NSString *)SSID {
    
    if (_ssid.length == 0)
        _ssid = @"[N/A]";
    return _ssid;
    
}

- (NSString *)BSSID {
    
    if (_bssid.length == 0)
        _bssid = @"[N/A]";

    return _bssid;
    
}

- (Boolean)networkConnected {
    
    return _networkConnected;
    
}


- (Boolean)internetConnected {
    
    return _internetConnected;
    
}

@end
