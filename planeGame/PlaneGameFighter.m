//
//  PlaneGameFighter.m
//  planeGame
//
//  Created by Qingqing on 14-10-25.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameFighter.h"
#import "PlaneGameBullet.h"

@implementation PlaneGameFighter

-(instancetype)init{
    if (self = [super init]) {
        self.position = CGPointMake(ScreenWidth/2, 70);
        
        SKSpriteNode *fighter = [[SKSpriteNode alloc] initWithImageNamed:@"plane1"];
        fighter.name = @"fighter";
        fighter.size = CGSizeMake(40, 55);
        fighter.position = CGPointMake(0, 0);
        [self addChild:fighter];
        
        [self addBullet];
    }
    return self;
}

-(void)addBullet{
    SKTexture *bulletTexture = [SKTexture textureWithImageNamed:@"bullet"];
    SKAction *addBulletAction = [SKAction runBlock:^{
        PlaneGameBullet *temBullet = [[PlaneGameBullet alloc] initWithTexture:bulletTexture];
        temBullet.position = CGPointMake(self.position.x, self.position.y+35);
        float time = (ScreenHeight - temBullet.position.y)/ScreenHeight * 2;
        SKAction *fireAction = [SKAction moveToY:ScreenHeight duration:time];
        [temBullet runAction:fireAction completion:^{
            [temBullet removeFromParent];
        }];
        [self.parent addChild:temBullet];
    }];
    SKAction *waitAction = [SKAction waitForDuration:0.2];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[addBulletAction,waitAction]]]];
    
    
}

@end
