//
//  UIBezierPath+Interpolation.h
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Interpolation)

// pointsAsNSValues must be NSValue objects containing CGPoints.
//
// ex:
//     const char *encoding = @encode(CGPoint);
//     NSValue *pointAsValue = [NSValue valueWithBytes:&cgPoint objCType:encoding];

// 0.0 <= alpha <= 1.0
+(UIBezierPath *)interpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha;
+(UIBezierPath *)interpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed;
@end
