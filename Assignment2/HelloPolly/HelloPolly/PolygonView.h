//
//  PolygonView.h
//  HelloPolly
//
//  Created by Mark Feeney on 16/01/2013.
//  Copyright (c) 2013 Mark Feeney. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol polygonViewDataSource

-(int) numberOfSidesForPolygon;
-(UIColor *) color;

@end


@interface PolygonView : UIView

@property id <polygonViewDataSource> polygonViewDelegate;

@end
