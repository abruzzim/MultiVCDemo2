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

#define CHILD1_WIDTH_FACTOR (1.0/3.0)
#define CHILD1_HEIGHT_FACTOR (1.0/1.0)
#define CHILD2_WIDTH_FACTOR (2.0/3.0)
#define CHILD2_HEIGHT_FACTOR (1.0/1.0)

@interface TransportsParentVC ()

@property CGFloat statusBarFrameSizeHeight;
@property CGFloat navBarFrameSizeHeight;
@property CGFloat toolBarFrameSizeHeight;
@property CGFloat tabBarFrameSizeHeight;
@property CGFloat totalUnusableWidth;
@property CGFloat totalUnusableHeight;
@property CGFloat topOffset;

@property (strong, nonatomic) TransportsMasterTVC *childVC1;
@property BOOL isChild1Visible;
@property (strong, nonatomic) TransportDetailTVC  *childVC2;
@property BOOL isChild2Visible;

- (void)showViewProperties:(UIView *)aView;

@end

@implementation TransportsParentVC

- (void)viewDidLoad {
    NSLog(@"%%TransportsParentVC-I-TRACE, -viewDidLoad called.");
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addToolbarItems];
    [self getFrameSizeHeights];
    [self getTopOffset];
    [self getUnusableDimensions];
    
    // Child 1 Demo VC. --------------------------------------------------------------------------------|
    //
    self.childVC1 = [[TransportsMasterTVC alloc] init];
    self.childVC1.view.frame =
        CGRectMake(
                   0,
                   (_topOffset),
                   roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD1_WIDTH_FACTOR),
                   roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD1_HEIGHT_FACTOR)
                   );
    self.childVC1.view.backgroundColor = [UIColor orangeColor];
    self.childVC1.tableView.layer.borderWidth = 1.0;
    self.childVC1.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.isChild1Visible = YES;
    [self addChildViewController:self.childVC1];
    [self.view addSubview:self.childVC1.view];
    
    // Child 2 Demo VC. --------------------------------------------------------------------------------|
    //
    self.childVC2 = [[TransportDetailTVC alloc] init];
    self.childVC2.view.frame =
        CGRectMake(
                   roundf((self.view.frame.size.width) * CHILD1_WIDTH_FACTOR),
                   (_topOffset),
                   roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD2_WIDTH_FACTOR),
                   roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD2_HEIGHT_FACTOR)
                   );
    self.childVC2.view.backgroundColor = [UIColor purpleColor];
    self.childVC2.tableView.layer.borderWidth = 1.0;
    self.childVC2.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.isChild2Visible = YES;
    [self addChildViewController:self.childVC2];
    [self.view addSubview:self.childVC2.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    NSLog(@"%%TransportsParentVC-I-TRACE, -viewWillLayoutSubviews called.");
    
    if (self.isChild1Visible) {
        self.childVC1.view.frame =
            CGRectMake(
                       0,
                       (_topOffset),
                       roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD1_WIDTH_FACTOR),
                       roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD1_HEIGHT_FACTOR)
                       );
    }
    
    if (self.isChild2Visible) {
        self.childVC2.view.frame =
            CGRectMake(
                       roundf((self.view.frame.size.width) * CHILD1_WIDTH_FACTOR),
                       (_topOffset),
                       roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD2_WIDTH_FACTOR),
                       roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD2_HEIGHT_FACTOR)
                       );
    }
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
                                                            action:@selector(doButton4:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:self
                                                                            action:nil];
    
    NSArray *buttons = [NSArray arrayWithObjects:spacer, btn1, spacer, btn2, spacer, btn3, spacer, btn4, spacer, nil];
    
    self.toolbarItems = buttons;
}

- (void)doButton1:(UIButton *)sender {
    NSLog(@"%%TransportsParentVC-I-TRACE, -doButton1 called.");

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
        newFrame =
            CGRectMake(
                       0,
                       (_topOffset),
                       roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD1_WIDTH_FACTOR),
                       roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD1_HEIGHT_FACTOR)
                       );
        
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
    NSLog(@"%%TransportsParentVC-I-TRACE, -doButton2 called.");
    [self showViewProperties:self.childVC1.view];
}

