//
//  GraphView.h
//  AxisDrawing
//
//  Created by CSI COMP41550 on 10/02/2012.
//  Copyright (c) 2012 UCD. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GraphViewDataSource
- (NSArray*)getGraphDataPoints;
@end


@interface GraphView : UIView 

@property (nonatomic) float scale;
@property (nonatomic) CGPoint origin;
@property (nonatomic) id <GraphViewDataSource> graphviewDataSource;

@end
