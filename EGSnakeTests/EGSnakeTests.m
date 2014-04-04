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
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Init

- (void)testSankeInit_headAndMoveDirection
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    assertThat(snake.head, equalTo(self.head));
    assertThat(snake.body[0], equalTo(self.head));
    assertThatInteger(snake.direction, equalToInteger(EGSnakeDirectionRight));
}

- (void)testSankeInit_left
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x - 1 andY:self.head.y]));
    assertThat(snake.body[2], equalTo([[EGGridPoint alloc] initWithX:self.head.x - 2 andY:self.head.y]));
}

- (void)testSankeInit_right
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionRight moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x + 1 andY:self.head.y]));
    assertThat(snake.body[2], equalTo([[EGGridPoint alloc] initWithX:self.head.x + 2 andY:self.head.y]));
}

- (void)testSankeInit_up
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionUp moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y + 1]));
    assertThat(snake.body[2], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y + 2]));
}

- (void)testSankeInit_down
{
    EGSnake *snake = [[EGSnake alloc] initWithHead:self.head bodyLength:3 bodyDirection:EGSnakeDirectionDown moveDirection:EGSnakeDirectionRight];
    assertThat(snake.body[1], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y - 1]));
    assertThat(snake.body[2], equalTo([[EGGridPoint alloc] initWithX:self.head.x andY:self.head.y - 2]));
}

#pragma mark - Move


@end
