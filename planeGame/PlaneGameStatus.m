//
//  PlaneGameStatus.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

#import "PlaneGameStatus.h"

@implementation PlaneGameStatus

- (instancetype)init
{
    self = [super init];
    if (self) {
        SKTexture *healthTexture = [SKTexture textureWithImageNamed:@"yao"];
        for (int i = 0; i<10; i++) {
            SKSpriteNode *healthSprite = [SKSpriteNode spriteNodeWithTexture:healthTexture];
            healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*i, healthSprite.size.height/2);
            healthSprite.zPosition = 1000;
            [self addChild:healthSprite];
        }
    }
    return self;
}

//public method
-(void)updateStatus{
    if (_healths) {
        [self removeChildrenInArray:[self children]];
        SKTexture *healthTexture = [SKTexture textureWithImageNamed:@"yao"];
        for (int i = 0; i<_healths; i++) {
            SKSpriteNode *healthSprite = [SKSpriteNode spriteNodeWithTexture:healthTexture];
            healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*i, healthSprite.size.height/2);
            [self addChild:healthSprite];
        }
    }
}

@end
