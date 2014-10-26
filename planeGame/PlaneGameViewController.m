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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
