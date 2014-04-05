//
//  EGGameViewController.m
//  EGSnake
//
//  Created by Egist Li on 2014/4/4.
//  Copyright (c) 2014年 Egist Li. All rights reserved.
//

#import "EGGameViewController.h"
#import "EGSimpleGameView.h"
#import "EGGameController.h"

@interface EGGameViewController ()

@property (nonatomic) EGGameController *gameController;

@end

@implementation EGGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameController = [[EGGameController alloc] initWithGameView:self.gameView];
    self.gameController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startButtonTouched:(id)sender
{
    EGGameBoard *board = [[EGGameBoard alloc] initWithRealFrame:self.gameView.frame sideLength:8];
    EGSnake *snake = [[EGSnake alloc] initWithHead:[[EGGridPoint alloc] initWithX:[board vWidth] / 2 andY:[board vHeight] / 2] bodyLength:10 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    [self.gameController startWithSnake:snake board:board andSpeedLevel:1];
}

#pragma mark - Game Controller Delegate

- (void)gameDidStart:(EGGameController *)controller
{
    self.startButton.alpha = 1.f;
    self.scoreLabel.alpha = 0.f;
    self.scoreLabel.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.startButton.alpha = 0.f;
        self.scoreLabel.alpha = 0.4f;
    } completion:^(BOOL finished) {
        self.startButton.hidden = YES;
    }];
}

- (void)gameDidEnd:(EGGameController *)controller
{
    self.startButton.hidden = NO;
    self.startButton.alpha = 0.f;
    [UIView animateWithDuration:0.3 animations:^{
        self.startButton.alpha = 1.f;
    }];
}

- (void)gameScoreDidChange:(EGGameController *)controller
{
    self.scoreLabel.text = [NSString stringWithFormat:@"%d", controller.score];
}


@end
