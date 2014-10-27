//
//  PlaneGameEnemy.h
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

typedef enum : int {
    leftDirection = 0,
    rightDirection,
} appearDirection;

#import <SpriteKit/SpriteKit.h>

@interface PlaneGameEnemy : SKSpriteNode
@property(nonatomic) appearDirection direction;
- (instancetype)initWithDirection:(appearDirection)direction;
@end
