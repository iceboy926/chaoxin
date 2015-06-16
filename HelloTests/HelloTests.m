//
//  HelloTests.m
//  HelloTests
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface HelloTests : XCTestCase

@end

@implementation HelloTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
