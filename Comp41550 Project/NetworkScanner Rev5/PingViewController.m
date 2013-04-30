//
//  PingViewController.m
//  NetworkScanner
//
//  Created by Mark Feeney on 27/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "PingViewController.h"
#import "Host.h"
#import "SimplePing.h"
#include <sys/socket.h>
#include <netdb.h>

#pragma mark * Utilities

static NSString * DisplayAddressForAddress(NSData * address)
// Returns a dotted decimal string for the specified address (a (struct sockaddr)
// within the address NSData).
{
    int         err;
    NSString *  result;
    char        hostStr[NI_MAXHOST];
    
    result = nil;
    
    if (address != nil) {
        err = getnameinfo([address bytes], (socklen_t) [address length], hostStr, sizeof(hostStr), NULL, 0, NI_NUMERICHOST);
        if (err == 0) {
            result = [NSString stringWithCString:hostStr encoding:NSASCIIStringEncoding];
            assert(result != nil);
        }
    }
    
    return result;
}

@interface PingViewController ()

@end

@implementation PingViewController{
    @private BOOL showpingresults;
}

@synthesize pinger    = _pinger;
@synthesize sendTimer = _sendTimer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pingData = [[NSMutableArray alloc]init];

    showpingresults = FALSE;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *startPingButton = [[UIBarButtonItem alloc]
                                        initWithTitle:@"Ping"
                                        style:UIBarButtonItemStyleBordered
                                        target:self
                                        action:@selector(startPing)];
    
    self.navigationItem.rightBarButtonItem = startPingButton;
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.placeholder = @"Hostname / IP Address";
    
    searchBar.text = @"192.168.0.5";
    //add the searchBar on the top of tableView.
    self.tableView.tableHeaderView = searchBar;
    
        
}

-(IBAction)startPing{
    
    showpingresults = !(showpingresults);

    if (showpingresults){
        [self.navigationItem.rightBarButtonItem setTitle:@"Stop"];
        [self startPinging:showpingresults];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"Ping"];
        [self.pinger stop];
        [self->_sendTimer invalidate];
        
    }
}

-(void)startPinging:(Boolean)continious{
    
    [self runWithHostName:searchBar.text];
   

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in each section.
    switch(section){
        case 0:
            return 1;
            break;
        case 1:
            if(showpingresults == FALSE)
                return 0;
            else
                return [pingData count];
            break;
        default:
            return 0;
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *textLabelHeading;
    NSString *textLabelDetail;
    NSString *imageToDisplay;
    
    if(indexPath.section == 0){
        switch (indexPath.row){
            case 0:
                textLabelHeading =  @"Continious Ping";
                break;
            default:

                
                break;
        }
    }else if(indexPath.section == 1){
            textLabelHeading =  [[pingData objectAtIndex:indexPath.row] ipAddress];
            textLabelDetail =  [[pingData objectAtIndex:indexPath.row] macAddress];
            //textLabelHeading2 =  [[pingData objectAtIndex:indexPath.row] ];
        
//        switch (indexPath.row){
//            case 0:
//                textLabelHeading =  [[pingData objectAtIndex:indexPath.row] ipAddress];
//                break;
//            default:
//                break;
//        }
    }
    
       
    //Create the Label & Image for the Cell
    UILabel *myTextLabelHeading = [[UILabel alloc] init];
    UILabel *myTextLabelDetail = [[UILabel alloc] init];
    UIImage *image = [UIImage imageNamed:imageToDisplay];
    UISwitch *continiousPing =[[UISwitch alloc]init];
    
    //Create a container for the cell
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 600, 40)];
    myTextLabelHeading.text = textLabelHeading;
    myTextLabelHeading.font = [UIFont boldSystemFontOfSize:15.0];
    myTextLabelHeading.frame= CGRectMake(15,10,250,20);
    myTextLabelDetail.text = textLabelDetail;
    myTextLabelDetail.font = [UIFont fontWithName:@"Verdana" size:14];
    myTextLabelDetail.textColor = [UIColor blueColor];
    myTextLabelDetail.textAlignment = NSTextAlignmentRight;
    myTextLabelDetail.frame= CGRectMake(335,10,250,20);
    
    UIImageView *imageView =[[UIImageView alloc]initWithImage:image];
    imageView.frame= CGRectMake(585,10,20,20);
    
    [containerView addSubview:myTextLabelHeading];
    [containerView addSubview:myTextLabelDetail];
    [containerView addSubview:imageView];
    
    if (indexPath.section == 0){
        continiousPing.on = TRUE;
        continiousPing.frame= CGRectMake(520,10,120,20);
        [containerView addSubview:continiousPing];
    }
    
    [cell.contentView addSubview:containerView];
    
}

