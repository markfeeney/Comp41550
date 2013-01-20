//
//  ColorSelectorViewController.h
//  HelloPolly
//
//  Created by Mark Feeney on 20/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSelectorViewController : UIViewController

@property (weak, nonatomic) UIColor * colorSelected;
@property (weak, nonatomic) IBOutlet UIImageView *polygonColorPreview;
@property (weak, nonatomic) IBOutlet UISlider *redColor;
@property (weak, nonatomic) IBOutlet UISlider *greenColor;
@property (weak, nonatomic) IBOutlet UISlider *blueColor;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)updateView;


@end
