//
//  PlaneGameBackground.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameBackground.h"

@implementation PlaneGameBackground

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initBackground];
    }
    return self;
}

-(void)initBackground{
    SKTexture *bgTexture = [SKTexture textureWithImageNamed:@"hhbg"];
    
    SKSpriteNode *mainBg = [SKSpriteNode spriteNodeWithTexture:bgTexture];
    mainBg.position = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    mainBg.size = CGSizeMake(ScreenWidth, ScreenHeight);
    [self addChild:mainBg];
    SKAction *bgRepeat = [SKAction sequence:@[
                                              [SKAction moveToY:ScreenHeight/2-ScreenHeight duration:7],
                                              [SKAction moveToY:ScreenHeight/2 duration:0]
                                              ]];
    [mainBg runAction:[SKAction repeatActionForever:bgRepeat]];
    
    
    SKSpriteNode *mainBg_1 = [SKSpriteNode spriteNodeWithTexture:bgTexture];
    mainBg_1.position = CGPointMake(ScreenWidth/2, ScreenHeight/2+ScreenHeight);
    mainBg_1.size = CGSizeMake(ScreenWidth, ScreenHeight);
    [self addChild:mainBg_1];
    SKAction *bgRepeat_1 = [SKAction sequence:@[
                                                [SKAction moveToY:ScreenHeight/2 duration:7],
                                                [SKAction moveToY:ScreenHeight/2+ScreenHeight duration:0]
                                                ]];
    [mainBg_1 runAction:[SKAction repeatActionForever:bgRepeat_1]];
}

@end
