//
//  EGGameBoard.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGGameBoard.h"

@implementation EGGameBoard

- (id)initWithRealFrame:(CGRect)frame sideLength:(NSInteger)sideLength
{
    if (self = [super init]) {
        _sideLength = sideLength;
        _vHeight = frame.size.height / sideLength;
        _vWidth = frame.size.width / sideLength;
    }
    return self;
}


@end
