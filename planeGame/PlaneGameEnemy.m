//
//  PlaneGameEnemy.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

#import "PlaneGameEnemy.h"

//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation PlaneGameEnemy{
    NSMutableArray *enemyFrameMutAry;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        SKTexture *enemyTexture = [SKTexture textureWithImageNamed:@"enemy_duck"];
        enemyFrameMutAry = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i<10; i++) {
            SKTexture *temTexture = [SKTexture textureWithRect:CGRectMake(0.1*i, 0, 0.1, 1) inTexture:enemyTexture];
            [enemyFrameMutAry addObject:temTexture];
        }
        
        self.name = @"enemy";
        self.size = CGSizeMake(54, 54);
        self.position = CGPointMake(0, 500);
        SKAction *frameAciton = [SKAction repeatActionForever:[SKAction animateWithTextures:enemyFrameMutAry timePerFrame:0.2]];
        SKAction *moveTo = [SKAction moveTo:CGPointMake(ScreenWidth/2, 0) duration:500/ScreenHeight*7];
        [self runAction:[SKAction group:@[frameAciton,moveTo]]];
    }
    return self;
}

@end
