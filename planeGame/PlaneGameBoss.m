//
//  PlaneGameBoss.m
//  planeGame
//
//  Created by Qingqing on 14-10-27.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameBoss.h"

@implementation PlaneGameBoss
-(instancetype)init{
    if (self = [super init]) {
        SKTexture *bossTexture = [SKTexture textureWithImageNamed:@"enemy_pig"];
        NSMutableArray* bossFrameMutAry = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0; i<10; i++) {
            SKTexture *temTexture = [SKTexture textureWithRect:CGRectMake(0.1*i, 0, 0.1, 1) inTexture:bossTexture];
            [bossFrameMutAry addObject:temTexture];
        }
        self.position = CGPointMake(ScreenWidth/2, ScreenHeight-70);
        self.name = @"boss";
        self.size = CGSizeMake(120, 72);
        
        SKAction *frameAciton = [SKAction repeatActionForever:[SKAction animateWithTextures:bossFrameMutAry timePerFrame:0.2]];
        SKAction *moveTo = [SKAction moveTo:CGPointMake(ScreenWidth/2, ScreenHeight/2) duration:2];
        [self runAction:[SKAction group:@[frameAciton,moveTo]]];
        
    }
    return self;
}
@end
