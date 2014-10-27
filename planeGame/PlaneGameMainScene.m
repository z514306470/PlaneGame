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
#import "PlaneGameBoss.h"

@implementation PlaneGameMainScene{
    PlaneGameFighter *fighter;
    PlaneGameStatus *status;
    BOOL isBossAppear;
}

-(instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        isBossAppear = NO;
        
        //init background
        PlaneGameBackground *background = [[PlaneGameBackground alloc] init];
        [self addChild:background];
        //init status
        status = [[PlaneGameStatus alloc] init];
        [self addChild:status];

        //init fighter
        fighter = [[PlaneGameFighter alloc] init];
        [self addChild:fighter];
        
        //init enemy
        SKAction *addEnemyAction = [SKAction runBlock:^{
            if (!isBossAppear) {
                PlaneGameEnemy *enemy = [[PlaneGameEnemy alloc] initWithDirection:leftDirection];
                [self addChild:enemy];
                
                PlaneGameEnemy *enemy_1 = [[PlaneGameEnemy alloc] initWithDirection:rightDirection];
                [self addChild:enemy_1];
            }
        }];
        SKAction *wait = [SKAction waitForDuration:4];
        SKAction *addEnemyRepeat = [SKAction repeatActionForever:[SKAction sequence:@[addEnemyAction,wait]]];
        [self runAction:addEnemyRepeat];
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
    if (status.score<100) {
        //add addBomb and detect collision between enemy and bullet
        [self addBombAndDetectCollision];
        
        //bomb and fighter collision detect
        [self detectBombAndFithter];
    }else{
        //clear other sprite
        [self enumerateChildNodesWithName:@"bomb" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        [self enumerateChildNodesWithName:@"enemy" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        //init boss
        
        if (!isBossAppear) {
            PlaneGameBoss *boss = [[PlaneGameBoss alloc] init];
            [self addChild:boss];
        }
        [self detectBulletAndBoss];
        isBossAppear = YES;
    }

}


-(void)addBombAndDetectCollision{
    [self enumerateChildNodesWithName:@"enemy" usingBlock:^(SKNode *node, BOOL *stop) {
        
        PlaneGameEnemy *enemy = (PlaneGameEnemy*)node;
        if (enemy.position.y == 0) {
            [enemy removeFromParent];
        }
        
        //init bomb
        int x = enemy.position.x;
        switch (enemy.direction) {
            case leftDirection:
                if (enemy.position.y>0&&x%24 == 0) {
                    PlaneGameBomb *bomb = [[PlaneGameBomb alloc] init];
                    CGPoint enemyPoint = enemy.position;
                    bomb.position = CGPointMake(enemyPoint.x, enemyPoint.y-10);
                    SKAction *moveTo = [SKAction moveToY:0 duration:bomb.position.y/ScreenHeight*7];
                    [bomb runAction:moveTo];
                    [self addChild:bomb];
                }
                break;
                
            case rightDirection:
                if (enemy.position.y>0&&((int)ScreenWidth-x)%24 == 0) {
                    PlaneGameBomb *bomb = [[PlaneGameBomb alloc] init];
                    CGPoint enemyPoint = enemy.position;
                    bomb.position = CGPointMake(enemyPoint.x, enemyPoint.y-10);
                    SKAction *moveTo = [SKAction moveToY:0 duration:bomb.position.y/ScreenHeight*7];
                    [bomb runAction:moveTo];
                    [self addChild:bomb];
                    
                }
                break;
                
            default:
                break;
        }
        [self enumerateChildNodesWithName:@"bomb" usingBlock:^(SKNode *node, BOOL *stop) {
            if (node.position.y == 0) {
                [node removeFromParent];
            }
        }];
        
        [self detectbulletAndEnemy:enemy];
    }];
}

-(void)detectbulletAndEnemy:(PlaneGameEnemy*)enemy{
    //bullet and enemy collision detect
    [self enumerateChildNodesWithName:@"bullet" usingBlock:^(SKNode *node, BOOL *stop) {
        if (CGRectIntersectsRect(node.frame, enemy.frame)) {
            node.hidden = YES;
            [enemy removeFromParent];
            
            status.score = status.score+30;
            [status updateScore];
            
            [self addBoomEffect:node.position];
        }
    }];
}

-(void)detectBombAndFithter{
    [self enumerateChildNodesWithName:@"bomb" usingBlock:^(SKNode *node, BOOL *stop) {
        if (CGRectIntersectsRect(fighter.frame, node.frame)) {
            [node removeFromParent];
            
            if (status.healths>0) {
                status.healths = status.healths-1;
            }
            [status updateStatus];
            
            [self addBoomEffect:node.position];
        }
    }];
}

-(void)detectBulletAndBoss{
    PlaneGameBoss *boss = (PlaneGameBoss *)[self childNodeWithName:@"boss"];
    [self enumerateChildNodesWithName:@"bullet" usingBlock:^(SKNode *node, BOOL *stop) {
        if (CGRectIntersectsRect(boss.frame, node.frame)) {
            [self addBoomEffect:node.position];
            node.hidden = YES;
        }
    }];
}

-(void)addBoomEffect:(CGPoint)position{
    //init boom
    SKTexture *boomTexture = [SKTexture textureWithImageNamed:@"boom"];
    NSMutableArray* boomFrameMutAry = [NSMutableArray arrayWithCapacity:7];
    for (int i = 0; i<7; i++) {
        SKTexture *temTexture = [SKTexture textureWithRect:CGRectMake(1.0/7*i, 0, 1.0/7, 1) inTexture:boomTexture];
        [boomFrameMutAry addObject:temTexture];
    }
    
    SKAction *frameAciton = [SKAction animateWithTextures:boomFrameMutAry timePerFrame:0.1];
    SKSpriteNode *boom = [[SKSpriteNode alloc] init];
    boom.position = position;
    
    boom.size = CGSizeMake(44, 49);
    [self addChild:boom];
    [boom runAction:frameAciton completion:^{
        [boom removeFromParent];
    }];
}

@end
