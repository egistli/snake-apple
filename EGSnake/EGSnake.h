//
//  EGSnake.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EGGridPoint.h"

extern NSString * const EGSnakeBodyLengthZeroException;

typedef NS_ENUM(NSInteger, EGSnakeDirection) {
    EGSnakeDirectionLeft = 1,
    EGSnakeDirectionRight = 2,
    EGSnakeDirectionUp = 3,
    EGSnakeDirectionDown = 4,
};

@interface EGSnake : NSObject

@property (nonatomic, readonly) EGGridPoint *head;
@property (nonatomic, readonly) NSArray *body;
@property (nonatomic, assign) EGSnakeDirection direction;

- (id)initWithHead:(EGGridPoint *)head bodyLength:(NSUInteger)bodyLength bodyDirection:(EGSnakeDirection)bodyDirection moveDirection:(EGSnakeDirection)moveDirection;

@end
