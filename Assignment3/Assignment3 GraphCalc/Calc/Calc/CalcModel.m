//
//  CalcModel.m
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import "CalcModel.h"

@implementation CalcModel
@synthesize operand = _operand;
@synthesize waitingOperand = _waitingOperand;
@synthesize waitingOperation = _waitingOperation;

-(double)performOperation:(NSString *)operation
{
    if([operation isEqual:@"sqrt"])
        self.operand = sqrt(self.operand);
    else if([@"+/-" isEqual:operation])
        self.operand = - self.operand;
    else {
        [self performWaitingOperation];
        self.waitingOperation = operation;
        self.waitingOperand = self.operand;
    }
    return self.operand;
}

-(void)performWaitingOperation
{
    if([@"+" isEqualToString:self.waitingOperation])
        self.operand = self.waitingOperand + self.operand;
    else if([@"-" isEqualToString:self.waitingOperation])
        self.operand = self.waitingOperand - self.operand;
    else if([@"*" isEqualToString:self.waitingOperation])
        self.operand = self.waitingOperand * self.operand;
    else if([@"/" isEqualToString:self.waitingOperation])
        self.operand = self.waitingOperand / self.operand;
    
}


@end
