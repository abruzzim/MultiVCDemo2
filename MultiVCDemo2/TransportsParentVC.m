//
//  TransportsParentVC.m
//  MultiVCDemo2
//
//  Created by abruzzim on 4/10/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "TransportsParentVC.h"
#import "TransportsMasterTVC.h" // 1st Child VC.

#define STATUS_BAR_HEIGHT 20.0
#define TOOLBAR_HEIGHT 44.0
#define CHILD1_WIDTH_FACTOR (1.0/2.0)
#define CHILD1_HEIGHT_FACTOR (1.0/1.0)

@interface TransportsParentVC ()

@property (strong, nonatomic) TransportsMasterTVC *childVC1;

@property BOOL isChild1Visible;

@property (strong, nonatomic) UIToolbar *toolBar;

@end

@implementation TransportsParentVC

- (void)viewDidLoad {
    NSLog(@"%%TransportsParentVC-I-TRACE, -viewDidLoad called.");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    //
    //
    self.childVC1 = [[TransportsMasterTVC alloc] init];
    self.childVC1.view.frame = CGRectMake(0,
                                          STATUS_BAR_HEIGHT,
                                          roundf(self.view.frame.size.width * CHILD1_WIDTH_FACTOR),
                                          roundf((self.view.frame.size.height - (STATUS_BAR_HEIGHT+TOOLBAR_HEIGHT+self.tabBarController.tabBar.frame.size.height)) * CHILD1_HEIGHT_FACTOR));
    self.isChild1Visible = YES;
    [self addChildViewController:self.childVC1];
    [self.view addSubview:self.childVC1.view];
    
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
    
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"Child2"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton2:)];
    
    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc] initWithTitle:@"Child3"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(doButton3:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:self
                                                                            action:nil];
    
    NSArray *barButtonItems = [NSArray arrayWithObjects:spacer, btn1, spacer, btn2, spacer, btn3, spacer, nil];
    
    [self.toolBar setItems:barButtonItems];
}

- (void)doButton1:(UIButton *)sender {
    NSLog(@"%%TransportParentVC-I-TRACE, -doButton1 called.");
    CGRect newFrame;
    if (self.isChild1Visible) {
        // Shift left by width.
        newFrame = CGRectMake(self.childVC1.view.frame.origin.x - self.childVC1.view.frame.size.width,
                              self.childVC1.view.frame.origin.y,
                              self.childVC1.view.frame.size.width,
                              self.childVC1.view.frame.size.height);
    } else {
        // Shift right by width
        newFrame = CGRectMake(self.childVC1.view.frame.origin.x + self.childVC1.view.frame.size.width,
                              self.childVC1.view.frame.origin.y,
                              self.childVC1.view.frame.size.width,
                              self.childVC1.view.frame.size.height);
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.childVC1.view.frame = newFrame;
    }];
    self.isChild1Visible = !self.isChild1Visible;
}

- (void)doButton2:(UIButton *)sender {
    NSLog(@"%%TransportParentVC-I-TRACE, -doButton2 called.");
    if (self.isChild1Visible) {
        // Remove the view.
        [self.childVC1.view removeFromSuperview];
    } else {
        // Add the view.
        [self.view addSubview:self.childVC1.view];
    }

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
