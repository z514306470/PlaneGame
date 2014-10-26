//
//  PlaneGameStartScene.m
//  planeGame
//
//  Created by Qingqing on 14-10-25.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameStartScene.h"
#import "PlaneGameMainScene.h"

@implementation PlaneGameStartScene

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        SKSpriteNode *startBg = [SKSpriteNode spriteNodeWithImageNamed:@"begin"];
        startBg.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        startBg.size = CGSizeMake(ScreenWidth, ScreenHeight);
        [self addChild:startBg];
        
        //start button
//        UIButton *startBut = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
//        startBut.center = CGPointMake(ScreenWidth/2, ScreenHeight-70);
//        [startBut addTarget:self action:@selector(gameStart) forControlEvents:UIControlEventTouchUpInside];
        
        SKSpriteNode *startBut = [SKSpriteNode spriteNodeWithImageNamed:@"button"];
        startBut.name = @"start";
        startBut.position = CGPointMake(ScreenWidth/2, 0.2*ScreenHeight);
        [self addChild:startBut];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        
        if ([node.name isEqualToString:@"start"]) {
            SKTexture *temTex = [SKTexture textureWithImageNamed:@"button_press"];
            ((SKSpriteNode *)node).texture = temTex;
            
            
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:touchLocation];
        
        if ([node.name isEqualToString:@"start"]) {
            SKTexture *temTex = [SKTexture textureWithImageNamed:@"button"];
            ((SKSpriteNode *)node).texture = temTex;
            
            PlaneGameMainScene *mainScene = [PlaneGameMainScene sceneWithSize:self.view.bounds.size];
            [self.view presentScene:mainScene];
        }
    }
}

@end
