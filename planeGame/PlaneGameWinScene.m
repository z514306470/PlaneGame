//
//  PlaneGameWinScene.m
//  planeGame
//
//  Created by Qingqing on 14-10-28.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameWinScene.h"
#import "PlaneGameStartScene.h"

@implementation PlaneGameWinScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *startBg = [SKSpriteNode spriteNodeWithImageNamed:@"gamewinnn"];
        startBg.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        startBg.size = CGSizeMake(ScreenWidth, ScreenHeight);
        [self addChild:startBg];
        
        SKSpriteNode *exitBut = [SKSpriteNode spriteNodeWithImageNamed:@"exit"];
        exitBut.name = @"exit";
        CGSize size = exitBut.size;
        exitBut.size = CGSizeMake(size.width/2, size.height/2);
        exitBut.position = CGPointMake(ScreenWidth/2, 0.2*ScreenHeight);
        [self addChild:exitBut];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        
        if ([node.name isEqualToString:@"exit"]) {
            
            PlaneGameStartScene *startScene = [PlaneGameStartScene sceneWithSize:self.view.bounds.size];
            [self.view presentScene:startScene];
        }
    }
}

@end
