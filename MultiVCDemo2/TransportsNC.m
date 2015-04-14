//
//  TransportsNC.m
//  MultiVCDemo2
//
//  Created by abruzzim on 4/10/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "TransportsNC.h"

@interface TransportsNC ()

@end

@implementation TransportsNC

- (void)viewDidLoad {
    NSLog(@"%%TransportsNC-I-TRACE, -viewDidLoad called.");
    
    [super viewDidLoad];
    self.title = @"Transports";
    self.tabBarItem.image = [UIImage imageNamed:@"medical52"];
    self.toolbarHidden = NO;
    self.toolbar.translucent = YES;
    self.toolbar.barStyle = UIBarStyleDefault;
    
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%%TransportsNC-I-TRACE, -didReceiveMemoryWarning called.");
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
