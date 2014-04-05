//
//  EGGameController.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGGameController.h"

@interface EGGameController ()

@property (nonatomic) NSTimer *gameTimer;

- (void)handleGesture:(UISwipeGestureRecognizer *)recognizer;

@end

@implementation EGGameController

- (id)initWithGameView:(EGAbstractGameView *)gameView
{
    self = [super init];
    if (self) {
        _gameView = gameView;
        
        // setup gesture recognizer
        UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
        UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
        
        [_gameView addGestureRecognizer:leftSwipe];
        [_gameView addGestureRecognizer:rightSwipe];
        [_gameView addGestureRecognizer:upSwipe];
        [_gameView addGestureRecognizer:downSwipe];
    }
    return self;
}

- (void)startWithSnake:(EGSnake *)snake board:(EGGameBoard *)board andSpeed:(NSUInteger)speed
{
    _snake = snake;
    _board = board;
    self.speed = speed;
    self.gameView.snake = snake;
    self.gameView.board = board;
}

- (void)setSpeed:(NSInteger)speed
{
    _speed = speed;
    if (self.gameTimer) {
        [self.gameTimer invalidate];
    }
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:(1 / (NSTimeInterval)speed) target:self selector:@selector(gameTick) userInfo:nil repeats:YES];
}

- (void)gameTick
{
    [self.snake move];
    if ([self isSnakeCollideWithBoardEdge] || [self isSnakeCollideWithSelf]) {
        NSLog(@"You are dead!");
    }
    
    // if there's no apple, gen 1
    if (self.board.apples.count == 0) {
        [self.board genApple];
    }
    
    [self.gameView setNeedsDisplay];
}

#pragma mark - Collision Detection

- (BOOL)isSnakeCollideWithBoardEdge
{
    BOOL collide = NO;
    if (self.snake.head.x < 0
        || self.snake.head.y < 0
        || self.snake.head.x >= self.board.vWidth
        || self.snake.head.y >= self.board.vHeight) {
        collide = YES;
    }
    return collide;
}

- (BOOL)isSnakeCollideWithSelf
{
    BOOL collide = NO;
    NSMutableArray *bodyWithoutHead = [NSMutableArray arrayWithArray:self.snake.body];
    [bodyWithoutHead removeLastObject];
    if ([bodyWithoutHead containsObject:self.snake.head]) {
        collide = YES;
    }
    return collide;
}

#pragma mark - Handle Gesture

- (void)handleGesture:(UISwipeGestureRecognizer *)recognizer
{
    switch ([recognizer direction]) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.snake.moveDirection = EGSnakeDirectionLeft;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.snake.moveDirection = EGSnakeDirectionRight;
            break;
        case UISwipeGestureRecognizerDirectionUp:
            self.snake.moveDirection = EGSnakeDirectionUp;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            self.snake.moveDirection = EGSnakeDirectionDown;
            break;
        default:
            break;
    }
}
@end
