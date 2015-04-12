//
//  TransportsParentVC.m
//  MultiVCDemo2
//
//  Created by abruzzim on 4/10/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "TransportsParentVC.h"
#import "TransportsMasterTVC.h" // 1st Child VC.
#import "TransportDetailTVC.h"  // 2nd Child VC.

#define STATUS_BAR_HEIGHT 20.0
#define TOOLBAR_HEIGHT 44.0
#define CHILD1_WIDTH_FACTOR (1.0/3.0)
#define CHILD1_HEIGHT_FACTOR (1.0/1.0)
#define CHILD2_WIDTH_FACTOR (1 - CHILD1_WIDTH_FACTOR)
#define CHILD2_HEIGHT_FACTOR (1.0/1.0)

@interface TransportsParentVC ()

@property (strong, nonatomic) TransportsMasterTVC *childVC1;
@property (strong, nonatomic) TransportDetailTVC  *childVC2;

@property BOOL isChild1Visible;
@property BOOL isChild2Visible;

@property (strong, nonatomic) UIToolbar *toolBar;

- (void)showViewProperties:(UIView *)theView;

@end

@implementation TransportsParentVC

- (void)viewDidLoad {
    NSLog(@"%%TransportsParentVC-I-TRACE, -viewDidLoad called.");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Child 1 Demo VC.
    //
    self.childVC1 = [[TransportsMasterTVC alloc] init];
    self.childVC1.view.backgroundColor = [UIColor orangeColor];
    self.childVC1.view.frame = CGRectMake(0,
                                          STATUS_BAR_HEIGHT,
                                          roundf(self.view.frame.size.width * CHILD1_WIDTH_FACTOR),
                                          roundf((self.view.frame.size.height - (STATUS_BAR_HEIGHT+TOOLBAR_HEIGHT+self.tabBarController.tabBar.frame.size.height)) * CHILD1_HEIGHT_FACTOR));
    self.childVC1.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                           UIViewAutoresizingFlexibleHeight |
                                           UIViewAutoresizingFlexibleTopMargin |
                                           UIViewAutoresizingFlexibleBottomMargin |
                                           UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin);
    self.isChild1Visible = YES;
    [self addChildViewController:self.childVC1];
    [self.view addSubview:self.childVC1.view];
    
    // Child 2 Demo VC.
    //
    self.childVC2 = [[TransportDetailTVC alloc] init];
    self.childVC2.view.backgroundColor = [UIColor yellowColor];
    self.childVC2.view.frame = CGRectMake(self.childVC1.view.frame.size.width,
                                          STATUS_BAR_HEIGHT,
                                          roundf(self.view.frame.size.width * CHILD2_WIDTH_FACTOR),
                                          roundf((self.view.frame.size.height - (STATUS_BAR_HEIGHT+TOOLBAR_HEIGHT+self.tabBarController.tabBar.frame.size.height)) * CHILD2_HEIGHT_FACTOR));
    self.childVC2.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                           UIViewAutoresizingFlexibleHeight |
                                           UIViewAutoresizingFlexibleTopMargin |
                                           UIViewAutoresizingFlexibleBottomMargin |
                                           UIViewAutoresizingFlexibleLeftMargin |
                                           UIViewAutoresizingFlexibleRightMargin);
    self.isChild2Visible = YES;
    [self addChildViewController:self.childVC2];
    [self.view addSubview:self.childVC2.view];
    
    // Instantiate and configure the tool bar
    //
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.backgroundColor = [UIColor lightGrayColor];
    self.toolBar.barStyle = UIBarStyleDefault;
    [self addToolbarItems];
    [self.view addSubview:self.toolBar];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolBar
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolBar
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    [self.view addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolBar
                                  attribute:NSLayoutAttributeBottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:-(self.tabBarController.tabBar.frame.size.height)]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addToolbarItems {
    
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithTitle:@"Child1"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton1:)];
    
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"Inspect Child1"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton2:)];
    
    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithTitle:@"Child 2"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton3:)];
    
    UIBarButtonItem *btn4 = [[UIBarButtonItem alloc] initWithTitle:@"Inspect Child2"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton2:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:self
                                                                            action:nil];
    
    NSArray *barButtonItems = [NSArray arrayWithObjects:spacer, btn1, spacer, btn2, spacer, btn3, spacer, btn4, spacer, nil];
    
    [self.toolBar setItems:barButtonItems];
}

- (void)doButton1:(UIButton *)sender {
    NSLog(@"%%TransportParentVC-I-TRACE, -doButton1 called.");

#define case 1

#if case==1
    
    if (self.isChild1Visible) {
        
        CGPoint newCenter;
        
        // Shift the subview left by its longest dimension.
        //
        if (self.view.frame.size.height > self.view.frame.size.width) {
            // If the superview is in portrait orientation...
            
            if (self.childVC1.view.frame.size.height > self.childVC1.view.frame.size.width) {
                // ...and if the subview is higher than it is wide,
                // then shift the subview left by its height.
                newCenter = CGPointMake(self.childVC1.view.center.x - self.childVC1.view.frame.size.height, self.childVC1.view.center.y);
            } else {
                // ...and if the subview is wider than it is high,
                // then shift the subview left by its width.
                newCenter = CGPointMake(self.childVC1.view.center.x - self.childVC1.view.frame.size.width, self.childVC1.view.center.y);
            }
            
        } else {
            // Else if the superview is in landscape orientation...
            
            if (self.childVC1.view.frame.size.width > self.childVC1.view.frame.size.height) {
                // ...and if the subview is wider than it is high,
                // then shift the subview left by its width.
                newCenter = CGPointMake(self.childVC1.view.center.x - self.childVC1.view.frame.size.width, self.childVC1.view.center.y);
            } else {
                // ...and if the subview is higher than it is wide,
                // then shift the subview left by its height.
                newCenter = CGPointMake(self.childVC1.view.center.x - self.childVC1.view.frame.size.height, self.childVC1.view.center.y);
            }
            
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self.childVC1.view.center = newCenter;
        }];
        
    } else {
        
        CGRect newFrame;
        
        // Resize and shift the subview right to its assigned position.
        //
        newFrame = CGRectMake(0,
                              STATUS_BAR_HEIGHT,
                              roundf(self.view.frame.size.width * CHILD1_WIDTH_FACTOR),
                              roundf((self.view.frame.size.height - (STATUS_BAR_HEIGHT+TOOLBAR_HEIGHT+self.tabBarController.tabBar.frame.size.height)) * CHILD1_HEIGHT_FACTOR));
        
        [UIView animateWithDuration:0.3f animations:^{
            self.childVC1.view.frame = newFrame;
        }];
        
    }
    
