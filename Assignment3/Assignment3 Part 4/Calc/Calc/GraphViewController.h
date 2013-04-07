//
//  GraphViewController.h
//  Calc
//
//  Created by Mark Feeney on 01/04/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AxesDrawer.h"
#import "GraphView.h"
#import "CalcModel.h"


@interface GraphViewController : UIViewController <GraphViewDataSource>

@property (weak, nonatomic) IBOutlet GraphView *graphview;
@property (weak, nonatomic) CalcModel *calcModel;
@property (weak, nonatomic) id calcExpression;

- (IBAction)ZoomInPressed:(UIBarButtonItem *)sender;
- (IBAction)ZoomOutPressed:(UIBarButtonItem *)sender;

@end
