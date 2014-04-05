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

- (void)startWithSnake:(EGSnake *)snake board:(EGGameBoard *)board andSpeedLevel:(NSUInteger)speedLevel
{
    _score = 0;
    _snake = snake;
    _board = board;
    self.speedLevel = speedLevel;
    self.gameView.snake = snake;
    self.gameView.board = board;
    
    if (self.delegate) {
        [self.delegate gameDidStart:self];
    }
}

- (void)pause
{
    [self.gameTimer invalidate];
    self.gameTimer = nil;
}

- (void)resume
{
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeIntervalForSpeedLevel:self.speedLevel] target:self selector:@selector(gameTick) userInfo:nil repeats:YES];
}

- (void)setSpeedLevel:(NSInteger)speedLevel
{
    _speedLevel = speedLevel;
    if (self.gameTimer) {
        [self.gameTimer invalidate];
    }
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:[self timeIntervalForSpeedLevel:speedLevel] target:self selector:@selector(gameTick) userInfo:nil repeats:YES];
}

- (NSTimeInterval)timeIntervalForSpeedLevel:(NSUInteger)speedLevel
{
    NSArray *speed = @[@5, @8, @10, @13, @15, @17, @19, @20];
    return 1 / [speed[speedLevel] doubleValue];
}

- (void)adjustSpeed
{
    if (self.score > 20) {
        self.speedLevel = 2;
    }
    if (self.score > 50) {
        self.speedLevel = 3;
    }
    if (self.score > 80) {
        self.speedLevel = 4;
    }
    if (self.score > 120) {
        self.speedLevel = 5;
    }
    if (self.score > 200) {
        self.speedLevel = 6;
    }
    if (self.score > 400) {
        self.speedLevel = 7;
    }
    if (self.score > 800) {
        self.speedLevel = 8;
    }
}

- (void)gameTick
{
    [self.snake move];
    if ([self isSnakeCollideWithBoardEdge] || [self isSnakeCollideWithSelf]) {
        [self pause];
        if (self.delegate) {
            [self.delegate gameDidEnd:self];
            return;
        }
    }
    
    if ([self isSnakeEatingAnApple]) {
        EGApple *apple = [self appleBeingEaten];
        [self willChangeValueForKey:@"score"];
        _score += apple.score;
        if (self.delegate) {
            [self.delegate gameScoreDidChange:self];
        }
        [self.board removeApple:apple];
        [self.snake extend];
    }
    
    // if there's no apple, gen 1
    if (self.board.apples.count == 0) {
        [self.board genApple];
    }
    
    [self adjustSpeed];
    
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

- (BOOL)isSnakeEatingAnApple
{
    for (EGApple *apple in self.board.apples) {
        if ([apple.position isEqual:self.snake.head]) {
            return YES;
        }
    }
    return NO;
}

- (EGApple *)appleBeingEaten
{
    for (EGApple *apple in self.board.apples) {
        if ([apple.position isEqual:self.snake.head]) {
            return apple;
        }
    }
    return nil;
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
