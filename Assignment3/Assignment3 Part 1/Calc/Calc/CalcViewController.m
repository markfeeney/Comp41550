//
//  CalcViewController.m
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "CalcViewController.h"

@interface CalcViewController ()

@end

@implementation CalcViewController
// @synthesize not really required as Xcode synthesizes automatically
@synthesize calcModel = _calcModel;
@synthesize calcDisplay = _calcDisplay;
@synthesize isInTheMiddleOfTypingSomething = _isInTheMiddleOfTypingSomething;
@synthesize isTypingFloatingPointNumber = _isTypingFloatingPointNumber;



-(IBAction)digitPressed:(UIButton *)sender{
    NSString *digit = sender.titleLabel.text;
    if(self.isInTheMiddleOfTypingSomething)
        self.calcDisplay.text = [self.calcDisplay.text stringByAppendingString:digit];
    else{
        [self.calcDisplay setText:digit];
        self.isInTheMiddleOfTypingSomething = YES;
    }
}

-(IBAction)operationPressed:(UIButton *)sender
{
    if(self.isInTheMiddleOfTypingSomething){
        self.calcModel.operand = [self.calcDisplay.text doubleValue];
        self.isInTheMiddleOfTypingSomething = NO;
        self.isTypingFloatingPointNumber = NO;
        
    }
    //NSString *operation = [[sender titleLabel] text];
    NSString *operation = sender.titleLabel.text;
    double result = [[self calcModel] performOperation:operation];
    [self.calcDisplay setText:[NSString stringWithFormat:@"%g", result]];
    
}

- (IBAction)decimalPressed:(UIButton *)sender {
    if (self.isTypingFloatingPointNumber)
        return; // Returning if decimal was already pressed when
    else
        self.isTypingFloatingPointNumber = YES;
    
    if(self.isInTheMiddleOfTypingSomething)
        self.calcDisplay.text = [self.calcDisplay.text stringByAppendingString:@"."];
    else{
        [self.calcDisplay setText:@"0."];
        self.isInTheMiddleOfTypingSomething = YES;
    }
}
@end
