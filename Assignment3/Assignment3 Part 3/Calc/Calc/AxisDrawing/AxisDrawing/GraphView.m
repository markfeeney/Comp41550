//
//  GraphView.m
//  AxisDrawing
//
//  Created by CSI COMP41550 on 10/02/2012.
//  Copyright (c) 2012 UCD. All rights reserved.
//

#import "GraphView.h"
#import "AxesDrawer.h"

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:rect originAtPoint:CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect)) scale:1];
}

@end
