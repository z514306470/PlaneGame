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
#import "PlaneGameBomb.h"

@implementation PlaneGameBoss
-(instancetype)init{
    if (self = [super init]) {
        self.position = CGPointMake(ScreenWidth*4/5, ScreenHeight-70);
        self.name = @"boss";
        self.size = CGSizeMake(120, 72);
        
        [self initAction];
    }
    return self;
}

-(void)initAction{
    int repeatCount = 2;
    
    /*     之字形移动产生炸弹动画     */
    
    //frame action
    SKTexture *bossTexture = [SKTexture textureWithImageNamed:@"enemy_pig"];
    NSMutableArray* bossFrameMutAry = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i<10; i++) {
        SKTexture *temTexture = [SKTexture textureWithRect:CGRectMake(0.1*i, 0, 0.1, 1) inTexture:bossTexture];
        [bossFrameMutAry addObject:temTexture];
    }
    SKAction *frameAciton = [SKAction repeatActionForever:[SKAction animateWithTextures:bossFrameMutAry timePerFrame:0.2]];
    
    //move action
    SKAction *moveTo = [SKAction moveTo:CGPointMake(ScreenWidth/5, ScreenHeight-70) duration:2];
    SKAction *moveBack = [SKAction moveTo:CGPointMake(ScreenWidth*4/5, ScreenHeight-70) duration:2];
    SKAction *moveActionSequence = [SKAction sequence:@[moveTo,moveBack]];
    SKAction *repeatMove = [SKAction repeatAction:moveActionSequence count:repeatCount];
    
    //add bomb action
    SKAction *addBomb = [SKAction runBlock:^{
        PlaneGameBomb *bomb = [[PlaneGameBomb alloc] initWithImageNamed:@"boosbullet"];
        bomb.size = CGSizeMake(34, 34);
        CGPoint locationPoint = self.position;
        bomb.position = CGPointMake(locationPoint.x, locationPoint.y-10);
        SKAction *moveTo = [SKAction moveToY:0 duration:bomb.position.y/ScreenHeight*7];
        [bomb runAction:moveTo];
        
        [self.parent addChild:bomb];
    }];
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *addBombSequence = [SKAction sequence:@[addBomb,wait]];
    SKAction *repeatAddBomb = [SKAction repeatAction:addBombSequence count:4*repeatCount];
    
    SKAction *groupAction = [SKAction group:@[repeatMove,repeatAddBomb]];
    
    
    /*     移动到中部放大招动画     */
    SKAction *moveToMiddle = [SKAction moveToX:ScreenWidth/2 duration:1];
    SKAction *moveToCenter = [SKAction moveTo:CGPointMake(ScreenWidth/2, ScreenHeight/2) duration:0.5];
    //add bombs action
    SKAction *addBombs = [SKAction runBlock:^{
        [self.parent enumerateChildNodesWithName:@"bomb" usingBlock:^(SKNode *node, BOOL *stop) {
            [node removeFromParent];
        }];
        for (int i=0; i<3; i++) {
            for (int j=0; j<3; j++) {
                PlaneGameBomb *bomb = [[PlaneGameBomb alloc] initWithImageNamed:@"boosbullet"];
                bomb.size = CGSizeMake(34, 34);
                bomb.position = self.position;
                float xMove = ScreenWidth/2;
                float yMove = ScreenHeight/2;
                CGPoint desPoint = CGPointMake(self.position.x-xMove+j*xMove, self.position.y-yMove+i*yMove);
                SKAction *moveTo = [SKAction moveTo:CGPointMake(self.position.x-50+j*50, self.position.y-50+i*50) duration:0.5];
                SKAction *wait = [SKAction waitForDuration:1];
                SKAction *moveTo_ = [SKAction moveTo:desPoint duration:1.5];
                SKAction *moveToSequence = [SKAction sequence:@[moveTo,wait,moveTo_]];
            
                [bomb runAction:moveToSequence completion:^{
                    [bomb removeFromParent];
                }];
                [self.parent addChild:bomb];
            }
        }
    }];
    SKAction *moveBackTop = [SKAction moveTo:CGPointMake(ScreenWidth*4/5, ScreenHeight-70) duration:1];
    SKAction *moveToCenterSeq = [SKAction sequence:@[moveToMiddle,moveToCenter,addBombs,moveBackTop]];
    
    
    //综合所有动画，重复执行
    SKAction *allActionSeqRepeat = [SKAction repeatActionForever:[SKAction sequence:@[groupAction,moveToCenterSeq]]];
    
    //同步执行帧动画
    [self runAction:[SKAction group:@[frameAciton,allActionSeqRepeat]]];
    
}

@end
