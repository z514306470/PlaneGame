//
//  PlaneGameBullet.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//

#import "PlaneGameBullet.h"

@implementation PlaneGameBullet

-(instancetype)initWithTexture:(SKTexture *)texture{
    if (self = [super initWithTexture:texture]) {
        self.name = @"bullet";
    }
    return self;
}

@end
