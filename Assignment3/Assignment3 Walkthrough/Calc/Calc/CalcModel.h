//
//  CalcModel.h
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalcModelDelegate <NSObject>
-(void)calculationErrorHasOccured:(NSString*)errormessage;
@end

@interface CalcModel : NSObject

@property (nonatomic) double operand;
@property (nonatomic) double waitingOperand;
@property (nonatomic) NSString *waitingOperation;
@property (nonatomic,strong) id <CalcModelDelegate> calcModelDelegate;

-(double)performOperation:(NSString *)operation;

@end
