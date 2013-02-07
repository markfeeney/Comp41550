//
//  CalcModel.h
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalcModel : NSObject
@property (nonatomic) double operand;
@property (nonatomic) double waitingOperand;
@property (nonatomic) NSString *waitingOperation;

-(double)performOperation:(NSString *)operation;


@end
