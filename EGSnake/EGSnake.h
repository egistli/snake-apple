//
//  EGSnake.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EGGridPoint.h"
#import "EGGameBoard.h"

@class EGSnake;

extern NSString * const EGSnakeBodyLengthZeroException;

typedef NS_ENUM(NSInteger, EGSnakeDirection) {
    EGSnakeDirectionLeft = 1 << 0,
    EGSnakeDirectionRight = 1 << 1,
    EGSnakeDirectionUp = 1 << 2,
    EGSnakeDirectionDown = 1 << 3,
};

@interface EGSnake : NSObject

@property (nonatomic, readonly) EGGridPoint *head;
@property (nonatomic, readonly) NSArray *body;
@property (nonatomic, assign) EGSnakeDirection moveDirection;

- (id)initWithHead:(EGGridPoint *)head bodyLength:(NSUInteger)bodyLength bodyDirection:(EGSnakeDirection)bodyDirection moveDirection:(EGSnakeDirection)moveDirection;
- (void)move;
- (void)extend;

@end
