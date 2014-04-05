//
//  EGGameController.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGSnake.h"
#import "EGApple.h"
#import "EGGameBoard.h"
#import "EGAbstractGameView.h"

@class EGGameController;

@protocol EGGameControllerDelegate <NSObject>

@required
- (void)gameDidStart:(EGGameController *)controller;
- (void)gameDidEnd:(EGGameController *)controller;
- (void)gameScoreDidChange:(EGGameController *)controller;

@end

@interface EGGameController : NSObject

@property (nonatomic, readonly) EGSnake *snake;
@property (nonatomic, readonly) EGGameBoard *board;
@property (nonatomic) NSInteger speedLevel;
@property (nonatomic, readonly) NSTimer *gameTimer;
@property (nonatomic, readonly) EGAbstractGameView *gameView;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) id<EGGameControllerDelegate> delegate;

- (id)initWithGameView:(EGAbstractGameView *)gameView;

- (void)startWithSnake:(EGSnake *)snake board:(EGGameBoard *)board andSpeedLevel:(NSUInteger)speedLevel;
- (void)pause;
- (void)resume;

- (EGApple *)appleBeingEaten;
- (BOOL)isSnakeEatingAnApple;
- (BOOL)isSnakeCollideWithSelf;
- (BOOL)isSnakeCollideWithBoardEdge;

@end
