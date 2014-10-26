//
//  PlaneGameBomb.m
//  planeGame
//
//  Created by Qingqing on 14-10-26.
//  Copyright (c) 2014年 Qingqing. All rights reserved.
//
//获取设备物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

//获取设备物理高度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#import "PlaneGameBomb.h"

@implementation PlaneGameBomb

-(instancetype)init{
    if (self = [super initWithImageNamed:@"dilei"]) {
        self.size = CGSizeMake(24, 24);
        self.name = @"bomb";
    }
    return self;
}

@end
