//
//  CRVINTERGraphicsView.h
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRVINTERGraphicsView : UIView
@property (strong, nonatomic) NSMutableArray *interpolationPoints;

- (void) setIsClosed:(BOOL)closed;
- (void) setAlpha:(float)alpha;
- (void) setUseHermite:(BOOL)useHermite;
@end
