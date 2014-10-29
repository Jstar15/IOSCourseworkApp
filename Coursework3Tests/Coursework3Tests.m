//
//  Coursework3Tests.m
//  Coursework3Tests
//
//  Created by Jordan Waddell [sc12jw] on 29/10/2014.
//  Copyright (c) 2014 Jordan Waddell [sc12jw]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface Coursework3Tests : XCTestCase

@end

@implementation Coursework3Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
