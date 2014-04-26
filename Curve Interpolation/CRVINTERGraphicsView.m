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
    for (NSValue *pv in self.interpolationPoints) {
        CGPoint point;
        [pv getValue:&point];
        
        UIBezierPath *pointPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(point.x-2, point.y-2, 4, 4)];
        [[UIColor redColor] setFill];
        [pointPath fill];
    }
    
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
