//
//  GameView.m
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import "GameView.h"
#import "Snake.h"

@implementation GameView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)drawRect:(CGRect)rect{
    
    if (!_snake.nodes.count) return;
    CGPoint center = _snake.nodes.firstObject.coordinate;
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [self drawHead:bezierPath center:center];
    [bezierPath setLineWidth:1];
    [[UIColor redColor] set];
    [bezierPath fill];
    
    CGRect nodeRect = CGRectZero;
    for (int i = 1; i < _snake.nodes.count; i ++) {
        center = _snake.nodes[i].coordinate;
        nodeRect = CGRectMake(center.x - NODEWIDTH/2, center.y - NODEWIDTH/2, NODEWIDTH, NODEWIDTH);
        bezierPath = [UIBezierPath bezierPathWithOvalInRect:nodeRect];
        UIColor *snakeBodyColor = [UIColor colorWithRed:130/255.0 green:190/255.0 blue:235/255.0 alpha:1];
        [snakeBodyColor setFill];
        [bezierPath fill];
    }
}

- (void)drawHead:(UIBezierPath *)bezierPath center:(CGPoint)center {
    CGFloat halfW = NODEWIDTH * 0.5;
    switch (_snake.direction) {
        case MoveDirectionRight:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x - halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y)];
            break;
        case MoveDirectionLeft:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y - halfW)];
            break;
        case MoveDirectionDown:
            [bezierPath moveToPoint:CGPointMake(center.x - halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x, center.y + halfW)];
            break;
        case MoveDirectionUp:
            [bezierPath moveToPoint:CGPointMake(center.x, center.y - halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x - halfW, center.y + halfW)];
            [bezierPath addLineToPoint:CGPointMake(center.x + halfW, center.y + halfW)];
            break;
        default:
            break;
    }
}

@end
