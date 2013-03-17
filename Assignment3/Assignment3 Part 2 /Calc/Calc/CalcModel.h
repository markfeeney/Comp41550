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

@property (nonatomic,strong) id <CalcModelDelegate> calcModelDelegate;
@property (nonatomic) double operand;
@property (nonatomic) double waitingOperand;
@property (nonatomic) NSString *waitingOperation;
@property (nonatomic) double memoryValue;
@property (nonatomic) NSString *scaleUnits;
@property (readonly, strong) id expression;
@property(nonatomic) Boolean operandisvariable;

-(double)performOperation:(NSString *)operation;
-(void)setVariableAsOperand:(NSString *)variableName;
+(double)evaluateExpression:(id)anExpression usingVariableValues:(NSDictionary *)variables;
+(NSSet *)variablesInExpression:(id)anExpression;
-(NSString *)descriptionOfExpresion:(id)anExpression;
+(id)propertyListforExpression:(id)anExpression;
-(id)expressionForPropertyList:(id)propertyList;

@end
