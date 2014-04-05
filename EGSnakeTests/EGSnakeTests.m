//
//  EGSnakeTests.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EGSnake.h"

@interface EGSnakeTests : XCTestCase

@property (nonatomic) EGSnake *snake;
@property (nonatomic) EGGridPoint *head;

@end

@implementation EGSnakeTests

- (void)setUp
{
    [super setUp];
    
    EGGridPoint *head = [[EGGridPoint alloc] initWithX:5 andY:5];
    self.head = head;
    self.snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
}

- (void)tearDown
{
    self.head = nil;
    self.snake = nil;
    [super tearDown];
}

#pragma mark - Init

- (void)testSankeInit_headAndMoveDirection
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    assertThat(snake.head, equalTo(self.head));
    assertThat(snake.body[2], equalTo(self.head));
    assertThatInteger(snake.moveDirection, equalToInteger(EGSnakeDirectionRight));
}

- (void)testSankeInit_left
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[0], equalTo([[EGGridPoint alloc] initWithX:self.head.x - 2 andY:self.head.y]));
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x - 1 andY:self.head.y]));
}

- (void)testSankeInit_right
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionRight moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[0], equalTo([[EGGridPoint alloc] initWithX:self.head.x + 2 andY:self.head.y]));
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x + 1 andY:self.head.y]));
}

- (void)testSankeInit_up
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionUp moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[0], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y - 2]));
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y - 1]));
}

- (void)testSankeInit_down
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionDown moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[0], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y + 2]));
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y + 1]));
}

#pragma mark - Move

- (void)testSnake_moveRight
{
    self.snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    
    // body before move: 5,5  4,5  3,5
    [self.snake move];
    
    // body after move: 6,5  5,5  4,5
    assertThat(self.snake.body[2], equalTo([[EGGridPoint alloc] initWithX:6 andY:5]));
    assertThat(self.snake.body[1], equalTo([[EGGridPoint alloc] initWithX:5 andY:5]));
    assertThat(self.snake.body[0], equalTo([[EGGridPoint alloc] initWithX:4 andY:5]));
}

- (void)testSnake_moveLeft
{
    self.snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionRight moveDirection:EGSnakeDirectionLeft];
    
    // body before move: 5,5  6,5  7,5
    [self.snake move];
    
    // body after move: 4,5  5,5  6,5
    assertThat(self.snake.body[2], equalTo([[EGGridPoint alloc] initWithX:4 andY:5]));
    assertThat(self.snake.body[1], equalTo([[EGGridPoint alloc] initWithX:5 andY:5]));
    assertThat(self.snake.body[0], equalTo([[EGGridPoint alloc] initWithX:6 andY:5]));
}

- (void)testSnake_moveDown
{
    self.snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionDown moveDirection:EGSnakeDirectionUp];
    
    // body before move: 5,7  5,6  5,5
    [self.snake move];
    
    // body after move: 5,6  5,5  5,4
    assertThat(self.snake.body[0], equalTo([[EGGridPoint alloc] initWithX:5 andY:6]));
    assertThat(self.snake.body[1], equalTo([[EGGridPoint alloc] initWithX:5 andY:5]));
    assertThat(self.snake.body[2], equalTo([[EGGridPoint alloc] initWithX:5 andY:4]));
}

- (void)testSnake_moveUp
{
    self.snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionUp moveDirection:EGSnakeDirectionDown];
    
    // body before move: 5,3  5,4  5,5
    [self.snake move];
    
    // body after move: 5,4  5,5  5,6
    assertThat(self.snake.body[0], equalTo([[EGGridPoint alloc] initWithX:5 andY:4]));
    assertThat(self.snake.body[1], equalTo([[EGGridPoint alloc] initWithX:5 andY:5]));
    assertThat(self.snake.body[2], equalTo([[EGGridPoint alloc] initWithX:5 andY:6]));
}

@end