- (NSString *)shortErrorFromError:(NSError *)error
// Given an NSError, returns a short error string that we can print, handling
// some special cases along the way.
{
    NSString *      result;
    NSNumber *      failureNum;
    int             failure;
    const char *    failureStr;
    
    assert(error != nil);
    
    result = nil;
    
    // Handle DNS errors as a special case.
    
    if ( [[error domain] isEqual:(NSString *)kCFErrorDomainCFNetwork] && ([error code] == kCFHostErrorUnknown) ) {
        failureNum = [[error userInfo] objectForKey:(id)kCFGetAddrInfoFailureKey];
        if ( [failureNum isKindOfClass:[NSNumber class]] ) {
            failure = [failureNum intValue];
            if (failure != 0) {
                failureStr = gai_strerror(failure);
                if (failureStr != NULL) {
                    result = [NSString stringWithUTF8String:failureStr];
                    assert(result != nil);
                }
            }
        }
    }
    
    // Otherwise try various properties of the error object.
    
    if (result == nil) {
        result = [error localizedFailureReason];
    }
    if (result == nil) {
        result = [error localizedDescription];
    }
    if (result == nil) {
        result = [error description];
    }
    assert(result != nil);
    return result;
}

- (void)runWithHostName:(NSString *)hostName
// The Objective-C 'main' for this program.  It creates a SimplePing object
// and runs the runloop sending pings and printing the results.
{
    //assert(self.pinger == nil);
    
    self.pinger = [SimplePing simplePingWithHostName:hostName];
    assert(self.pinger != nil);
    
    self.pinger.delegate = self;
    [self.pinger start];
    
    do {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    } while (self.pinger != nil);
}

- (void)sendPing
// Called to send a ping, both directly (as soon as the SimplePing object starts up)
// and via a timer (to continue sending pings periodically).
{
    assert(self.pinger != nil);
    [self.pinger sendPingWithData:nil];
}

- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address
// A SimplePing delegate callback method.  We respond to the startup by sending a
// ping immediately and starting a timer to continue sending them every second.
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
    assert(address != nil);
    
    NSLog(@"pinging %@", DisplayAddressForAddress(address));
    
    // Send the first ping straight away.
    [self sendPing];
    
    // And start a timer to send the subsequent pings.
    assert(self.sendTimer == nil);
    self.sendTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendPing) userInfo:nil repeats:YES];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error
// A SimplePing delegate callback method.  We shut down our timer and the
// SimplePing object itself, which causes the runloop code to exit.
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(error)
    NSLog(@"failed: %@", [self shortErrorFromError:error]);
    
    [self.sendTimer invalidate];
    self.sendTimer = nil;
    
    // No need to call -stop.  The pinger will stop itself in this case.
    // We do however want to nil out pinger so that the runloop stops.
    
    self.pinger = nil;
}

- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet
// A SimplePing delegate callback method.  We just log the send.
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
    NSLog(@"#%u sent", (unsigned int) OSSwapBigToHostInt16(((const ICMPHeader *) [packet bytes])->sequenceNumber) );
    
}

- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet error:(NSError *)error
// A SimplePing delegate callback method.  We just log the failure.
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
#pragma unused(error)
    NSLog(@"#%u send failed: %@", (unsigned int) OSSwapBigToHostInt16(((const ICMPHeader *) [packet bytes])->sequenceNumber), [self shortErrorFromError:error]);
    
    Host *newHost = [[Host alloc]init];
    newHost.ipAddress = [self shortErrorFromError:error];
    
    [self addResponseToTableView:newHost];

}

- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet
// A SimplePing delegate callback method.  We just log the reception of a ping response.
{
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
    NSLog(@"#%u received", (unsigned int) OSSwapBigToHostInt16([SimplePing icmpInPacket:packet]->sequenceNumber) );
    
    Host *newHost = [[Host alloc]init];
    newHost.ipAddress = [NSString stringWithFormat:@"%hu", OSSwapBigToHostInt16([SimplePing icmpInPacket:packet]->sequenceNumber)];
    //newHost.macAddress = (__bridge NSString *)([SimplePing icmpInPacket:p]);
    
    
     // NSLog(@"%@",[SimplePing icmpInPacket:packet]);
    
    [self addResponseToTableView:newHost];
    
        
}

-(void)addResponseToTableView:(Host*)hostData {
    
    [pingData insertObject:hostData atIndex:0];
    //[self.tableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet
// A SimplePing delegate callback method.  We just log the receive.
{
    const ICMPHeader *  icmpPtr;
    
#pragma unused(pinger)
    assert(pinger == self.pinger);
#pragma unused(packet)
    
    icmpPtr = [SimplePing icmpInPacket:packet];
    if (icmpPtr != NULL) {
        NSLog(@"#%u unexpected ICMP type=%u, code=%u, identifier=%u", (unsigned int) OSSwapBigToHostInt16(icmpPtr->sequenceNumber), (unsigned int) icmpPtr->type, (unsigned int) icmpPtr->code, (unsigned int) OSSwapBigToHostInt16(icmpPtr->identifier) );
    } else {
        NSLog(@"unexpected packet size=%zu", (size_t) [packet length]);
    }
    
    Host *newHost = [[Host alloc]init];
    newHost.ipAddress = [NSString stringWithFormat:@"%hu", OSSwapBigToHostInt16([SimplePing icmpInPacket:packet]->sequenceNumber)];
    
    [self addResponseToTableView:newHost];
}

@end
