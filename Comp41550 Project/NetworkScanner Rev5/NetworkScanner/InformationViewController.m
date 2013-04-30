//
//  InformationViewController.m
//  NetworkScanner
//
//  Created by Mark Feeney on 05/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "InformationViewController.h"
#import "LocalHost.h"

@interface InformationViewController ()

@end

@implementation InformationViewController
@synthesize localhost = _localhost;

- (LocalHost *) getlocalhost
{
    if (!_localhost){
    _localhost = [[LocalHost alloc]initWithHostDetails];
    }
    return _localhost;
}


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

    
    _localhost = [[LocalHost alloc]initWithHostDetails];

    self.localhost.localhostDelegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in each section.
    switch(section){
        case 0:
            return 5;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 4;
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


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    
    switch (section)
    {
        case 0:
            sectionName = @"Internal Connection";
            break;
        case 1:
            sectionName = @"External Connection";
            break;
        case 2:
            sectionName = @"Wi-Fi Information";
            break;
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSString *textLabelHeading;
    NSString *textLabelDetail;
    NSString *imageToDisplay;
        
    if(indexPath.section == 0){
        switch (indexPath.row){
            case 0:
                textLabelHeading =  @"IP Address";
                textLabelDetail =  [self localhost].ipAddress;
                break;
            case 1:
                textLabelHeading = @"Subnet Mask";
                textLabelDetail = [self localhost].subnetMask;
                break;
            case 2:
                textLabelHeading = @"Default Gateway";
                textLabelDetail =  [self localhost].defaultGateway;
                break;
            case 3:
                textLabelHeading = @"MAC Address";
                textLabelDetail =  [self localhost].macAddress;
                break;
            case 4:
                textLabelHeading = @"DNS Server";
                textLabelDetail =  [self localhost].dnsServer;
                break;
            default:
                break;
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row){
            case 0:
                textLabelHeading =  @"External IP Address";
                textLabelDetail =  [self localhost].externalIPAddress;
                break;
            case 1:
                //textLabelHeading = @"SSID";
                //textLabelDetail =  @"1.0";
                //imageToDisplay = @"about.png";
                break;
            default:
                break;
        }
        
    }else if(indexPath.section == 2){
        switch (indexPath.row){
            case 0:
                textLabelHeading =  @"Network Connected";
                if ([self localhost].networkConnected){
                    textLabelDetail =  @"Yes";
                    imageToDisplay = @"green_dot.png";
                }else{
                    textLabelDetail =  @"No";
                    imageToDisplay = @"red_dot.png";
                }
                break;
            case 1:
                textLabelHeading = @"SSID";
                textLabelDetail =  [self localhost].SSID;
                break;
            case 2:
                textLabelHeading = @"BSSID";
                textLabelDetail =  [self localhost].BSSID;
                break;
            case 3:
                textLabelHeading =  @"Internet Connected";
                if ([self localhost].internetConnected){
                    textLabelDetail =  @"Yes";
                    imageToDisplay = @"green_dot.png";
                }else{
                    textLabelDetail =  @"No";
                    imageToDisplay = @"red_dot.png";
                }
                break;
            
            default:
                break;
        }
        
    }
    
    //Create the Label & Image for the Cell
    UILabel *myTextLabelHeading = [[UILabel alloc] init];
    UILabel *myTextLabelDetail = [[UILabel alloc] init];
    UIImage *image = [UIImage imageNamed:imageToDisplay];
    
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
    
    [cell.contentView addSubview:containerView];
    
}

#pragma mark - LocalHostDelegate -
-(void)networkstatusHasChanged{
    
    [self.tableView reloadData];
    
}


@end
