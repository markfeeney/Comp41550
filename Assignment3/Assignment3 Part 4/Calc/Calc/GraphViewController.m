//
//  GraphViewController.m
//  Calc
//
//  Created by Mark Feeney on 01/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "GraphViewController.h"
#import "AxesDrawer.h"

@interface GraphViewController (){
    UINavigationBar *navBar;
}

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

@implementation GraphViewController


@synthesize calcExpression = _calcExpression;
@synthesize toolbar = _toolbar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.splitViewController.delegate = self;
    self.view = [[GraphView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ // if in split view
        [toolbar setItems:items animated:YES];
        self.toolbar = toolbar;
        [self.view addSubview:toolbar];
    }
    
    self.graphview = (GraphView*) self.view;
    self.graphview.graphviewDataSource = self;
    self.graphview.scale = 1;
    self.graphview.origin = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
            
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    float x = [prefs floatForKey:@"Xorigin"];
    float y = [prefs floatForKey:@"Yorigin"];
    float scale = [prefs floatForKey:@"Scale"];
        
    if (scale != 0) self.graphview.scale = scale;
   
    if (x!=0 && y!=0) self.graphview.origin = CGPointMake(x, y);
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.graphview addGestureRecognizer:doubleTapGestureRecognizer];
    
    UIPinchGestureRecognizer *handlePinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.graphview addGestureRecognizer:handlePinch];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [panGestureRecognizer setMaximumNumberOfTouches:1];
    [self.graphview  addGestureRecognizer:panGestureRecognizer];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ZoomInPressed:(UIBarButtonItem *)sender {
    
    self.graphview.scale++;
    [self updateViewAndState];
}

- (IBAction)ZoomOutPressed:(UIBarButtonItem *)sender {
    self.graphview.scale--;
    [self updateViewAndState];
}

- (NSArray*)getGraphDataPoints {
   
    double x=0;
    double y=0;
    
    NSMutableArray *graphDataPoints = [[NSMutableArray alloc] init];
   
    if (!(self.calcExpression))
        return nil;
    
    for (x = -100;x<=100;x+=50) {
        NSLog(@"%@",[NSNumber numberWithDouble:x]);
        NSDictionary *myvars = @{@"x": [[NSNumber numberWithDouble:x] stringValue]};
       
        y = [CalcModel evaluateExpression:self.calcExpression usingVariableValues:myvars];
        
        [graphDataPoints addObject:[NSValue valueWithCGPoint:CGPointMake(x,y)]];
    }
    return graphDataPoints;

}

-(void)expressionHasChanged:(id)expression{
    
    self.graphview.scale = 1;
    self.graphview.graphviewDataSource = self;
    self.calcExpression = expression;
       
    [self updateViewAndState];
}

-(void)handlePan:(UIPanGestureRecognizer*)recognizer {
    // Insert your own code to handle doubletap

    if (recognizer.state==UIGestureRecognizerStateChanged||
        recognizer.state==UIGestureRecognizerStateEnded) {
        CGPoint translation=[recognizer translationInView:self.view];
            
        //panning the origin property
        self.graphview.origin=CGPointMake(self.graphview.origin.x + translation.x, self.graphview.origin.y+ translation.y);
        [recognizer setTranslation:CGPointZero inView:self.view];
    }
    
    [self updateViewAndState];

}

- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
       
    if ( (recognizer.state == UIGestureRecognizerStateEnded) ||
        (recognizer.state == UIGestureRecognizerStateChanged) )
    {
        self.graphview.scale*=recognizer.scale;
        recognizer.scale=1.0;
    }
    
    [self updateViewAndState];
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer {
    // Insert your own code to handle doubletap
        
    CGRect screenRect = self.view.bounds;
    CGFloat x = screenRect.size.width / 2;
    CGFloat y = screenRect.size.height / 2;
    
    self.graphview.origin = CGPointMake(x,y);
    self.graphview.scale = 1;
    
    [self updateViewAndState];
}


-(void)updateViewAndState{

    [self.graphview setNeedsDisplay];
    [self SaveGraphSettings];
}

-(void)SaveGraphSettings
{
    // Save Settings
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setFloat:self.graphview.scale  forKey:@"Scale"];
    [prefs setFloat:self.graphview.origin.x  forKey:@"Xorigin"];
    [prefs setFloat:self.graphview.origin.y  forKey:@"Yorigin"];
    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
   
    BOOL show = !(toInterfaceOrientation == UIInterfaceOrientationPortrait ||
                 toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
           
    navBar.hidden  = show;
        
}

- (BOOL)splitViewController:(UISplitViewController *)splitviewController
        shouldHideViewController:(UIViewController *)viewController
        inOrientation:(UIInterfaceOrientation)orientation {
    
    // Display master controller if in landscape mode
    return UIInterfaceOrientationIsPortrait(orientation);
    
}

- (void)splitViewController:(UISplitViewController *)splitviewController
        willHideViewController:(UIViewController *)viewController
        withBarButtonItem:(UIBarButtonItem *)barButtonItem
        forPopoverController:(UIPopoverController *)popoverControllerc {
    
    // Show the bar button on the toolbar
    barButtonItem.title = viewController.title;
    barButtonItem.title = @"Calculator";
    
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems insertObject:barButtonItem atIndex:0];
    self.toolbar.items = toolbarItems;
}

- (void)splitViewController:(UISplitViewController *)splitviewController
        willShowViewController:(UIViewController *)viewController
        invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    
    // Hide it
    NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
    [toolbarItems removeObject:barButtonItem];
    self.toolbar.items = toolbarItems;
}


@end
