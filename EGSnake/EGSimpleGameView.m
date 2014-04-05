//
//  EGSimpleGameView.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGSimpleGameView.h"

#import "EGApple.h"

@implementation EGSimpleGameView

- (void)drawBoardInRect:(CGRect)rect underContext:(CGContextRef)context
{
    // clear
    CGContextSetFillColor(context, CGColorGetComponents([UIColor blackColor].CGColor));
    CGContextFillRect(context, rect);
    
    // draw apple
    CGContextSetFillColor(context, CGColorGetComponents([UIColor redColor].CGColor));
    for (int i = 0; i < self.board.apples.count; i++) {
        EGApple *apple = [self.board.apples objectAtIndex:i];
        CGRect dotRect = [self rectForVPoint:apple.position];
        CGContextFillEllipseInRect(context, dotRect);
    }
}

- (void)drawSnakeInRect:(CGRect)rect underContext:(CGContextRef)context
{
    // draw snake
    for (int i = 0; i < self.snake.body.count; i++) {
        EGGridPoint *point = [self.snake.body objectAtIndex:i];
        CGRect dotRect = [self rectForVPoint:point];
        UIColor *gradientGreen = [UIColor colorWithRed:0.f green:i * (1.f/self.snake.body.count) blue:0.f alpha:1];
        CGContextSetFillColor(context, CGColorGetComponents(gradientGreen.CGColor));
        CGContextFillRect(context, dotRect);
    }
}

@end