#elif case==2
    
    BOOL newHiddenValue;
    
    if (self.isChild1Visible) {
        // Remove the view.
        newHiddenValue = YES;
    } else {
        // Add the view.
        newHiddenValue = NO;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.childVC1.view.hidden = newHiddenValue;
    }];
    
#elif case==3
    
    CGFloat newAlphaValue;
    
    if (self.isChild1Visible) {
        // Remove the view.
        newAlphaValue = 0.0;
    } else {
        // Add the view.
        newAlphaValue = 1.0;
    }
    
    [UIView animateWithDuration:0.3f animations:^{
        self.childVC1.view.alpha = newAlphaValue;
    }];

#endif
    
    self.isChild1Visible = !self.isChild1Visible;
}

- (void)doButton2:(UIButton *)sender {
    NSLog(@"%%TransportParentVC-I-TRACE, -doButton2 called.");
    [self showViewProperties:self.childVC1.view];
}

- (void)showViewProperties:(UIView *)aView {
    NSLog(@"%%TransportParentVC-I-TRACE, -showViewProperties: called.");
    
    // Super view properties.
    NSLog(@"super-view description: %@", aView.superview.description);
    NSLog(@"super-view alpha: %f", aView.superview.alpha);
    NSLog(@"super-view hidden: %@", aView.superview.hidden ? @"YES" : @"NO");
    NSLog(@"super-view opaque: %@", aView.superview.opaque ? @"YES" : @"NO");
    NSLog(@"super-view autoresizesSubview: %@", aView.superview.autoresizesSubviews ? @"YES" : @"NO");
    NSLog(@"super-view autoresizingMask: %lu", aView.superview.autoresizingMask);
    NSLog(@"super-view contentMode: %lu", aView.superview.contentMode);
    NSLog(@"super-view bounds origin x: %f", aView.superview.bounds.origin.x);
    NSLog(@"super-view bounds origin y: %f", aView.superview.bounds.origin.y);
    NSLog(@"super-view frame origin x: %f", aView.superview.frame.origin.x);
    NSLog(@"super-view frame origin y: %f", aView.superview.frame.origin.y);
    NSLog(@"super-view frame size width: %f", aView.superview.frame.size.width);
    NSLog(@"super-view frame size height: %f", aView.superview.frame.size.height);
    NSLog(@"super-view center x: %f", aView.superview.center.x);
    NSLog(@"super-view center y: %f", aView.superview.center.y);
    NSLog(@"super-view transform a: %f", aView.superview.transform.a);
    NSLog(@"super-view transform b: %f", aView.superview.transform.b);
    NSLog(@"super-view transform c: %f", aView.superview.transform.c);
    NSLog(@"super-view transform d: %f", aView.superview.transform.d);
    NSLog(@"super-view transform tx: %f", aView.superview.transform.tx);
    NSLog(@"super-view transform ty: %f", aView.superview.transform.ty);
    
    // Sub-view properties.
    NSLog(@"sub-view description: %@", aView.description);
    NSLog(@"sub-view alpha: %f", aView.alpha);
    NSLog(@"sub-view hidden: %@", aView.hidden ? @"YES" : @"NO");
    NSLog(@"sub-view opaque: %@", aView.opaque ? @"YES" : @"NO");
    NSLog(@"sub-view autoresizesSubview: %@", aView.autoresizesSubviews ? @"YES" : @"NO");
    NSLog(@"sub-view autoresizingMask: %lu", aView.autoresizingMask);
    NSLog(@"sub-view contentMode: %lu", aView.contentMode);
    NSLog(@"sub-view bounds origin x: %f", aView.bounds.origin.x);
    NSLog(@"sub-view bounds origin y: %f", aView.bounds.origin.y);
    NSLog(@"sub-view frame origin x: %f", aView.frame.origin.x);
    NSLog(@"sub-view frame origin y: %f", aView.frame.origin.y);
    NSLog(@"sub-view frame size width: %f", aView.frame.size.width);
    NSLog(@"sub-view frame size height: %f", aView.frame.size.height);
    NSLog(@"sub-view center x: %f", aView.center.x);
    NSLog(@"sub-view center y: %f", aView.center.y);
    NSLog(@"sub-view transform a: %f", aView.transform.a);
    NSLog(@"sub-view transform b: %f", aView.transform.b);
    NSLog(@"sub-view transform c: %f", aView.transform.c);
    NSLog(@"sub-view transform d: %f", aView.transform.d);
    NSLog(@"sub-view transform tx: %f", aView.transform.tx);
    NSLog(@"sub-view transform ty: %f", aView.transform.ty);

}

- (void)doButton3:(UIButton *)sender {
    NSLog(@"%%TransportParentVC-I-TRACE, -doButton3 called.");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
