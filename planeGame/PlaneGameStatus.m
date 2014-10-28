//
//  PlaneGameStatus.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameStatus.h"

@implementation PlaneGameStatus{
    SKLabelNode *scoreLable;
}

- (instancetype)init
{
    self = [super init];
    self.zPosition = 1001;
    self.name = @"status";
    if (self) {
        [self initScoreLable];
        [self initPlayerHp];
    }
    return self;
}

-(void)initScoreLable{
    SKLabelNode *scoreTip = [[SKLabelNode alloc] initWithFontNamed:@"Arial Rounded MT Bold"];
    scoreTip.text = @"得分：";
    scoreTip.fontSize = 18;
    scoreTip.fontColor = [SKColor redColor];
    scoreTip.position = CGPointMake(ScreenWidth-70, ScreenHeight-25);
    [self addChild:scoreTip];
    
    NSString *scoreStr;
    if (_score == 0) {
        scoreStr = @"000";
    }else{
        scoreStr = [NSString stringWithFormat:@"%d",_score];
    }
    scoreLable = [[SKLabelNode alloc] initWithFontNamed:@"Arial Rounded MT Bold"];
    scoreLable.text = scoreStr;
    scoreLable.fontSize = 18;
    scoreLable.fontColor = [SKColor redColor];
    scoreLable.position = CGPointMake(ScreenWidth-30, ScreenHeight-25);
    [self addChild:scoreLable];
}

-(void)initPlayerHp{
    SKTexture *healthTexture = [SKTexture textureWithImageNamed:@"yao"];
    self.healths = 10;
    for (int i = 0; i<10; i++) {
        SKSpriteNode *healthSprite = [SKSpriteNode spriteNodeWithTexture:healthTexture];
        healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*i, healthSprite.size.height/2);
        healthSprite.name = @"health";
        healthSprite.zPosition = 1000;
        [self addChild:healthSprite];
    }
}

//public method
-(void)updateStatus{
    if (_healths>0) {
        [self enumerateChildNodesWithName:@"health" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        SKTexture *healthTexture = [SKTexture textureWithImageNamed:@"yao"];
        for (int i = 0; i<_healths; i++) {
            SKSpriteNode *healthSprite = [SKSpriteNode spriteNodeWithTexture:healthTexture];
            healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*i,  healthSprite.size.height/2);
            healthSprite.name = @"health";
            [self addChild:healthSprite];
        }
    }else if (_healths == 0){
        [self enumerateChildNodesWithName:@"health" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        NSLog(@"gameOver");
    }
}

-(void)updateBossHp{
    if (_bossHp>0) {
        [self enumerateChildNodesWithName:@"bossHp" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        SKTexture *healthTexture = [SKTexture textureWithImageNamed:@"hp"];
        for (int i = 0; i<self.bossHp; i++) {
            SKSpriteNode *healthSprite = [SKSpriteNode spriteNodeWithTexture:healthTexture];
            healthSprite.size = CGSizeMake(10, 10);
            if (i<10) {
                healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*i, ScreenHeight-healthSprite.size.height/2-10);
            }else{
                healthSprite.position = CGPointMake(healthSprite.size.width/2+healthSprite.size.width*(i-10), ScreenHeight-healthSprite.size.height*3/2-10);
            }
            healthSprite.name = @"bossHp";
            healthSprite.zPosition = 1000;
            [self addChild:healthSprite];
        }
    }else if (_bossHp == 0){
        [self enumerateChildNodesWithName:@"bossHp" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        NSLog(@"youWin~");
        
    }
}

-(void)updateScore{
    NSString *scoreStr;
    if (_score) {
        scoreStr = [NSString stringWithFormat:@"%d",_score];
    }
    scoreLable.text = scoreStr;
}


@end
