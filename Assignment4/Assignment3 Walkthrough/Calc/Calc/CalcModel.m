//
//  CalcModel.m
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "CalcModel.h"

@implementation CalcModel
// @synthesize not required as Xcode synthesizes automatically
@synthesize operand = _operand;
@synthesize waitingOperand = _waitingOperand;
@synthesize waitingOperation = _waitingOperation;
@synthesize calcModelDelegate;

-(void)performWaitingOperation
{
    if([@"+" isEqualToString:self.waitingOperation])
        //self.operand = self.waitingOperand + self.operand;
        self.operand += self.waitingOperand;
    else if([@"-" isEqualToString:self.waitingOperation])
        self.operand = self.waitingOperand - self.operand;
    else if([@"*" isEqualToString:self.waitingOperation])
        self.operand *= self.waitingOperand;
    else if([@"/" isEqualToString:self.waitingOperation]){
        if (self.operand)
            self.operand = self.waitingOperand / self.operand;
        else
            [self.calcModelDelegate calculationErrorHasOccured:@"Cannot divide by Zero"];
    }
}

-(double)performOperation:(NSString *)operation
{
    if([operation isEqual:@"sqrt"]){
        if(self.operand >=0)
            self.operand = sqrt(self.operand);
        else
            [self.calcModelDelegate calculationErrorHasOccured:@"Cannot get the Square Root of a Negative Number!"];
    }else { // must be a 2 operand operation
        [self performWaitingOperation];
        self.waitingOperation = operation;
        self.waitingOperand = self.operand;
    }
    return self.operand;
}

@end
