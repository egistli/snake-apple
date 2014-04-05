//
//  EGGameControllerTests.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EGGameController.h"

#import "EGAbstractGameView.h"
#import "EGSnake.h"
#import "EGGameBoard.h"
#import "EGApple.h"

@interface EGGameController (Testing)

- (void)gameTick;

@end

@interface EGGameControllerTests : XCTestCase

@property (nonatomic) EGGameController *controller;
@property (nonatomic) EGAbstractGameView *mockGameView;
@property (nonatomic) EGSnake *mockSnake;
@property (nonatomic) EGGameBoard *mockBoard;

@end

@implementation EGGameControllerTests

- (void)setUp
{
    [super setUp];
    
    self.mockGameView = mock([EGAbstractGameView class]);
    self.mockSnake = mock([EGSnake class]);
    self.mockBoard = mock([EGGameBoard class]);
    [given([self.mockBoard vWidth]) willReturnInteger:100];
    [given([self.mockBoard vHeight]) willReturnInteger:100];
    self.controller = [[EGGameController alloc] initWithGameView:self.mockGameView];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitWithGameView
{
    assertThat(self.controller.gameView, equalTo(self.mockGameView));
}

- (void)testStartGameSetup
{
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatInteger(self.controller.score, equalToInteger(0));
    assertThat(self.controller.snake, equalTo(self.mockSnake));
    assertThat(self.controller.board, equalTo(self.mockBoard));
    
    assertThatDouble([self.controller.gameTimer timeInterval], equalToDouble(1/(NSTimeInterval)10));
}

#pragma mark - Collision

- (void)testCollisionDetection_withBoardEdgeLeft
{
    EGGridPoint *head = [EGGridPoint pointWithX:-1 andY:0];
    [given([self.mockSnake head]) willReturn:head];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatBool(YES, equalToBool([self.controller isSnakeCollideWithBoardEdge]));
    
    head = [EGGridPoint pointWithX:0 andY:0];
    [given([self.mockSnake head]) willReturn:head];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatBool(NO, equalToBool([self.controller isSnakeCollideWithBoardEdge]));
}

- (void)testCollisionDetection_withBoardEdgeRight
{
    // no collide to right
    EGGridPoint *head = [EGGridPoint pointWithX:[self.mockBoard vWidth] - 1 andY:0];
    [given([self.mockSnake head]) willReturn:head];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatBool(NO, equalToBool([self.controller isSnakeCollideWithBoardEdge]));
    
    // collide to right
    head = [EGGridPoint pointWithX:[self.mockBoard vWidth] andY:0];
    [given([self.mockSnake head]) willReturn:head];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatBool(YES, equalToBool([self.controller isSnakeCollideWithBoardEdge]));
}

- (void)testSnakeEatTheApple
{
    EGGridPoint *head = [EGGridPoint pointWithX:5 andY:5];
    [given([self.mockSnake head]) willReturn:head];
    EGApple *apple = [[EGApple alloc] initWithPosition:[EGGridPoint pointWithX:5 andY:5] andScore:10];
    [given([self.mockBoard apples]) willReturn:@[apple]];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    assertThatBool([self.controller isSnakeEatingAnApple], equalToBool(YES));
    assertThat(self.controller.appleIsBeingEaten, equalTo(apple));
    
    [self.controller gameTick];
    
    assertThatInteger(self.controller.score, equalToInteger(apple.score));
}

#pragma mark - Apple control

- (void)testGameTick_genAppleWhenTheresNone
{
    [given([self.mockBoard apples]) willReturn:@[]];
    [self.controller startWithSnake:self.mockSnake board:self.mockBoard andSpeed:10];
    [self.controller gameTick];
    [verify(self.mockBoard) genApple];
}

@end
