//
//  EGApple.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGApple.h"

@implementation EGApple

- (id)initWithPosition:(EGGridPoint *)position andScore:(NSInteger)score
{
    if (self = [super init]) {
        _position = position;
        _score = score;
    }
    return self;
}

@end
