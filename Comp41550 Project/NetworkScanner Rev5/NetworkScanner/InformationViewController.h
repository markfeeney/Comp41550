//
//  InformationViewController.h
//  NetworkScanner
//
//  Created by Mark Feeney on 05/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocalHost.h"
#import "Reachability.h"

@interface InformationViewController : UITableViewController <LocalHostlDelegate>

@property (strong) LocalHost *localhost;

@end
