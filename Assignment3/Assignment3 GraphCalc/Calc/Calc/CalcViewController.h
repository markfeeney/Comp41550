//
//  CalcViewController.h
//  Calc
//
//  Created by Mark Feeney on 07/02/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalcModel.h"

@interface CalcViewController : UIViewController

@property (nonatomic, weak)IBOutlet CalcModel *calcModel;
@property (nonatomic, weak)IBOutlet UILabel *calcDisplay;
@property (nonatomic) BOOL isInTheMiddleOftypingSomething;

-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;


@end
