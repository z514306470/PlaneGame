//
//  PlaneGameViewController.m
//  planeGame
//
//  Created by Qingqing on 14-10-25.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

#import "PlaneGameViewController.h"
#import "PlaneGameStartScene.h"

@interface PlaneGameViewController ()

@end

@implementation PlaneGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    //startScene
    SKScene *startScene = [PlaneGameStartScene sceneWithSize:skView.bounds.size];
    startScene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:startScene];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//隐藏status
- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

@end
