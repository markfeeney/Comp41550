//
//  CalcViewController.h
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcModel.h"

@interface CalcViewController : UIViewController <CalcModelDelegate>

@property (nonatomic, weak)IBOutlet CalcModel *calcModel;
@property (nonatomic, weak)IBOutlet UILabel *calcDisplay;
@property (nonatomic) BOOL isInTheMiddleOfTypingSomething;
@property (nonatomic) BOOL isTypingFloatingPointNumber;
@property (weak, nonatomic) IBOutlet UILabel *calcDisplayErrorMessage;
@property (weak, nonatomic) IBOutlet UILabel *memoryDisplay;
@property (weak, nonatomic) IBOutlet UILabel *scaleUnitDisplay;
@property (weak, nonatomic) IBOutlet UILabel *expressionDisplay;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)decimalPressed:(UIButton *)sender;
- (IBAction)backspacePressed:(UIButton *)sender;
- (IBAction)changeScaleUnits:(UISegmentedControl *)sender;
- (IBAction)variablePressed:(UIButton *)sender;
- (IBAction)solveExpressionPresssed:(UIButton *)sender;
- (IBAction)graphPressed:(UIButton *)sender;

@end
