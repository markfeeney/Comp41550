//
//  CalcViewController.m
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "CalcViewController.h"
#import "GraphViewController.h"

@interface CalcViewController ()

@end

@implementation CalcViewController
// @synthesize not required as Xcode synthesizes automatically
@synthesize calcModel = _calcModel;
@synthesize calcDisplay = _calcDisplay;
@synthesize isInTheMiddleOfTypingSomething = _isInTheMiddleOfTypingSomething;
@synthesize isTypingFloatingPointNumber = _isTypingFloatingPointNumber;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.delegate = [self.splitViewController.viewControllers lastObject];
    self.calcModel.calcModelDelegate = self;

    self.contentSizeForViewInPopover = CGSizeMake(350, 800);

}

-(IBAction)digitPressed:(UIButton *)sender{
    NSString *digit = sender.titleLabel.text;
    //Clear any existing error message
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
        self.isTypingFloatingPointNumber = NO;
    }
    //NSString *operation = [[sender titleLabel] text];
    NSString *operation = sender.titleLabel.text;
    double result = [[self calcModel] performOperation:operation];
    self.calcDisplay.text = [NSString stringWithFormat:@"%g", result];
    self.memoryDisplay.text = [NSString stringWithFormat:@"%g", self.calcModel.memoryValue];
    self.expressionDisplay.text = [NSString stringWithFormat:@"%@", [self.calcModel descriptionOfExpresion:self.calcModel.expression]];
    [self.delegate expressionHasChanged:nil];
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

- (IBAction)backspacePressed:(UIButton *)sender {
    if (self.calcDisplay.text.length  > 1) {
        [self.calcDisplay setText:[self.calcDisplay.text substringToIndex:self.calcDisplay.text.length -1]];
    }else{
        [self.calcDisplay setText:@"0"];
        self.isInTheMiddleOfTypingSomething = NO;
    }
    
    //Cater for removing a decimal point
    if ([self.calcDisplay.text  rangeOfString:@"."].location == NSNotFound)
        self.isTypingFloatingPointNumber = NO;
}

- (IBAction)changeScaleUnits:(UISegmentedControl *)sender {
     
    // Set Scale Units Propertyto currently selected scale
    self.calcModel.scaleUnits = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    self.scaleUnitDisplay.text = self.calcModel.scaleUnits;
}

- (IBAction)variablePressed:(UIButton *)sender {
    NSString *operand = sender.titleLabel.text;
    [[self calcModel] setVariableAsOperand:operand];
}

- (IBAction)solveExpressionPresssed:(UIButton *)sender {
    
    NSDictionary *myvars = @{@"x": @"5", @"a": @"10", @"b": @"15", @"c": @"20" };
    
    NSLog(@"%@", self.calcModel.expression);
    
    double result = [CalcModel evaluateExpression:self.calcModel.expression usingVariableValues:myvars];
    
    self.calcDisplay.text   = [NSString stringWithFormat:@"%g", result];
    self.calcModel.operand = result;
}

- (IBAction)graphPressed:(UIButton *)sender {
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ // if in split view
        [self.delegate expressionHasChanged:self.calcModel.expression];
    }else{
        GraphViewController *graphViewController = [[GraphViewController alloc] init];
        graphViewController.calcExpression = self.calcModel.expression;
        [self.navigationController pushViewController:graphViewController animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    
    if([segue.identifier isEqualToString:@"GraphViewSegue"]){
        GraphViewController *graphViewController = (GraphViewController *)segue.destinationViewController;
        graphViewController.calcExpression = self.calcModel.expression;
                
    }
}


#pragma mark - calcModelDelegate -
-(void)calculationErrorHasOccured:(NSString*)errormesage{
    
    if(![errormesage isEqualToString:@""]){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"Calculator Error" message:errormesage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertview show];
        
        self.calcDisplay.hidden = TRUE;
    }else
        self.calcDisplay.hidden = FALSE;
    
    self.calcDisplayErrorMessage.text = errormesage;
}




@end


