//
//  ColorSelectorViewController.m
//  HelloPolly
//
//  Created by Mark Feeney on 20/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "ColorSelectorViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ColorSelectorViewController ()

@end

@implementation ColorSelectorViewController

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
	// Do any additional setup after loading the view.
    
    //Get current color and display sliders set to appropriate vlaues
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    float red = [prefs floatForKey:@"cr"];
    float green = [prefs floatForKey:@"cg"];
    float blue = [prefs floatForKey:@"cb"];
    float alpha = [prefs floatForKey:@"ca"];
    
    
    self.redColor.value = red * 255;
    self.greenColor.value = green * 255;
    self.blueColor.value = blue * 255;
    self.alpha = alpha;
    
    [self updateView];
    
    // Give the image view a black border
    [self.imageView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [self.imageView.layer setBorderWidth: 2.0];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateView {
    
    //self.polygonColorPreview.backgroundColor = [UIColor colorWithRed:self.redColor.value/255 green:self.greenColor.value/255 blue:self.blueColor.value/255 alpha:1.0];
    self.polygonColorPreview.backgroundColor = [UIColor colorWithRed:self.redColor.value/255 green:self.greenColor.value/255 blue:self.blueColor.value/255 alpha:self.alpha];
    // Save Settings
    UIColor *color  = self.polygonColorPreview.backgroundColor;
    NSLog(@"%@", color);
    self.alpha = 1.0;   
    [self SaveColorSettings];

   }
-(void)SaveColorSettings
{
    // Save Settings
    UIColor *color  = self.polygonColorPreview.backgroundColor;
    
    NSLog(@"%@", color);

    const CGFloat  *components = CGColorGetComponents(color.CGColor);
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setFloat:components[0]  forKey:@"cr"];
    [prefs setFloat:components[1]  forKey:@"cg"];
    [prefs setFloat:components[2]  forKey:@"cb"];
    [prefs setFloat:components[3]  forKey:@"ca"];
}



@end
