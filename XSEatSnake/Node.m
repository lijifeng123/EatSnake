//
//  Node.m
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import "Node.h"

@implementation Node

+ (instancetype)nodeWithCoodinate:(CGPoint)coordinate{
    Node *node = [[Node alloc] init];
    node.coordinate = coordinate;
    return node;
}

@end
