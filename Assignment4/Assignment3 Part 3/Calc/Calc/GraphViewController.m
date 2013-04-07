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
    self.graphview.graphviewDataSource = self;
    self.graphview.scale = 1;
     
    NSMutableString *title = [NSMutableString stringWithString:@"Graph of "];
    
    for(id obj in self.calcExpression ){
        [title appendString:[obj description]];
    }
    self.title = title;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ZoomInPressed:(UIBarButtonItem *)sender {

    self.graphview.scale++;
    [self.graphview setNeedsDisplay];

}

- (IBAction)ZoomOutPressed:(UIBarButtonItem *)sender {
    
    self.graphview.scale--;
    [self.graphview setNeedsDisplay];
    
}

- (NSArray*)getGraphDataPoints {
   
    double x=0;
    double y=0;
    
    NSMutableArray *graphDataPoints = [[NSMutableArray alloc] init];
    
    for (x = -100;x<=100;x+=50) {
        NSLog(@"%@",[NSNumber numberWithDouble:x]);
        NSDictionary *myvars = @{@"x": [[NSNumber numberWithDouble:x] stringValue]};
       
        y = [CalcModel evaluateExpression:self.calcExpression usingVariableValues:myvars];
        
        [graphDataPoints addObject:[NSValue valueWithCGPoint:CGPointMake(x,y)]];
    }

    return graphDataPoints;
}


@end
