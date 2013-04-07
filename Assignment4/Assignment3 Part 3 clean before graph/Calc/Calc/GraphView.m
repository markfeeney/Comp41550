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
@synthesize scale = _scale;


-(void)initializationCodeMethod{
    self.scale = 1;
}

// designated initialiser
-(id)initWithCoder:(NSCoder *)aDecoder{
    if ((self = [super initWithCoder:aDecoder])){
        [self initializationCodeMethod];
    }
    return self;
}

// designated initialiser
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializationCodeMethod];
    }
    return self;
}

-(void)setScale:(float)scale{
    if (scale == 0 )
        scale = 1;
    _scale = scale;
    
}


- (void)drawRect:(CGRect)rect
{
    //[AxesDrawer drawAxesInRect:rect originAtPoint:CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect)) scale:1];

    [AxesDrawer drawAxesInRect:rect originAtPoint:CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect)) scale:self.scale];
    
    
    
}


@end
