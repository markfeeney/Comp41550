//
//  ViewController.m
//  HelloPolly
//
//  Created by Mark Feeney on 16/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) PolygonShape *polygonModel;

@end

@implementation ViewController

- (PolygonShape *)polygonModel
{
    if (!_polygonModel) {
        _polygonModel = [[PolygonShape alloc] init];
    }
    return _polygonModel;
}

- (int) numberOfSidesForPolygon {
    NSLog(@"ViewController numberOfSidesForPolygonView %i", self.polygonModel.numberOfSides);
    return self.polygonModel.numberOfSides;
    
}

- (UIColor *) color {
    NSLog(@"ViewController color %@", self.polygonModel.color);
    return self.polygonModel.color;
}

-(void)viewWillAppear:(BOOL)animated
{

    [self UpdateUI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.polygonModel.numberOfSides = [self.numberOfSidesLabel.text integerValue];
    // Get the color from NUSuserDefauls
    self.polygonModel.color = [self GetColorFromNSUserDefaults];
    [self.PoloygonView setPolygonViewDelegate:self];
    
    [self UpdateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sidesStepper:(id)sender {
    NSLog(@"%f", self.stepperValue.value);
    self.polygonModel.numberOfSides = self.stepperValue.value;
    
    [self UpdateUI];
    
}

- (IBAction)decreaseButton:(id)sender {
    self.polygonModel.numberOfSides = self.polygonModel.numberOfSides - 1;
    
    self.stepperValue.value = self.polygonModel.numberOfSides;
    
    [self UpdateUI];
}

- (IBAction)increaseButton:(id)sender {
    self.polygonModel.numberOfSides = self.polygonModel.numberOfSides + 1;
    
    self.stepperValue.value = self.polygonModel.numberOfSides;
    
    [self UpdateUI];
}


- (IBAction)swipeGestureRight:(UISwipeGestureRecognizer *)sender {
     [self increaseButton:nil];
    
}

- (IBAction)swipeGestureLeft:(UISwipeGestureRecognizer *)sender {
    [self decreaseButton:nil];

}

-(void) UpdateUI{
    // Update the screen label(s), and stepper.Value property
    NSLog(@"%@", [NSString stringWithFormat:@"%i", self.polygonModel.numberOfSides]);
    self.numberOfSidesLabel.text =  [NSString stringWithFormat:@"%i", self.polygonModel.numberOfSides];
    self.nameOfPolygon.text =  self.polygonModel.name;
    // Get the color from NUSuserDefauls
    self.polygonModel.color = [self GetColorFromNSUserDefaults];
    NSLog(@"Call to redraw the screen with number of sides of %i", self.polygonModel.numberOfSides);
    
    // Set buttons enabled / disabled state accordingly
    if (self.polygonModel.numberOfSides < 12){
        self.increaseButton.enabled = YES;
    }else{
        self.increaseButton.enabled = NO;
    }
    
    if (self.polygonModel.numberOfSides > 3){
        self.decreaseButton.enabled = YES;
    }else{
        self.decreaseButton.enabled = NO;
    }
    
    [self.PoloygonView setNeedsDisplay];
    
}

-(UIColor *)GetColorFromNSUserDefaults{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    float red = [prefs floatForKey:@"cr"];
    float green = [prefs floatForKey:@"cg"];
    float blue = [prefs floatForKey:@"cb"];
    float alpha = [prefs floatForKey:@"ca"];
    
    UIColor* savedColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    NSLog(@"%@", savedColor);
    
    return savedColor;
}


@end
