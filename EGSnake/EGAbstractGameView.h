//
//  EGGameView.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGSnake.h"
#import "EGGameBoard.h"

@interface EGAbstractGameView : UIView

@property (nonatomic) EGSnake *snake;
@property (nonatomic) EGGameBoard *board;

- (CGRect)rectForVPoint:(EGGridPoint *)point;

#pragma mark - Subclassing these for custom view

- (void)drawBoardInRect:(CGRect)rect underContext:(CGContextRef)context;
- (void)drawSnakeInRect:(CGRect)rect underContext:(CGContextRef)context;

@end
