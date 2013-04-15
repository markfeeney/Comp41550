//
//  GraphViewController.h
//  Calc
//
//  Created by Mark Feeney on 01/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//


@protocol ExpressionChangedDelegate <NSObject>
-(void) expressionHasChanged:(id) expression;
@end

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"
#import "GraphView.h"
#import "CalcModel.h"
#import "CalcViewController.h"

@interface GraphViewController : UIViewController <GraphViewDataSource, ExpressionChangedDelegate, UISplitViewControllerDelegate>

@property (weak, nonatomic) IBOutlet GraphView *graphview;
@property (weak, nonatomic) CalcModel *calcModel;
@property (weak, nonatomic) id calcExpression;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;


- (IBAction)ZoomInPressed:(UIBarButtonItem *)sender;
- (IBAction)ZoomOutPressed:(UIBarButtonItem *)sender;


@end
