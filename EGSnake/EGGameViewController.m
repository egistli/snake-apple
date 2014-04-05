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

#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>

@interface EGGameViewController ()

@property (nonatomic) EGGameController *gameController;
@property (nonatomic) AVAudioPlayer *player;

@end

@implementation EGGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"swallow" ofType:@"m4a"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.player.numberOfLoops = 0;
    
    self.gameController = [[EGGameController alloc] initWithGameView:self.gameView];
    self.gameController.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)startButtonTouched:(id)sender
{
    EGGameBoard *board = [[EGGameBoard alloc] initWithRealFrame:self.gameView.frame sideLength:16];
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
    [self.player play];
    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)controller.score];
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            self.scoreLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1);
        }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.scoreLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.8, 0.8, 1);
        }];
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
            self.scoreLabel.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
        }];
    } completion:^(BOOL finished) {
    }];
}


@end
