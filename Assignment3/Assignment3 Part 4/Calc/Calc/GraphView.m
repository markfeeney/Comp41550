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
@synthesize origin = _origin;
@synthesize graphviewDataSource = _graphviewDataSource;

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
    if (_scale != scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}

- (void)setOrigin:(CGPoint)origin
{
    if (_origin.x != origin.x || _origin.y != origin.y ) {
        _origin = origin;
        [self setNeedsDisplay];
    }
}

- (CGPoint)origin
{
    if (!_origin.x && !_origin.y) {
        _origin.x = (self.bounds.origin.x + self.bounds.size.width) / 2;
        _origin.y = (self.bounds.origin.y + self.bounds.size.height) / 2;
    }
    return _origin;
}

- (void)drawRect:(CGRect)rect
{
    [AxesDrawer drawAxesInRect:rect originAtPoint:CGPointMake(self.origin.x,self.origin.y) scale:self.scale];
    
    NSArray *pointsToGraph = [self.graphviewDataSource getGraphDataPoints];
    
    //[self drawGraph:pointsToGraph originAtPoint:CGPointMake(CGRectGetMidX(rect),CGRectGetMidY(rect)) scale: self.scale];
    [self drawGraph:pointsToGraph originAtPoint:CGPointMake(self.origin.x,self.origin.y) scale: self.scale];
}

- (void) drawGraph:(NSArray *)graphDataPoints originAtPoint:(CGPoint)axisOrigin scale: (float) scale{
    
    float centerPointX = axisOrigin.x;
    float centerPointY = axisOrigin.y;
   
	CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGPoint dataPoint = (CGPoint)[graphDataPoints[0] CGPointValue];
    
    CGContextMoveToPoint(context, dataPoint.x * scale + centerPointX, -(dataPoint.y * scale - centerPointY));
    
    for (id point in graphDataPoints) {
        dataPoint = [point CGPointValue];
        CGContextAddLineToPoint(context, dataPoint.x * scale + centerPointX,-(dataPoint.y * scale - centerPointY));
    }
    CGContextStrokePath(context);
}






@end
