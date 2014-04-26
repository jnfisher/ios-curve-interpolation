//
//  CRVINTERViewController.m
//  Curve Interpolation
//
//  Created by John Fisher on 4/26/14.
//  Copyright (c) 2014 John Fisher. All rights reserved.
//

#import "CRVINTERViewController.h"
#import "CRVINTERGraphicsView.h"

@interface CRVINTERViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *hermiteCatmull;
@property (strong, nonatomic) IBOutlet UISlider *alphaSlider;
@property (strong, nonatomic) IBOutlet UISwitch *closedSwitch;
@property (strong, nonatomic) IBOutlet CRVINTERGraphicsView *graphicsView;
@property (strong, nonatomic) IBOutlet UILabel *alphaLabel;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@property UITapGestureRecognizer *gestureRecognizer;
@property (strong, nonatomic) IBOutlet UILabel *noPointsHelperLabel;

- (IBAction)clearDataPoints:(UIButton *)sender;
- (IBAction)alphaChanged:(UISlider *)sender;
- (IBAction)hermiteCatmullChanged:(UISegmentedControl *)sender;
- (IBAction)closeChanged:(UISwitch *)sender;

@end

@implementation CRVINTERViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateGraphicsView {
    self.alphaLabel.text = [NSString stringWithFormat:@"%.2f", self.alphaSlider.value];
    [self.graphicsView setIsClosed:self.closedSwitch.on];
    [self.graphicsView setAlpha:self.alphaSlider.value];
    [self.graphicsView setUseHermite:(self.hermiteCatmull.selectedSegmentIndex == 0)];
    [self.graphicsView setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearButton.layer.cornerRadius = 4;
    self.clearButton.clipsToBounds = YES;
    self.closedSwitch.onTintColor = [UIColor colorWithRed:0 green:122.0/255.0f blue:1.0 alpha:1.0];
    self.closedSwitch.tintColor = [UIColor colorWithRed:180.0/255.0f green:180.0/255.0f blue:180.0/255.0f alpha:1.0];
    
    self.gestureRecognizer = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(tapped:)];
    self.gestureRecognizer.delegate = self;
    self.gestureRecognizer.numberOfTapsRequired = 1;
    self.gestureRecognizer.numberOfTouchesRequired = 1;
    [self.graphicsView addGestureRecognizer:self.gestureRecognizer];
    
    [self clearDataPoints:nil];
    [self updateGraphicsView];
}

- (IBAction)clearDataPoints:(UIButton *)sender {
    if (self.noPointsHelperLabel.alpha == 0.0) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ self.noPointsHelperLabel.alpha = 1.0;}
                         completion:nil];
    }
    
    self.graphicsView.interpolationPoints = [NSMutableArray new];
    [self updateGraphicsView];
}

- (IBAction)alphaChanged:(UISlider *)sender {
    [self updateGraphicsView];
}

- (IBAction)hermiteCatmullChanged:(UISegmentedControl *)sender {
    [self updateGraphicsView];
}

- (IBAction)closeChanged:(UISwitch *)sender {
    [self updateGraphicsView];
}

-(void)tapped:(UITapGestureRecognizer *)gesture {
    if (self.noPointsHelperLabel.alpha == 1.0) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn
                         animations:^{ self.noPointsHelperLabel.alpha = 0.0;}
                         completion:nil];
    }
    
    CGPoint touchedPt = [gesture locationOfTouch:0 inView:self.graphicsView];
    const char *encoding = @encode(CGPoint);
    [self.graphicsView.interpolationPoints addObject:[NSValue valueWithBytes:&touchedPt objCType:encoding]];
    [self updateGraphicsView];
}
@end
