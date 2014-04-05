//
//  EGSnake.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGSnake.h"

@interface EGSnake ()

@property (nonatomic) NSArray *body;

@end

@implementation EGSnake

- (id)initWithHead:(EGGridPoint *)head bodyLength:(NSUInteger)bodyLength bodyDirection:(EGSnakeDirection)bodyDirection moveDirection:(EGSnakeDirection)moveDirection
{
    if (self = [super init]) {
        NSMutableArray *body = [NSMutableArray array];
        for (int i = bodyLength - 1; i >= 0; i--) {
            NSInteger x, y;
            switch (bodyDirection) {
                case EGSnakeDirectionUp:
                    x = head.x;
                    y = head.y - i;
                    break;
                    
                case EGSnakeDirectionDown:
                    x = head.x;
                    y = head.y + i;
                    break;
                    
                case EGSnakeDirectionLeft:
                    x = head.x - i;
                    y = head.y;
                    break;
                    
                case EGSnakeDirectionRight:
                    x = head.x + i;
                    y = head.y;
                    break;
                default:
                    break;
            }
            EGGridPoint *point = [[EGGridPoint alloc] initWithX:x andY:y];
            [body addObject:point];
        }
        _body = body;
        _moveDirection = moveDirection;
    }
    return self;
}

- (EGGridPoint *)head
{
    return (EGGridPoint *)[self.body lastObject];
}

- (void)move
{
    // treat body as a queue
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.body];
    
    // when the snake moves, discard the first element in body (the oldest one)
    [tmp removeObject: tmp.firstObject];
    // and append the new head
    NSInteger x = self.head.x;
    NSInteger y = self.head.y;
    switch (self.moveDirection) {
        case EGSnakeDirectionRight:
            x += 1;
            break;
        case EGSnakeDirectionLeft:
            x -= 1;
            break;
        case EGSnakeDirectionDown:
            y += 1;
            break;
        case EGSnakeDirectionUp:
            y -= 1;
            break;
            
        default:
            break;
    }
    EGGridPoint *newHead = [[EGGridPoint alloc] initWithX:x andY:y];
    [tmp addObject:newHead];
    self.body = [NSArray arrayWithArray:tmp];
}

- (void)setMoveDirection:(EGSnakeDirection)direction
{
    if (self.moveDirection + direction == EGSnakeDirectionDown + EGSnakeDirectionUp) {
        return;
    }
    if (self.moveDirection + direction == EGSnakeDirectionLeft + EGSnakeDirectionRight) {
        return;
    }
    
    _moveDirection = direction;
}

@end
