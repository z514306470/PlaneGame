//
//  PlaneGameStatus.h
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface PlaneGameStatus : SKNode
@property(nonatomic) int healths;
@property(nonatomic) int score;
@property(nonatomic) int bossHp;

-(void)updateStatus;
-(void)updateScore;
-(void)updateBossHp;
@end
