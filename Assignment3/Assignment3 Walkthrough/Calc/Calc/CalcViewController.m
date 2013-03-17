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
// @synthesize not required as Xcode synthesizes automatically
@synthesize calcModel = _calcModel;
@synthesize calcDisplay = _calcDisplay;
@synthesize isInTheMiddleOfTypingSomething = _isInTheMiddleOfTypingSomething;

- (void)viewDidLoad
{
    self.calcModel.calcModelDelegate = self;
}

-(IBAction)digitPressed:(UIButton *)sender{
    NSString *digit = sender.titleLabel.text;
    //Clear any preceeding error message
    self.calcDisplayErrorMessage.text = @"";
    self.calcDisplay.hidden = FALSE;
    
    // Validation to prevent user enter leading 0's
    if(self.isInTheMiddleOfTypingSomething){
        if(!([self.calcDisplay.text isEqualToString:@"0"] && [digit isEqualToString:@"0"]))
            self.calcDisplay.text = [self.calcDisplay.text stringByAppendingString:digit];
    }
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
    }
    NSString *operation = sender.titleLabel.text;
    double result = [[self calcModel] performOperation:operation];
    self.calcDisplay.text = [NSString stringWithFormat:@"%g", result];
}

#pragma mark - calcModelDelegate -
-(void)calculationErrorHasOccured:(NSString*)errormesage{
    self.calcDisplay.hidden = TRUE;
    self.calcDisplayErrorMessage.text = errormesage;
   }


@end
