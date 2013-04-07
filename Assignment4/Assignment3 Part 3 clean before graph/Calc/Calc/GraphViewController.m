//
//  GraphViewController.m
//  Calc
//
//  Created by Mark Feeney on 01/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "GraphViewController.h"
#import "AxesDrawer.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initifalization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ZoomInPressed:(UIBarButtonItem *)sender {

    self.graphview.scale ++;
    [self.graphview setNeedsDisplay];

}

- (IBAction)ZoomOutPressed:(UIBarButtonItem *)sender {
    
    self.graphview.scale --;
    [self.graphview setNeedsDisplay];
    
}

-(NSArray *)getGraphData{
    
    NSMutableArray *graphdata = [[NSMutableArray alloc] init];
   
    
    return graphdata;}

@end
