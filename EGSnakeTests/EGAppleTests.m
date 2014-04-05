//
//  EGAppleTests.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EGApple.h"
#import "EGGridPoint.h"

@interface EGAppleTests : XCTestCase

@end

@implementation EGAppleTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAppleInit
{
    EGGridPoint *position = [EGGridPoint pointWithX:5 andY:5];
    NSInteger score = 5;
    EGApple *apple = [[EGApple alloc] initWithPosition:position andScore:score];
    assertThat(apple.position, equalTo(position));
    assertThatInteger(apple.score, equalToInteger(score));
}

- (void)testApple_disappearTime
{
    EGGridPoint *position = [EGGridPoint pointWithX:5 andY:5];
    NSInteger score = 5;
    EGApple *apple = [[EGApple alloc] initWithPosition:position andScore:score];
    NSTimeInterval expectedDisappearTime = [[NSDate dateWithTimeIntervalSinceNow:3.f] timeIntervalSince1970];
    apple.disappearTime = expectedDisappearTime;
    
    assertThatDouble(apple.disappearTime, equalToDouble(expectedDisappearTime));
}

@end
