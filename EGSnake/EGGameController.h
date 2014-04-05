//
//  EGGameController.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EGSnake.h"
#import "EGGameBoard.h"
#import "EGAbstractGameView.h"

@interface EGGameController : NSObject

@property (nonatomic, readonly) EGSnake *snake;
@property (nonatomic, readonly) EGGameBoard *board;
@property (nonatomic) NSInteger speed;
@property (nonatomic, readonly) NSTimer *gameTimer;
@property (nonatomic, readonly) EGAbstractGameView *gameView;

- (id)initWithGameView:(EGAbstractGameView *)gameView;

- (void)startWithSnake:(EGSnake *)snake board:(EGGameBoard *)board andSpeed:(NSUInteger)speed;

- (BOOL)isSnakeCollideWithSelf;
- (BOOL)isSnakeCollideWithBoardEdge;

@end