- (void)doButton3:(UIButton *)sender {
    NSLog(@"%%TransportsParentVC-I-TRACE, -doButton3 called.");
    
    if (self.isChild2Visible) {
        
        CGPoint newCenter;
        
        // Shift the subview right by its longest dimension.
        //
        if (self.view.frame.size.height > self.view.frame.size.width) {
            // If the superview is in portrait orientation...
            
            if (self.childVC2.view.frame.size.height > self.childVC2.view.frame.size.width) {
                // ...and if the subview is higher than it is wide,
                // then shift the subview right by its height.
                newCenter = CGPointMake(self.childVC2.view.center.x + self.childVC2.view.frame.size.height, self.childVC2.view.center.y);
            } else {
                // ...and if the subview is wider than it is high,
                // then shift the subview right by its width.
                newCenter = CGPointMake(self.childVC2.view.center.x + self.childVC2.view.frame.size.width, self.childVC2.view.center.y);
            }
            
        } else {
            // Else if the superview is in landscape orientation...
            
            if (self.childVC2.view.frame.size.width > self.childVC2.view.frame.size.height) {
                // ...and if the subview is wider than it is high,
                // then shift the subview right by its width.
                newCenter = CGPointMake(self.childVC2.view.center.x + self.childVC2.view.frame.size.width, self.childVC2.view.center.y);
            } else {
                // ...and if the subview is higher than it is wide,
                // then shift the subview right by its height.
                newCenter = CGPointMake(self.childVC2.view.center.x + self.childVC2.view.frame.size.height, self.childVC2.view.center.y);
            }
            
        }
        
        [UIView animateWithDuration:0.3f animations:^{
            self.childVC2.view.center = newCenter;
        }];
        
    } else {
        
        CGRect newFrame;
        
        // Resize and shift the subview left to its originally assigned position.
        //
        newFrame =
            CGRectMake(
                       roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD1_WIDTH_FACTOR),
                       (_topOffset),
                       roundf((self.view.frame.size.width - (_totalUnusableWidth)) * CHILD2_WIDTH_FACTOR),
                       roundf((self.view.frame.size.height - (_totalUnusableHeight)) * CHILD2_HEIGHT_FACTOR)
                       );
        
        [UIView animateWithDuration:0.3f animations:^{
            self.childVC2.view.frame = newFrame;
        }];
        
    }
    
    self.isChild2Visible = !self.isChild2Visible;
}

- (void)doButton4:(UIButton *)sender {
    NSLog(@"%%TransportsParentVC-I-TRACE, -doButton4 called.");
    [self showViewProperties:self.childVC2.view];
}
    
- (void)getFrameSizeHeights {
    NSLog(@"%%TransportsParentVC-I-TRACE, -currentFrameSizeHeights called.");
        
    self.statusBarFrameSizeHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.navBarFrameSizeHeight = self.navigationController.navigationBar.frame.size.height;
    self.toolBarFrameSizeHeight = self.navigationController.toolbar.frame.size.height;
    self.tabBarFrameSizeHeight = self.tabBarController.tabBar.frame.size.height;
}

- (void)getTopOffset {
    NSLog(@"%%TransportsParentVC-I-TRACE, -getTopOffset called.");
    
    // Offset height from the top of the view.
    //
    self.topOffset = (
                      self.statusBarFrameSizeHeight +
                      self.navBarFrameSizeHeight
                      );
}

- (void)getUnusableDimensions {
    NSLog(@"%%TransportsParentVC-I-TRACE, -getUnusableDimensions called.");
    
    // Total unusable view dimensions.
    //
    self.totalUnusableWidth = (0);
    self.totalUnusableHeight = (
                                self.statusBarFrameSizeHeight +
                                self.navBarFrameSizeHeight +
                                self.toolBarFrameSizeHeight +
                                self.tabBarFrameSizeHeight
                                );
}

- (void)showViewProperties:(UIView *)aView {
    NSLog(@"%%TransportsParentVC-I-TRACE, -showViewProperties: called.");
    
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

@end
