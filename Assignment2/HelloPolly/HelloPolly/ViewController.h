//
//  ViewController.h
//  HelloPolly
//
//  Created by Mark Feeney on 16/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PolygonShape.h"
#import "PolygonView.h"


@interface ViewController : UIViewController <polygonViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *numberOfSidesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameOfPolygon;
@property (strong, nonatomic) IBOutlet PolygonShape *model;
@property (weak, nonatomic) IBOutlet PolygonView *PoloygonView;
@property (weak, nonatomic) IBOutlet UIStepper *stepperValue;
@property (weak, nonatomic) IBOutlet UIButton *increaseButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;

- (IBAction)sidesStepper:(id)sender;
- (IBAction)decreaseButton:(id)sender;
- (IBAction)increaseButton:(id)sender;
- (IBAction)swipeGestureRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)swipeGestureLeft:(UISwipeGestureRecognizer *)sender;

-(UIColor *)GetColorFromNSUserDefaults;
    

@end
