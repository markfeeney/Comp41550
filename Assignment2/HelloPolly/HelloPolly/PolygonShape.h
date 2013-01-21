//
//  PolygonShape.h
//  HelloPoly
//
//  Created by CSI COMP41550 on 03/01/2012.
//  Copyright (c) 2012 UCD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PolygonShape : NSObject

@property (nonatomic) int numberOfSides;
@property (nonatomic) UIColor *color;
@property (readonly,weak) NSString *name;

- (id)initWithNumberOfSides:(int)sides;
- (id)initWithNumberOfSides:(int)sides AndColor:(UIColor * )color;

@end
