//
//  EGGameBoard.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGGameBoard : NSObject

@property (nonatomic, readonly) NSInteger sideLength;
@property (nonatomic, readonly) NSUInteger vWidth;
@property (nonatomic, readonly) NSUInteger vHeight;

- (id)initWithRealFrame:(CGRect)frame sideLength:(NSInteger)sideLength;

@end
