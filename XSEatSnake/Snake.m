//
//  Snake.m
//  XSEatSnake
//
//  Created by lijifeng on 2020/8/16.
//  Copyright © 2020 Musk Ronaldo Ming. All rights reserved.
//

#import "Snake.h"

@interface Snake ()
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,assign) NSInteger speed;
@property (nonatomic ,assign) CGPoint lastPoint;
@end

@implementation Snake

+ (instancetype)snake{
    Snake *snake = [Snake new];
    [snake initBody];
    return snake;
}

- (void)initBody{
    [self.nodes removeAllObjects];
    for (int i = 4 ; i >= 0; i --) {
        CGPoint point = CGPointMake(NODEWIDTH * (i + 0.5), NODEWIDTH * 0.5);
        [self.nodes addObject:[Node nodeWithCoodinate:point]];
    }
    _direction = MoveDirectionRight;
}

- (void)start{
    float time = 0.5 - _speed * 0.05;
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf move];
    }];
}

- (void)pause{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)move{
    Node *node = _nodes.lastObject;
    _lastPoint = node.coordinate;
    CGPoint center = _nodes.firstObject.coordinate;
    switch (_direction) {
        case MoveDirectionUp:
            center.y -= NODEWIDTH;
            break;
        case MoveDirectionLeft:
            center.x -= NODEWIDTH;
            break;
        case MoveDirectionDown:
            center.y += NODEWIDTH;
            break;
        case MoveDirectionRight:
            center.x += NODEWIDTH;
        default:
            break;
    }
    node.coordinate = center;
    [_nodes removeObject:node];
    [_nodes insertObject:node atIndex:0];
    (!_moveFinishBlock)?:_moveFinishBlock();
}

- (void)growUp{
    Node *node = [Node nodeWithCoodinate:_lastPoint];
    [_nodes addObject:node];
}

- (void)reset{
    [self initBody];
    _speed = 0;
    [self start];
}

- (void)levelUpWithSpeed:(NSInteger)speed{
    _speed = speed;
    [self pause];
    [self start];
}

- (void)setDirection:(MoveDirection)direction{
    if ((direction == MoveDirectionDown || direction == MoveDirectionUp) &&
        (_direction == MoveDirectionDown || _direction == MoveDirectionUp)) return;
    if ((direction == MoveDirectionRight || direction == MoveDirectionLeft) &&
        (_direction == MoveDirectionRight || _direction == MoveDirectionLeft)) return;
    _direction = direction;
}

- (NSMutableArray<Node *> *)nodes{
    if (!_nodes) {
        _nodes = [NSMutableArray array];
    }
    return _nodes;
}

@end
