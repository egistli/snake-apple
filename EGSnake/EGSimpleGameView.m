//
//  EGSimpleGameView.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGSimpleGameView.h"
#import "EGApple.h"

@interface EGSimpleGameView ()

@property (nonatomic) NSMutableDictionary *layerForApple;

@end

@implementation EGSimpleGameView

- (void)awakeFromNib
{
    _layerForApple = [NSMutableDictionary dictionary];
}

- (void)drawBoardInRect:(CGRect)rect underContext:(CGContextRef)context
{
    // clear
    CGContextSetFillColor(context, CGColorGetComponents([UIColor blackColor].CGColor));
    CGContextFillRect(context, rect);
}

- (void)drawApplesInRect:(CGRect)rect underContext:(CGContextRef)context
{
    // draw apple
    NSMutableArray *eatenApples =[NSMutableArray arrayWithArray:[self.layerForApple allKeys]];
    [eatenApples removeObjectsInArray:self.board.apples];
    
    // remove layer
    for (EGApple *apple in eatenApples) {
        CALayer *layer = _layerForApple[apple];
        [layer removeFromSuperlayer];
    }
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    for (int i = 0; i < self.board.apples.count; i++) {
        EGApple *apple = [self.board.apples objectAtIndex:i];
        if (![self.layerForApple objectForKey:apple]) {
            CGRect dotRect = [self rectForVPoint:apple.position];
            CALayer *layer = [CALayer layer];
            layer.frame = dotRect;
            if (apple.score >= 8) {
                layer.backgroundColor = [UIColor yellowColor].CGColor;
            } else if (apple.score >= 5) {
                layer.backgroundColor = [UIColor lightGrayColor].CGColor;
            } else {
                layer.backgroundColor = [UIColor redColor].CGColor;
            }
            [self.layerForApple setObject:layer forKey:apple];
            [self.layer addSublayer:layer];
        } else if (apple.disappearTime > 0 && apple.disappearTime - currentTime < 1) {
            CALayer *layer = self.layerForApple[apple];
            layer.opacity = (arc4random() % 10) / 10;
        }
    }
}

- (void)drawSnakeInRect:(CGRect)rect underContext:(CGContextRef)context
{
    // draw snake
    for (int i = 0; i < self.snake.body.count; i++) {
        EGGridPoint *point = [self.snake.body objectAtIndex:i];
        CGRect dotRect = [self rectForVPoint:point];
        UIColor *gradientGreen = [UIColor colorWithRed:0.f green: 0.1 + i * (1.f/self.snake.body.count) blue:0.f alpha:1];
        CGContextSetFillColor(context, CGColorGetComponents(gradientGreen.CGColor));
        CGContextFillRect(context, dotRect);
    }
}

@end
