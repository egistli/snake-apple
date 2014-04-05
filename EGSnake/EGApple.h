//
//  EGApple.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/5.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EGGridPoint.h"

@interface EGApple : NSObject

@property (nonatomic, readonly) EGGridPoint *position;
@property (nonatomic, assign, readonly) NSInteger score;

- (id)initWithPosition:(EGGridPoint *)position andScore:(NSInteger)score;

@end
