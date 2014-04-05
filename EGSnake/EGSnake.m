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
@property (nonatomic) EGGridPoint *lastTrimmedBody;

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
    self.lastTrimmedBody = tmp.firstObject;
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

- (void)extend
{
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.body];
    if (self.lastTrimmedBody) {
        [tmp insertObject:self.lastTrimmedBody atIndex:0];
    } else {
        EGGridPoint *tail1 = [self.body objectAtIndex:0];
        EGGridPoint *tail2 = [self.body objectAtIndex:1];
        EGGridPoint *extended;
        if (tail1.x == tail2.x) {
            extended = [EGGridPoint pointWithX:tail1.x andY:tail1.y > tail2.y ? tail1.y + 1 : tail1.y - 1];
        }
        if (tail1.y == tail2.y) {
            extended = [EGGridPoint pointWithX:(tail1.x > tail2.x ? tail1.x + 1 : tail1.x - 1) andY:tail1.y];
        }
        [tmp insertObject:extended atIndex:0];
    }
    self.body = [NSArray arrayWithArray:tmp];
}

@end
