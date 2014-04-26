//
//  CRVINTERGraphicsView.m
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//

#import "CRVINTERGraphicsView.h"
#import "UIBezierPath+Interpolation.h"

@interface CRVINTERGraphicsView() {
    BOOL _closed;
    float _alpha;
    BOOL _useHermite;
}

@end

@implementation CRVINTERGraphicsView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _closed = NO;
        _alpha  = 0.5;
        _useHermite = NO;
        self.interpolationPoints = [NSMutableArray new];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Dashed line drawing
    UIBezierPath *dashedConnectors;
    for (int ii=0; ii < [self.interpolationPoints count]; ++ii) {
        NSValue *pv = self.interpolationPoints[ii];
        CGPoint point;
        [pv getValue:&point];
        
        if ([self.interpolationPoints count] > 1) {
            if (ii == 0) {
                dashedConnectors = [UIBezierPath new];
                [dashedConnectors moveToPoint:point];
            }
            else {
                [dashedConnectors addLineToPoint:point];
            }
        }
    }
    
    if (_closed)
        [dashedConnectors closePath];
    
    CGFloat dashedConnectorsPattern[] = {3, 3, 3, 3};
    dashedConnectors.lineWidth = 0.5;
    [[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] setStroke];
    [dashedConnectors setLineDash: dashedConnectorsPattern count: 4 phase: 0];
    [dashedConnectors stroke];
    
    // Interpolation points drawing
    for (NSValue *pv in self.interpolationPoints) {
        CGPoint point;
        [pv getValue:&point];
        
        UIBezierPath *pointPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(point.x-2, point.y-2, 4, 4)];
        [[UIColor redColor] setFill];
        [pointPath fill];
    }
    
    // Curve drawing
    UIBezierPath *path;
    if (_useHermite) {
        path = [UIBezierPath interpolateCGPointsWithHermite:self.interpolationPoints closed:_closed];
    }
    else {
        path = [UIBezierPath interpolateCGPointsWithCatmullRom:self.interpolationPoints closed:_closed alpha:_alpha];
    }
    
    if (path) {
        [[UIColor blackColor] setStroke];
        path.lineWidth = 1.0;
        [path stroke];
    }
}

- (void) setIsClosed:(BOOL)closed {
    _closed = closed;
}

- (void) setAlpha:(float)alpha {
    _alpha = alpha;
}

- (void) setUseHermite:(BOOL)useHermite {
    _useHermite = useHermite;
}

@end
