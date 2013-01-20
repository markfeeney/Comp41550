//
//  PolygonView.m
//  HelloPolly
//
//  Created by Mark Feeney on 16/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//


#import "PolygonView.h"

@interface PolygonView ()

@property (nonatomic, strong) NSArray *polygonPoints;

+(NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int) numberOfSides;

@end

@implementation PolygonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (NSArray *)pointsForPolygonInRect:(CGRect)rect numberOfSides:(int)numberOfSides
{
    CGPoint center = CGPointMake(rect.size.width / 2.0, rect.size.height / 2.0);
    float radius = 0.9 * center.x;
    NSMutableArray *result = [NSMutableArray array];
    float angle = (2.0 * M_PI) / numberOfSides;
    float exteriorAngle = M_PI - angle;
    float rotationDelta = angle - (0.5 * exteriorAngle);
    
    for (int currentAngle = 0; currentAngle < numberOfSides; currentAngle++) {
        float newAngle = (angle * currentAngle) - rotationDelta;
        float curX = cos(newAngle) * radius;
        float curY = sin(newAngle) * radius;
        [result addObject:[NSValue valueWithCGPoint:
                           CGPointMake(center.x+curX,center.y+curY)]];
    }
    return result;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect{
    // Drawing code
    int numberOfSidesFromDelegate = [self.polygonViewDelegate numberOfSidesForPolygon];
    
    //numberOfSidesFromDelegate = 3;
    NSLog(@"Number of Sides is  %i" ,numberOfSidesFromDelegate);
    
    if (numberOfSidesFromDelegate < 3) return;
    
    NSLog(@"Number of sides is %i" ,numberOfSidesFromDelegate);
    
    NSArray *poloygonPoints = [PolygonView pointsForPolygonInRect:self.bounds numberOfSides:numberOfSidesFromDelegate];
    CGPoint point;
    
    for  (int i = 1; i < poloygonPoints.count; i++)
    {
        point = [[poloygonPoints objectAtIndex:i] CGPointValue];
        NSLog(@"Point %i x = %f" , i, point.x);
        NSLog(@"Point %i y = %f" , i, point.y);
        //CGContextAddLineToPoint(context, point.x, point.y);
    }

    // Check the Polygon array has at least 3 points to draw with
    if ([poloygonPoints count] < 3) return;
    NSLog(@"Number of Points is  %i" , [poloygonPoints count]);

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    [[UIColor blackColor] setStroke]; // same as above
    CGContextSetLineWidth(context, 3.0);
    CGContextBeginPath(context);
    
    //CGPoint point = [[self.polygonPoints objectAtIndex:0] CGPointValue];
    point = [[poloygonPoints objectAtIndex:0] CGPointValue];
    
    NSLog(@"First Point x = %f" ,point.x);
    NSLog(@"First Point y = %f" ,point.y);
    
    CGContextMoveToPoint(context, point.x, point.y);
    for  (int i = 1; i < poloygonPoints.count; i++)
    {
        point = [[poloygonPoints objectAtIndex:i] CGPointValue];
        NSLog(@"Point %i x = %f" , i, point.x);
        NSLog(@"Point %i y = %f" , i, point.y);
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextClosePath(context);
    
    //CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    // todo implement color via property
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    float red = [prefs floatForKey:@"cr"];
    float green = [prefs floatForKey:@"cg"];
    float blue = [prefs floatForKey:@"cb"];
    float alpha = [prefs floatForKey:@"ca"];
    
    CGContextSetFillColorWithColor(context,  [UIColor colorWithRed:red green:green blue:blue alpha:alpha].CGColor);

    CGContextDrawPath(context, kCGPathFillStroke);
    
}


@end
