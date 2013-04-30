//
//  LanViewController1.m
//  NetworkScanner
//
//  Created by Mark Feeney on 21/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "LanViewController.h"
#import "Host.h"


@interface LanViewController ()

@end

@implementation LanViewController

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
    
    Host *host1 = [[Host alloc]init];
    Host *host2= [[Host alloc]init];
    Host *host3= [[Host alloc]init];
    
    host1.ipAddress = @"192.168.0.10";
    host1.macAddress = @"AA:AA:AA:AA:AA:AA";
    host1.hostName = @"PC 1";

    host2.ipAddress = @"192.168.0.20";
    host2.macAddress = @"BB:BB:BB:BB:BB:BB";
    host2.hostName = @"PC 2";
    
    host3.ipAddress = @"192.168.0.30";
    host3.macAddress = @"CC:CC:CC:CC:CC:CC";
    host3.hostName = @"PC 3";
        
    hostsArray = [[NSArray alloc] initWithObjects:host1,host2,host3,nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *scanNetworkButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Scan"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(scanNetwork)];
    self.navigationItem.rightBarButtonItem = scanNetworkButton;
    
    
    }

-(IBAction)scanNetwork{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Scan Network!"
                                                      message:@"About to scan the network"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [hostsArray count];
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



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    return sectionName;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *textHostIPAddress;
    NSString *textHostName;
    NSString *textHostMacAddress;
    
    NSString *imageToDisplayLeft;
    NSString *imageToDisplayRight;
    
    
    
//    textHostIPAddress =  @"255.255.255.255";
//    textHostName = @"Host Name";
//    textHostMacAddress = @"FF:FF:FF:FF:FF:FF";
//    
//    imageToDisplayLeft = @"gray_dot.png";
//    imageToDisplayRight = @"gray_dot.png";
    
    textHostIPAddress = [[hostsArray objectAtIndex:indexPath.row] ipAddress];
    textHostName =[[hostsArray objectAtIndex:indexPath.row] hostName];
    textHostMacAddress = [[hostsArray objectAtIndex:indexPath.row] macAddress];
    
    imageToDisplayLeft = @"gray_dot.png";
    imageToDisplayRight = @"gray_dot.png";

    
    //Create the Label & Image for the Cell
    UILabel *textLabelHostIPAddress = [[UILabel alloc] init];
    UILabel *textLabelHostName = [[UILabel alloc] init];
    UILabel *textLabelHostMacAddress = [[UILabel alloc] init];
    
    UIImage *imageRight = [UIImage imageNamed:imageToDisplayLeft];
    UIImage *imageLeft = [UIImage imageNamed:imageToDisplayRight];
    
    //Create a container for the cell
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 600, 40)];
    //Set value for label text and image name
    textLabelHostIPAddress.text = textHostIPAddress;
    //myTextLabelHeading.font = [UIFont fontWithName:@"Helvetica" size:14];
    textLabelHostIPAddress.font = [UIFont boldSystemFontOfSize:15.0];
    //myTextLabelHeading.textColor = [UIColor blueColor];
    textLabelHostIPAddress.frame= CGRectMake(15,10,250,20);
    //myTextLabelHeading.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageViewLeft =[[UIImageView alloc]initWithImage:imageLeft];
    imageViewLeft.frame= CGRectMake(5,10,25,20);

    textLabelHostIPAddress.text = textHostIPAddress;
    textLabelHostIPAddress.font = [UIFont fontWithName:@"Verdana" size:12];
    textLabelHostIPAddress.textColor = [UIColor grayColor];
    textLabelHostIPAddress.textAlignment = NSTextAlignmentLeft;
    textLabelHostIPAddress.frame = CGRectMake(30,10,110,20);
    //textLabelHostIPAddress.backgroundColor = [UIColor redColor];
    
    textLabelHostName.text = textHostName;
    textLabelHostName.font = [UIFont fontWithName:@"Verdana" size:14];
    textLabelHostName.textColor = [UIColor blueColor];
    textLabelHostName.textAlignment = NSTextAlignmentCenter;
    textLabelHostName.frame= CGRectMake(140,10,410,20);
    //textLabelHostName.backgroundColor = [UIColor greenColor];
    
    textLabelHostMacAddress.text = textHostMacAddress;
    textLabelHostMacAddress.font = [UIFont fontWithName:@"Verdana" size:12];
    textLabelHostMacAddress.textColor = [UIColor grayColor];
    textLabelHostMacAddress.textAlignment = NSTextAlignmentLeft;
    textLabelHostMacAddress.frame= CGRectMake(530,10,160,20);
    //textLabelHostMacAddress.backgroundColor = [UIColor blueColor];
    
    UIImageView *imageViewRight =[[UIImageView alloc]initWithImage:imageRight];
    imageViewRight.frame= CGRectMake(670,10,25,20);
    
    [containerView addSubview:textLabelHostIPAddress];
    [containerView addSubview:textLabelHostName];
    [containerView addSubview:textLabelHostMacAddress];
    [containerView addSubview:imageViewRight];
    [containerView addSubview:imageViewLeft];
    
    [cell.contentView addSubview:containerView];
    
}

@end
