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
@synthesize isInTheMiddleOftypingSomething = _isInTheMiddleOftypingSomething;


-(IBAction)digitPressed:(UIButton *)sender{
    NSString *digit = sender.titleLabel.text;
    if(self.isInTheMiddleOftypingSomething)
        self.calcDisplay.text = [self.calcDisplay.text stringByAppendingString:digit];
    else{
        [self.calcDisplay setText:digit];
        self.isInTheMiddleOftypingSomething = YES;
    }
}

-(IBAction)operationPressed:(UIButton *)sender
{
    if(self.isInTheMiddleOftypingSomething){
        self.calcModel.operand = [self.calcDisplay.text doubleValue];
        self.isInTheMiddleOftypingSomething = NO;
    }
    //NSString *operation = [[sender titleLabel] text];
    NSString *operation = sender.titleLabel.text;
    double result = [[self calcModel] performOperation:operation];
    [self.calcDisplay setText:[NSString stringWithFormat:@"%g", result]];
    
}
@end
