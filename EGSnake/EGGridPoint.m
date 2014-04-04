//
//  EGGridPoint.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGGridPoint.h"

@implementation EGGridPoint

- (id)initWithX:(NSInteger)x andY:(NSInteger)y;
{
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[EGGridPoint class]]) {
        return NO;
    }
    
    EGGridPoint *another = (EGGridPoint *)object;
    
    if (another == self) {
        return YES;
    } else if (another.x == self.x && another.y == self.y) {
        return YES;
    }
    
    return NO;
}

@end
