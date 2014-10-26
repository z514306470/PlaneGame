//
//  PlaneGameMainScene.m
//  planeGame
//
//  Created by Qingqing on 14-10-25.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameMainScene.h"
#import "PlaneGameFighter.h"
#import "PlaneGameBackground.h"
#import "PlaneGameStatus.h"
#import "PlaneGameEnemy.h"
#import "PlaneGameBomb.h"

@implementation PlaneGameMainScene{
    PlaneGameFighter *fighter;
}

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        //init background
        PlaneGameBackground *background = [[PlaneGameBackground alloc] init];
        [self addChild:background];
        //init status
        PlaneGameStatus *status = [[PlaneGameStatus alloc] init];
        [self addChild:status];

        //init fighter
        fighter = [[PlaneGameFighter alloc] init];
        [self addChild:fighter];
        
        //init enemy
        PlaneGameEnemy *enemy = [[PlaneGameEnemy alloc] init];
        [self addChild:enemy];
        
    }
    return self;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch* touch in touches) {
        CGPoint point = [touch locationInNode:self];
        SKAction *moveTo = [SKAction moveTo:point duration:0.1];
        
        [fighter runAction:moveTo];
    }
}

-(void)update:(NSTimeInterval)currentTime{
    SKSpriteNode *enemy = (SKSpriteNode *)[self childNodeWithName:@"enemy"];
    
    if (enemy.position.y == 0) {
        [enemy removeFromParent];
        PlaneGameEnemy *enemy = [[PlaneGameEnemy alloc] init];
        [self addChild:enemy];
    }
    
    int x = enemy.position.x-10;
    if (enemy.position.y>0&&x%24 == 0) {
        PlaneGameBomb *bomb = [[PlaneGameBomb alloc] init];
        CGPoint enemyPoint = enemy.position;
        bomb.position = CGPointMake(enemyPoint.x-22, enemyPoint.y-10);
        SKAction *moveTo = [SKAction moveToY:0 duration:bomb.position.y/ScreenHeight*7];
        [bomb runAction:moveTo];
        [self addChild:bomb];
       
    }
    
    SKSpriteNode *bomb = (SKSpriteNode *)[self childNodeWithName:@"bomb"];
    if (bomb.position.y == 0) {
        [bomb removeFromParent];
    }
    
    //碰撞检测
    for (SKSpriteNode* bullet in fighter.bulletsAry) {
        if (CGRectIntersectsRect(bullet.frame, enemy.frame)) {
            bullet.hidden = YES;
            [enemy removeFromParent];
            
            //init boom
            SKTexture *boomTexture = [SKTexture textureWithImageNamed:@"boom"];
            NSMutableArray* boomFrameMutAry = [NSMutableArray arrayWithCapacity:7];
            for (int i = 0; i<7; i++) {
                SKTexture *temTexture = [SKTexture textureWithRect:CGRectMake(1.0/7*i, 0, 1.0/7, 1) inTexture:boomTexture];
                [boomFrameMutAry addObject:temTexture];
            }
            
            SKAction *frameAciton = [SKAction animateWithTextures:boomFrameMutAry timePerFrame:0.1];
            SKSpriteNode *boom = [[SKSpriteNode alloc] init];
            boom.position = enemy.position;
            
            
            boom.size = CGSizeMake(44, 49);
            [self addChild:boom];
            [boom runAction:frameAciton completion:^{
                [boom removeFromParent];
            }];
        }
    }
}

@end
