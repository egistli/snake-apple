//
//  EGGridPoint.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGGridPoint : NSObject

@property (nonatomic, readonly, assign) NSInteger x;
@property (nonatomic, readonly, assign) NSInteger y;

+ (id)pointWithX:(NSInteger)x andY:(NSInteger)y;

- (id)initWithX:(NSInteger)x andY:(NSInteger)y;

@end
