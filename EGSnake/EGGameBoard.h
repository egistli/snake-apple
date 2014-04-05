//
//  EGGameBoard.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EGApple.h"

@interface EGGameBoard : NSObject

@property (nonatomic, readonly) NSInteger sideLength;
@property (nonatomic, readonly) NSUInteger vWidth;
@property (nonatomic, readonly) NSUInteger vHeight;
@property (nonatomic, readonly) NSArray *apples;

- (id)initWithRealFrame:(CGRect)frame sideLength:(NSInteger)sideLength;

- (void)genApple;
- (void)removeApple:(EGApple *)apple;

@end
