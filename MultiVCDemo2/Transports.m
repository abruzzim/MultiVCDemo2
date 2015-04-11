//
//  Transports.m
//  MultiVCDemo2
//
//  Created by abruzzim on 4/10/15.
//  Copyright (c) 2015 FWS. All rights reserved.
//

#import "Transports.h"

@implementation Transports

+ (NSArray *)knownFakeTransports {
    
    NSLog(@"%%TransportsMasterTVC-I-TRACE, +knownFakeTransports called.");

    NSDictionary *fakeTransport1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"123ABC", @"tag",
                                    @"MedEvac 1", @"title",
                                    nil];
    
    NSDictionary *fakeTransport2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"456DEF", @"tag",
                                    @"MedEvac 2", @"title",
                                    nil];
    
    NSDictionary *fakeTransport3 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"798GHI", @"tag",
                                    @"MedEvac 3", @"title",
                                    nil];
    
    NSDictionary *fakeTransport4 = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"321XYZ", @"tag",
                                    @"MedEvac 4", @"title",
                                    nil];
    
    NSArray *fakeTransports = [[NSArray alloc] initWithObjects:
                               fakeTransport1,
                               fakeTransport2,
                               fakeTransport3,
                               fakeTransport4,
                               nil];
    
    return fakeTransports;
}

@end
