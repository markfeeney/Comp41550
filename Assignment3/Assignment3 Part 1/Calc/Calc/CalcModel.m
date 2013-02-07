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
@synthesize memoryValue = _memoryValue;

-(double)performOperation:(NSString *)operation
{
    if([operation isEqual:@"sqrt"])
        self.operand = sqrt(self.operand);
    else if([@"+/-" isEqual:operation])
        self.operand = - self.operand;
    else if([operation isEqualToString:@"1/x"] && self.operand != 0)
        self.operand = (1 / self.operand);
    else if ([@"+/-" isEqualToString:operation])
        self.operand = - self.operand;
    else if([operation isEqualToString:@"sin"])
        self.operand = sin(self.operand * M_PI/180); //t's expecting radians. To get the answer you want, convert degrees to radians first:
    else if([operation isEqualToString:@"cos"])
        self.operand = cos(self.operand);
    else if ([@"STO" isEqualToString:operation])
        self.memoryValue = self.operand;
    else if ([@"RCL" isEqualToString:operation])
        self.operand = self.memoryValue;
    else if ([@"M+" isEqualToString:operation])
        self.memoryValue  += self.operand;
    else if ([operation isEqual:@"C"]){
        self.operand = 0;
        self.memoryValue = 0;
        self.waitingOperation = Nil;
    }
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
