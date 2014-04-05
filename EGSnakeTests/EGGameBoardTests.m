//
//  EGGameBoardTests.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EGGameBoard.h"
#import "EGApple.h"

@interface EGGameBoardTests : XCTestCase

@end

@implementation EGGameBoardTests

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

- (void)testBoardInit_correctVirtualSize
{
    EGGameBoard *board = [[EGGameBoard alloc] initWithRealFrame:CGRectMake(0.f, 0.f, 160.f, 120.f) sideLength:4];
    assertThatUnsignedInteger(board.vWidth, equalToUnsignedInteger((NSUInteger)(160.f / 4.f)));
    assertThatUnsignedInteger(board.vHeight, equalToUnsignedInteger((NSUInteger)(120.f / 4.f)));
}

- (void)testBoardApples
{
    EGGameBoard *board = [[EGGameBoard alloc] initWithRealFrame:CGRectMake(0.f, 0.f, 160.f, 120.f) sideLength:4];
    [board genApple];
    assertThatInteger(board.apples.count, equalToInteger(1));
    assertThat(board.apples[0], instanceOf([EGApple class]));
}

@end
