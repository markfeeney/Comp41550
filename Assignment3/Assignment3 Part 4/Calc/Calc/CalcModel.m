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
@synthesize operandisvariable = _operandisvariable;

- init
{
    self = [super init];
    if (!self) return nil;
    
    self.scaleUnits = @"Deg";
    //as expression is readonly, assign to backing store instead
    _expression = [[NSMutableArray alloc] init];
    
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
        [self.expression removeAllObjects];
        self.operandisvariable = FALSE;
    }else if ([@"∏" isEqualToString:operation])
        self.operand  = M_PI;
    else{
        // Only add the resultant operand if we are not using a variable otherwise set the operand to 0
        if (!([self.waitingOperation isEqualToString:@"="]) && !(self.operandisvariable))
            [_expression addObject:[NSNumber numberWithDouble:self.operand]];
        else if (self.operandisvariable)
            self.operand = 0;
        
        // Get ready for next variable or operand
        self.operandisvariable = FALSE;
        [_expression addObject:operation];
        [self performWaitingOperation];
        self.waitingOperation = operation;
        self.waitingOperand = self.operand;

    }
    return self.operand;
}

-(void)setVariableAsOperand:(NSString *)variableName{
    [self.expression addObject:variableName];
    self.operandisvariable = TRUE;
}

+(double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables{
    
    CalcModel *mycalculator = [[CalcModel alloc]init];
    
    NSMutableString *myexpression = [[NSMutableString alloc] init];
    
    double result = 0;
    
    for (id object in anExpression) {
        NSLog(@"Object is %@", object);
        if([variables objectForKey:object]){
            [myexpression appendString:[variables objectForKey:object]];
            [mycalculator setOperand:[[variables objectForKey:object]doubleValue]];
        }else if([object isKindOfClass:[NSNumber class]]){
            [myexpression appendString:[NSString stringWithFormat:@"%@", object]];
            [mycalculator setOperand:[object doubleValue]];
        }else if([object isKindOfClass:[NSString class]]){
            [myexpression appendString:[object stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            result = [mycalculator performOperation:object];
        }
    }
    NSLog(@"myexpression is %@", myexpression);
    return result;
}

+(NSSet *)variablesInExpression:(id)anExpression{
    
    NSMutableSet *variables =[[NSMutableSet alloc] init];
       
    for (NSObject* myvariable in anExpression){
        NSLog(@"%@", (NSString *)myvariable);
        if ([(NSString *)myvariable isEqual: @"x"])
            [variables addObject:myvariable];
    }
    
    if([variables count] ==0)
        variables = nil;
    
    return variables;
}

-(NSString *)descriptionOfExpresion:(id)anExpression{
    
    NSMutableString  *expressiondescription = [[NSMutableString alloc]init];
    
    for (id object in anExpression)
    {
        if([object isKindOfClass:[NSString class]])
        {
            [expressiondescription appendString:object];
        }
        else if([object isKindOfClass:[NSNumber class]])
        {
            [expressiondescription appendString:[NSString stringWithFormat:@"%@" ,object]];
        }
        [expressiondescription appendString:@" "];
    }
    
    return expressiondescription;
}

+(id)propertyListforExpression:(id)anExpression{
    
    NSMutableArray *propertylist = [anExpression copy];
    
    return propertylist;
}

-(id)expressionForPropertyList:(id)propertyList{
    
    NSMutableArray *expression = [propertyList copy];
    
    return expression;
}


@end
