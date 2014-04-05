//
//  EGGameView.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGAbstractGameView.h"

@interface EGAbstractGameView ()

@end

@implementation EGAbstractGameView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    [self drawBoardInRect:rect underContext:context];
    [self drawSnakeInRect:rect underContext:context];
}

- (void)drawBoardInRect:(CGRect)rect underContext:(CGContextRef)context
{
    mustOverride();
}

- (void)drawSnakeInRect:(CGRect)rect underContext:(CGContextRef)context
{
    mustOverride();
}

- (CGRect)rectForVPoint:(EGGridPoint *)point
{
    CGFloat x = point.x * self.board.sideLength;
    CGFloat y = point.y * self.board.sideLength;
    return CGRectMake(x, y, self.board.sideLength, self.board.sideLength);
}


@end
