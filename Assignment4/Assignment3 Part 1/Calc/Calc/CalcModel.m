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
@synthesize calcModelDelegate;
@synthesize operand = _operand;
@synthesize waitingOperand = _waitingOperand;
@synthesize waitingOperation = _waitingOperation;
@synthesize scaleUnits = _scaleUnits;
@synthesize memoryValue;

- init
{
    self = [super init];
    if (!self) return nil;
    
    self.scaleUnits = @"Deg";
    
    return self;
}

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
            [self.calcModelDelegate calculationErrorHasOccured:@"Cannot get the Square Root of a Negative Number"];
    }else if([@"±" isEqual:operation])
        self.operand = - self.operand;
    else if([operation isEqualToString:@"1/x"])
        if(self.operand)
            self.operand = (1 / self.operand);
        else
            [self.calcModelDelegate calculationErrorHasOccured:@"Cannot get the Inverse of 0"];
    else if([operation isEqualToString:@"sin"])
        //sin is expecting radians by default. To get the answer you want, convert degrees to radians first:
        self.operand = sin(([self.scaleUnits isEqualToString:@"Deg"]) ? self.operand * M_PI / 180:self.operand);
    else if([operation isEqualToString:@"cos"])
        //cos is expecting radians by default. To get the answer you want, convert degrees to radians first:
        self.operand = cos(([self.scaleUnits isEqualToString:@"Deg"]) ? self.operand * M_PI / 180:self.operand);
    else if ([@"STO" isEqualToString:operation])
        self.memoryValue = self.operand;
    else if ([@"RCL" isEqualToString:operation])
        self.operand = self.memoryValue;
    else if ([@"M+" isEqualToString:operation])
        self.memoryValue  += self.operand;
    else if ([@"MC" isEqualToString:operation])
        self.memoryValue  = 0;
    else if ([operation isEqual:@"C"]){
        self.operand = 0;
        self.waitingOperand = 0;
        self.memoryValue = 0;
        self.waitingOperation = Nil;
        [self.calcModelDelegate calculationErrorHasOccured:@""];
    }else if ([@"∏" isEqualToString:operation])
        self.operand  = M_PI;
    else { // must be a 2 operand operation
        [self performWaitingOperation];
        self.waitingOperation = operation;
        self.waitingOperand = self.operand;
    }
    return self.operand;
}

@end
