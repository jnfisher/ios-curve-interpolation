## Synopsis
iOS Curve Interpolation consists of two main components:
- A category on UIBezierCurvePath, UIBezierCurvePath+Interpolation.
- A small iOS app that demonstrates the categories use.

## Example
```C
#include "UIBezierCurvePath+Interpolation.h"

const char *encoding = @encode(CGPoint);

NSMutableArray *array = [NSMutableArray new];

// Add 4 CGPoints as NSValue
[array addObject:[NSValue valueWithBytes:&CGPointMake(0.0, 0.0) objCType:encoding];
[array addObject:[NSValue valueWithBytes:&CGPointMake(0.0, 1.0) objCType:encoding];
[array addObject:[NSValue valueWithBytes:&CGPointMake(1.0, 1.0) objCType:encoding];
[array addObject:[NSValue valueWithBytes:&CGPointMake(1.0, 0.0) objCType:encoding];

UIBezierPath *path = interpolateCGPointsWithCatmullRom:array closed:NO alpha:0.5;
// Use the path
```

## Motivation
To add an easy-to-use category for curve interpolation onto UIBezierPath.  Also to provide a small iOS app for demonstrating/testing the interpolation inputs (Hermite vs. Catmull-Rom, alpha value effects, and open/closed option).

## Installation
Clone the repo, open the Xcode project in Xcode 5+.

The UIBezierPath+Interpolation.h/.m is standalone, provided you also include CGPointExtension.h/.m (which are also included in the Xcode project).

## API Reference
```C
// pointsAsNSValues must be NSValue objects containing CGPoints.
//
// ex:
//     const char *encoding = @encode(CGPoint);
//     NSValue *pointAsValue = [NSValue valueWithBytes:&cgPoint objCType:encoding];

// 0.0 <= alpha <= 1.0
+(UIBezierPath *)interpolateCGPointsWithCatmullRom:(NSArray *)pointsAsNSValues closed:(BOOL)closed alpha:(float)alpha;
+(UIBezierPath *)interpolateCGPointsWithHermite:(NSArray *)pointsAsNSValues closed:(BOOL)closed;
```
