//
//  PingViewController.h
//  NetworkScanner
//
//  Created by Mark Feeney on 27/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePing.h"


@interface PingViewController : UITableViewController <SimplePingDelegate>{
    UISearchBar *searchBar;
    NSMutableArray *pingData;
}

@property (nonatomic, strong, readwrite) SimplePing *pinger;
@property (nonatomic, strong, readwrite) NSTimer *sendTimer;


@end
