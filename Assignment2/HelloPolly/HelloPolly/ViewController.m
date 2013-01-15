//
//  ViewController.m
//  HelloPolly
//
//  Created by Mark Feeney on 14/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)decrease:(id)sender {
    NSLog(@"I am in the decrease method");
    
    
    self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d",[self.numberOfSidesLabel.text intValue]-1];
      
    
}

- (IBAction)increase:(UIButton *)sender {
    
    NSLog(@"I am in the increase method");
     self.numberOfSidesLabel.text = [NSString stringWithFormat:@"%d",[self.numberOfSidesLabel.text intValue]+1];
     
}

- (void)viewDidLoad
{
   // self.model.numberOfSides=[self.numberOfSidesLabel.text integerValue];
    
    //[self setNumberOfSidesLabel:nil];
    [self setModel:nil];
    [super viewDidLoad];
	// Do any additional /setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)awakeFromNib {
    
    NSLog(@"My polygon: %@", self.model.name);
    
    [super awakeFromNib];
    
}

@end
