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
        _head = head;
        NSMutableArray *body = [NSMutableArray array];
        for (int i = 0; i < bodyLength; i++) {
            NSInteger x, y;
            switch (bodyDirection) {
                case EGSnakeDirectionUp:
                    x = head.x;
                    y = head.y + i;
                    break;
                    
                case EGSnakeDirectionDown:
                    x = head.x;
                    y = head.y - i;
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
        _direction = moveDirection;
    }
    return self;
}

@end
