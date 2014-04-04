//
//  EGGridPointTests.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGGridPoint.h"

@interface EGGridPointTests : XCTestCase

@end

@implementation EGGridPointTests

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

- (void)testGridPointInit
{
    NSInteger x = 7;
    NSInteger y = 5;
    EGGridPoint *point = [[EGGridPoint alloc] initWithX:x andY:y];
    assertThatInt(point.x, equalToInt(x));
    assertThatInt(point.y, equalToInt(y));
}

- (void)testCompare_equal
{
    EGGridPoint *point1 = [[EGGridPoint alloc] initWithX:1 andY:2];
    EGGridPoint *point2 = [[EGGridPoint alloc] initWithX:1 andY:2];
    assertThatBool([point1 isEqual:point2], equalToBool(YES));
}

- (void)testCompare_notEqual
{
    EGGridPoint *point1 = [[EGGridPoint alloc] initWithX:1 andY:2];
    EGGridPoint *point2 = [[EGGridPoint alloc] initWithX:3 andY:1];
    assertThatBool([point1 isEqual:point2], equalToBool(NO));
}

@end
