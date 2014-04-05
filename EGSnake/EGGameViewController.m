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
@property (nonatomic) EGAbstractGameView *gameView;

@end

@implementation EGGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gameView = [[EGSimpleGameView alloc] initWithFrame:self.view.bounds];
    self.gameView.center = self.view.center;
    [self.view addSubview: self.gameView];
    
    self.gameController = [[EGGameController alloc] initWithGameView:self.gameView];
    EGGameBoard *board = [[EGGameBoard alloc] initWithRealFrame:self.gameView.frame sideLength:8];
    EGSnake *snake = [[EGSnake alloc] initWithHead:[[EGGridPoint alloc] initWithX:[board vWidth] / 2 andY:[board vHeight] / 2] bodyLength:10 bodyDirection:EGSnakeDirectionLeft moveDirection:EGSnakeDirectionRight];
    [self.gameController startWithSnake:snake board:board andSpeed:7];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
