//
//  EGGameBoard.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGGameBoard.h"

#import "EGApple.h"

@interface EGGameBoard ()

@property (nonatomic) NSArray *apples;

@end

@implementation EGGameBoard

- (id)initWithRealFrame:(CGRect)frame sideLength:(NSInteger)sideLength
{
    if (self = [super init]) {
        _sideLength = sideLength;
        _vHeight = frame.size.height / sideLength;
        _vWidth = frame.size.width / sideLength;
        _apples = @[];
    }
    return self;
}

- (void)genApple
{
    NSInteger x = arc4random() % self.vWidth;
    NSInteger y = arc4random() % self.vHeight;
    EGGridPoint *position = [EGGridPoint pointWithX:x andY:y];
    
    EGApple *newApple = [[EGApple alloc] initWithPosition:position andScore:(arc4random() % 10)];
    self.apples = [self.apples arrayByAddingObject:newApple];
}

@end
