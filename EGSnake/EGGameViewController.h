//
//  EGGameViewController.h
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGSnake.h"
#import "EGGameBoard.h"
#import "EGAbstractGameView.h"
#import "EGGameController.h"

@interface EGGameViewController : UIViewController<EGGameControllerDelegate>

@property (nonatomic) IBOutlet EGAbstractGameView *gameView;
@property (nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) IBOutlet UILabel *scoreLabel;

@end
